import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true, // Agar gradien tampak di belakang AppBar
      appBar: AppBar(
        backgroundColor: Colors.blue, // Mengubah warna navbar menjadi biru
        elevation: 0, // Menghilangkan bayangan pada navbar
        title: const Text(
          'Profil Saya',
          style: TextStyle(
              color: Colors.white), // Menyesuaikan warna teks pada navbar
        ),
        centerTitle: true,
      ),
      body: Container(
        decoration: const BoxDecoration(
          color: Colors.white, // Ganti gradien dengan warna putih
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 100),
                // Nama dan Deskripsi Singkat dalam Card
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  elevation: 8,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        // Memasukkan logo (CircleAvatar) ke dalam card
                        Hero(
                          tag: 'profile-pic',
                          child: CircleAvatar(
                            radius: 70,
                            backgroundImage: AssetImage('assets/pp.png'),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          'Haider Muhammad Iqbal',
                          style: GoogleFonts.roboto(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.black, // Ubah warna nama jadi hitam
                          ),
                        ),
                        const SizedBox(height: 8),
                        Card(
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          elevation: 4,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Mobile Application Engineer',
                              style: GoogleFonts.roboto(
                                fontSize: 16,
                                color: Colors
                                    .blue, // Mengubah warna teks menjadi biru
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                // Skills Section
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  elevation: 8,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'My Skills',
                          style: GoogleFonts.roboto(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black, // Ubah warna judul jadi hitam
                          ),
                        ),
                        const SizedBox(height: 20),
                        // Layout Grid untuk Skills
                        Wrap(
                          spacing: 20,
                          runSpacing: 20,
                          alignment: WrapAlignment.center,
                          children: [
                            _buildSkillIcon(Icons.code, 'PHP'),
                            _buildSkillIcon(Icons.language, 'HTML/CSS'),
                            _buildSkillIcon(Icons.flutter_dash, 'Flutter'),
                            _buildSkillIcon(Icons.web, 'JavaScript'),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                // Quote Inspiratif
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  elevation: 8,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Text(
                          '"maybe it s not your life that s hard, it s your lack of gratitude ( fast is not necessarily good, slow is not necessarily bad)"',
                          style: GoogleFonts.roboto(
                            fontSize: 16,
                            fontStyle: FontStyle.italic,
                            color:
                                Colors.black, // Ubah warna kutipan jadi hitam
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Widget untuk ikon skill
  Widget _buildSkillIcon(IconData icon, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.blue[50],
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 6,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          padding: const EdgeInsets.all(16),
          child: Icon(
            icon,
            color: Colors.blue,
            size: 40,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: GoogleFonts.roboto(
            fontSize: 16,
            color: Colors.blue,
          ),
        ),
      ],
    );
  }
}
