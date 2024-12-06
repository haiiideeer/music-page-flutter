import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:google_fonts/google_fonts.dart';

class MusicPage extends StatefulWidget {
  @override
  _MusicPageState createState() => _MusicPageState();
}

class _MusicPageState extends State<MusicPage> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  bool isPlaying = false;
  Duration? duration;
  Duration? position;
  String? currentSongTitle;

  final List<Map<String, String>> musicList = [
    {
      'title': 'Avenged Sevenfold - Seize The Day',
      'path': 'assets/music/Seize_The_Day.mp3',
    },
    {
      'title': 'My Chemical Romance - Disenchanted',
      'path': 'assets/music/Disenchanted.mp3',
    },
    {
      'title': 'My Chemical Romance - Helena',
      'path': 'assets/music/Helena.mp3',
    },
    {
      'title': 'Yung Kai - Blue',
      'path': 'assets/music/Yung_Kai-Blue.mp3',
    },
  ];

  void _playMusic(String path, String title) async {
    try {
      await _audioPlayer.setAsset(path);
      await _audioPlayer.play();
      setState(() {
        isPlaying = true;
        currentSongTitle = title;
      });

      _audioPlayer.playerStateStream.listen((state) {
        if (state.processingState == ProcessingState.completed) {
          int nextIndex = (musicList.indexOf(
                      musicList.firstWhere((music) => music['path'] == path)) +
                  1) %
              musicList.length;
          _playMusic(
              musicList[nextIndex]['path']!, musicList[nextIndex]['title']!);
        }
      });

      _audioPlayer.durationStream.listen((d) {
        setState(() {
          duration = d;
        });
      });
      _audioPlayer.positionStream.listen((p) {
        setState(() {
          position = p;
        });
      });
    } catch (e) {
      print('Error loading music: $e');
    }
  }

  void _stopMusic() async {
    await _audioPlayer.stop();
    setState(() {
      isPlaying = false;
      currentSongTitle = null;
    });
  }

  void _seekTo(double value) {
    final newPosition = Duration(seconds: value.toInt());
    _audioPlayer.seek(newPosition);
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Music Player', style: GoogleFonts.poppins()),
        backgroundColor: Colors.blueAccent,
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Card untuk musik yang sedang diputar
            if (currentSongTitle != null)
              Card(
                margin: EdgeInsets.symmetric(vertical: 10),
                color: Colors.blueGrey[900],
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: ListTile(
                  title: Text(
                    'Now Playing: $currentSongTitle',
                    style: GoogleFonts.poppins(color: Colors.white),
                  ),
                  subtitle: Text(
                    'Music is playing...',
                    style: GoogleFonts.poppins(color: Colors.white60),
                  ),
                  leading: Icon(Icons.music_note, color: Colors.white),
                ),
              ),
            SizedBox(height: 20),
            Text(
              'Daftar Musik:',
              style: GoogleFonts.poppins(
                  fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: musicList.length,
                itemBuilder: (context, index) {
                  final music = musicList[index];
                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 8),
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListTile(
                      title: Text(
                        music['title']!,
                        style: GoogleFonts.poppins(
                            fontSize: 18, fontWeight: FontWeight.w600),
                      ),
                      onTap: () {
                        if (isPlaying) {
                          _stopMusic();
                        }
                        _playMusic(music['path']!, music['title']!);
                      },
                      leading: Icon(Icons.music_note, color: Colors.blue),
                      trailing: isPlaying
                          ? IconButton(
                              icon: Icon(Icons.stop, color: Colors.red),
                              onPressed: _stopMusic,
                            )
                          : null,
                    ),
                  );
                },
              ),
            ),
            if (duration != null && position != null)
              Column(
                children: [
                  Slider(
                    min: 0.0,
                    max: duration!.inSeconds.toDouble(),
                    value: position!.inSeconds.toDouble(),
                    onChanged: (value) {
                      _seekTo(value);
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        position.toString().split('.').first.substring(2, 7),
                        style: GoogleFonts.poppins(),
                      ),
                      Text(
                        duration.toString().split('.').first.substring(2, 7),
                        style: GoogleFonts.poppins(),
                      ),
                    ],
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
