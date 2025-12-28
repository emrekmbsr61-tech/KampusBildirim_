import 'package:flutter/material.dart';
import 'report_page.dart'; //diğer sayfayı buraya tanıttım

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
      // Üst taraftaki Başlık Çubuğunu  buraya tasarladım
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
              // Navigator kullanarak kullanıcıyı diğer sayfaya atıyorum
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ReportPage()),
              );
              print("Kullanıcıyı güvenli bir şekilde ihbar sayfasına yönlendirdim.");
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
            color: Colors.grey[100],
            child: ListView(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 100), // Butonun altında kalmasın diye boşluk
              children: [
                // KART 1: ACİL DURUM
                Card(
                  elevation: 4,
                  color: Colors.red.shade50,
                  child: ListTile(
                    leading: const Icon(Icons.local_fire_department, color: Colors.red, size: 40),
                    title: const Text("YANGIN ALARMI", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red)),
                    subtitle: const Text("Konum: Merkez Kütüphane\nDurum: Ekipler Yönlendirildi (10:42)"),
                    isThreeLine: true,
                  ),
                ),
                const SizedBox(height: 12),

                // KART 2: GÜVENLİK
                const Card(
                  elevation: 2,
                  child: ListTile(
                    leading: Icon(Icons.security, color: Colors.blue, size: 40),
                    title: Text("Şüpheli Paket İhbarı", style: TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text("Konum: A Kapısı Girişi\nDurum: Güvenlik İnceliyor (09:15)"),
                    isThreeLine: true,
                  ),
                ),
                const SizedBox(height: 12),

                // KART 3: TRAFİK
                const Card(
                  elevation: 2,
                  child: ListTile(
                    leading: Icon(Icons.car_crash, color: Colors.orange, size: 40),
                    title: Text("Hatalı Park / Yol Kapalı", style: TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text("Konum: Otopark B Blok\nDurum: Çekici Bekleniyor (08:30)"),
                    isThreeLine: true,
                  ),
                ),
              ],
            ),
          ),

          // 2. KATMAN: Acil İhbar Butonu

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