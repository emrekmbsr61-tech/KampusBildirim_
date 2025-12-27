import 'package:flutter/material.dart';

// Kullanıcıların ihbarda bulunabileceği kısım
class ReportPage extends StatefulWidget {
  const ReportPage({super.key});

  @override
  State<ReportPage> createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
// Başlık ve detay alanlarına yazılan bilgileri tutabilmel için controller oluşturdum.
  final TextEditingController _baslikController = TextEditingController();
  final TextEditingController _detayController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Acil İhbar Bildir"),
        backgroundColor: Colors.redAccent, // Acil olduğu için kırmızı seçtim
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Olayın ne olduğunu kısa ve öz almak için bu alanı yaptım.
            TextField(
              controller: _baslikController,
              decoration: const InputDecoration(
                labelText: "Olay Başlığı (Örn: Yangın, Kaza)",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),

            // Olayın detaylarını yazılması için bir kutu tasarladım
            TextField(
              controller: _detayController,
              maxLines: 4,
              decoration: const InputDecoration(
                labelText: "Olayın Detayı ve Konumu",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 24),

            // İhbarı gönderirken boş gönderilmesin diye engelleyen kısım
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  if (_baslikController.text.isEmpty) {
                    // Eğer başlık boşsa kullanıcıyı dolfur diye uyarıyorum
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Lütfen olay başlığını yazın!")),
                    );
                  } else {
                    // Gerekli alanlar doldurulduğunda ihbarın gönderilmeye hazır olduğu bildiriyorum
                    print("İhbar gönderilmeye hazır: ${_baslikController.text}");
                  }
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent),
                child: const Text("İHBARI GÖNDER", style: TextStyle(color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}