import 'package:flutter/material.dart';
import 'report_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  // Gerçek uygulamada bu veriler veritabanından (Backend) gelir.
  final List<Map<String, dynamic>> bildirimler = [
    {
      "tur": "yangin",
      "baslik": "YANGIN ALARMI",
      "aciklama": "Merkez Kütüphane 2. Kat. Ekipler yönlendirildi.",
      "zaman": "10:42",
      "durum": "inceleniyor"
    },
    {
      "tur": "guvenlik",
      "baslik": "Şüpheli Paket",
      "aciklama": "A Kapısı girişinde sahipsiz çanta görüldü.",
      "zaman": "09:15",
      "durum": "acik"
    },
    {
      "tur": "saglik",
      "baslik": "Acil Sağlık Yardımı",
      "aciklama": "Yemekhanede bir öğrenci baygınlık geçirdi.",
      "zaman": "08:50",
      "durum": "cozuldu"
    },
    {
      "tur": "trafik",
      "baslik": "Hatalı Park",
      "aciklama": "Otopark B Blok girişi kapalı.",
      "zaman": "Dün 16:30",
      "durum": "cozuldu"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],

      // --- ÜST BAŞLIK  ---
      appBar: AppBar(
        title: const Text("Kampüs Haritası ve Bildirimler"),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        actions: [
          // ÇIKIŞ BUTONU
          IconButton(
            icon: const Icon(Icons.exit_to_app, color: Colors.red),
            onPressed: () {
              // Navigator.pop kullanıyoruz çünkü giriş sayfasından geldik, geri dönüyoruz.
              Navigator.pop(context);
            },
            tooltip: "Çıkış Yap",
          ),
        ],
      ),

      // --- GÖVDE (STACK YAPISI) ---
      body: Stack(
        children: [
          // 1. KATMAN: Bildirim Listesi
          // ListView.builder kullanarak listeyi otomatik oluşturuyoruz.
          ListView.builder(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 100),
            itemCount: bildirimler.length,
            itemBuilder: (context, index) {
              // Her bir bildirim için kart tasarımı fonksiyonunu çağırıyoruz
              return _buildBildirimKarti(bildirimler[index]);
            },
          ),

          // 2. KATMAN: Alttaki Sabit Buton
          Positioned(
            bottom: 30,
            left: 20,
            right: 20,
            child: ElevatedButton.icon(
              onPressed: () {
                // İhbar sayfasına git

                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ReportPage()),
                );
                print("İhbar sayfasına gidiliyor...");
              },
              icon: const Icon(Icons.warning_amber_rounded, size: 30),
              label: const Text("ACİL İHBAR BİLDİR"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red[700],
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 15),
                elevation: 5,
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

  // --- YARDIMCI TASARIM FONKSİYONU ---
  // Bu fonksiyon her bir bildirim verisini alıp şık bir Karta çevirir.
  Widget _buildBildirimKarti(Map<String, dynamic> bildirim) {
    // Türüne göre renk ve ikon seçimi
    Color renk;
    IconData ikon;

    switch (bildirim['tur']) {
      case 'yangin':
        renk = Colors.red;
        ikon = Icons.local_fire_department;
        break;
      case 'guvenlik':
        renk = Colors.blue;
        ikon = Icons.security;
        break;
      case 'saglik':
        renk = Colors.green;
        ikon = Icons.medical_services;
        break;
      case 'trafik':
        renk = Colors.orange;
        ikon = Icons.car_crash;
        break;
      default:
        renk = Colors.grey;
        ikon = Icons.notifications;
    }

    // Durum rengi (Açık: Kırmızı, Çözüldü: Yeşil)
    Color durumRengi = bildirim['durum'] == 'cozuldu' ? Colors.green : Colors.orange;
    if (bildirim['durum'] == 'acik') durumRengi = Colors.red;

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        contentPadding: const EdgeInsets.all(12),
        // Sol taraftaki İkon Kutusu
        leading: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: renk.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(ikon, color: renk, size: 30),
        ),
        // Başlık
        title: Text(
          bildirim['baslik'],
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        // Alt Açıklama ve Durum
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text(bildirim['aciklama']),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Saat
                Text(
                  bildirim['zaman'],
                  style: TextStyle(color: Colors.grey[600], fontSize: 12),
                ),
                // Durum Etiketi
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: durumRengi.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: durumRengi, width: 0.5),
                  ),
                  child: Text(
                    bildirim['durum'].toString().toUpperCase(),
                    style: TextStyle(
                      color: durumRengi,
                      fontWeight: FontWeight.bold,
                      fontSize: 10,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}