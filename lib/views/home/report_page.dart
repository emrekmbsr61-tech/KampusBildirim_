import 'package:flutter/material.dart';

// İhbar sayfamızın ana giriş kısmı burası
class ReportPage extends StatefulWidget {
  const ReportPage({super.key});

  @override
  State<ReportPage> createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  // Kullanıcının seçtiği olay türünü bu değişkende tutuyoruz
  String? selectedType;

  // menüde çıkacak olay listesi
  final List<String> reportTypes = [
    'Acil Durum',
    'Yangın',
    'Kavga / Şiddet',
    'Sağlık Sorunu',
    'Şüpheli Paket',
    'Diğer'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Üst taraftaki başlık çubuğu
      appBar: AppBar(
        title: const Text("İhbar Bildir"),
        backgroundColor: Colors.redAccent, // Güvenlik uygulaması diye kırmızıyı seçtik
        foregroundColor: Colors.white, // Yazılar beyaz olsun
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0), // Kenarlardan biraz boşluk bıraktık yan yana olmasın
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Kullanıcıyı bilgi veren yazı
            const Text(
              "Lütfen olayla ilgili bilgileri aşağıya giriniz:",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20), // Araya boşluk koyduk

            // 1.kısım Olay türü seçme yeri(Açılan menü)
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(
                labelText: "Olay Türü", // Kutunun üzerindeki başlık olan yer
                border: OutlineInputBorder(), // Kutunun etrafını çizdiğimiz kısım
                prefixIcon: Icon(Icons.warning_amber_rounded), // Sol tarafa uyarı ikonu koyduk
              ),
              value: selectedType,
              // Listeyi buraya döngüyle aktardık
              items: reportTypes.map((String type) {
                return DropdownMenuItem<String>(
                  value: type,
                  child: Text(type),
                );
              }).toList(),
              // Seçim yapılınca değişkeni güncelliyoruz
              onChanged: (String? newValue) {
                setState(() {
                  selectedType = newValue;
                });
              },
            ),
            const SizedBox(height: 20),

            // 2.yer Açıklama Yazma kutusu
            const TextField(
              maxLines: 4, // Kutu boyutunu büyüttük
              decoration: InputDecoration(
                labelText: "Olayın Açıklaması",
                hintText: "Örn: Kütüphane önünde kavga var...",
                border: OutlineInputBorder(),
                alignLabelWithHint: true, // Yazının yukarıdan başlaması için
              ),
            ),
            const SizedBox(height: 30),

            // 3. kısım Gönder Butonu
            ElevatedButton.icon(
              onPressed: () {
                print("İhbar Gönderildi: $selectedType");
                
                // Kullanıcıya alttan bildirim gösteriyoruz
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("İhbarınız sisteme düştü!")),
                );
                
                // İşlem bitince bu sayfayı kapatıp haritaya dönüyoruz
                Navigator.pop(context);
              },
              icon: const Icon(Icons.send), // Gönder ikonu
              label: const Text("İHBARI GÖNDER"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red[700], // Koyu kırmızı yaptık
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 15), // Butonu biraz büyüttük
                textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}