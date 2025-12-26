import 'package:flutter/material.dart';

// Burası uygulamanın ana sayfası, yani haritanın olduğu yer.
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Üst taraftaki Başlık Çubuğunu (AppBar) buraya tasarladım
      appBar: AppBar(
        title: const Text("Kampüs Haritası"),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        actions: [
          // Sağ üst köşeye çıkış yapma butonunu ekledim
          IconButton(
            icon: const Icon(Icons.exit_to_app, color: Colors.red),
            onPressed: () {

              print("Çıkış butonuna basıldı, işlem başlatılıyor...");
            },
          ),
        ],
      ),

      // Harita ile butonu üst üste koymak için Stack yapısını kullandım
      body: Stack(
        children: [
          // 1. KATMAN: Harita Alanı

          Container(
            color: Colors.grey[300],
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.map, size: 100, color: Colors.grey[600]),
                  const SizedBox(height: 10),
                  const Text(
                    "Harita Yükleniyor...",
                    style: TextStyle(fontSize: 18, color: Colors.black54),
                  ),
                ],
              ),
            ),
          ),

          // 2. KATMAN: Acil İhbar Butonu
          // Bu butonu sayfanın en altına sabitledim ki acil durumda hemen basılabilsin.
          Positioned(
            bottom: 30,
            left: 20,
            right: 20,
            child: ElevatedButton.icon(
              onPressed: () {
                // Buraya basınca ihbar sayfasına gidilecek
                print("İhbar sayfasına gidiliyor...");
              },
              icon: const Icon(Icons.warning_amber_rounded, size: 30),
              label: const Text("ACİL İHBAR BİLDİR"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red[700],
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}