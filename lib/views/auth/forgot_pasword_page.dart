import 'package:flutter/material.dart';

// Şifre sıfırlama ekranımız.
// Ekranda dinamik bir değişim (sayaç artması, renk değişimi vb.) olmadığı için
// StatelessWidget kullandık.
class ForgotPasswordPage extends StatelessWidget {
  // bir "Controller" tanımlıyorum.
  final TextEditingController _emailController = TextEditingController();

  ForgotPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // --- 1. ÜST BAŞLIK ÇUBUĞU ---
      appBar: AppBar(
        title: const Text("Şifre Sıfırlama"),
        backgroundColor: Colors.redAccent, // Güvenlik teması olduğu için kırmızı tonu
        foregroundColor: Colors.white, // Yazı rengi beyaz
      ),

      // --- 2. SAYFA GÖVDESİ ---
      body: Padding(
        padding: const EdgeInsets.all(20.0), // Kenarlardan 20 birim boşluk bıraktık
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // Her şeyi ekranın ortasına hizala
          children: [
            
            // Kilit İkonu (Görsellik için)
            const Icon(Icons.lock_reset, size: 80, color: Colors.redAccent),
            const SizedBox(height: 20), // Araya boşluk

            // Bilgilendirme Yazısı
            const Text(
              "E-posta adresinizi girin, size şifre sıfırlama bağlantısı gönderelim.",
              textAlign: TextAlign.center, // Yazıyı ortala
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 30),
            
            // --- 3. E-POSTA GİRİŞ KUTUSU ---
            TextField(
              controller: _emailController, // Yazılan yazıyı bu değişkene aktardık
              decoration: const InputDecoration(
                labelText: "E-posta Adresi", 
                border: OutlineInputBorder(), // Kutunun etrafında çizgi olsun
                prefixIcon: Icon(Icons.email), // Başında zarf ikonu olsun
              ),
            ),
            const SizedBox(height: 20),
            
            // --- 4. GÖNDER BUTONU ---
            SizedBox(
              width: double.infinity, // Buton ekranı yatayda kaplasın
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  // Butona basılınca çalışacak kodlar:
                  
                  // Eğer e-posta kutusu boş değilse işlem yap
                  if (_emailController.text.isNotEmpty) {
                    
                    // A. Başarılı Mesajı Göster (Yeşil SnackBar)
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Sıfırlama bağlantısı e-postanıza gönderildi!"),
                        backgroundColor: Colors.green,
                      ),
                    );

                    // B. Giriş Ekranına Geri Dönsün
                    Navigator.pop(context); 
                  } else {
                    // Eğer kutu boşsa Uyarı Versin bize
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Lütfen e-posta giriniz.")),
                    );
                  }
                },
                // Butonun renk ve stil ayarları
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent,
                  foregroundColor: Colors.white,
                ),
                child: const Text("GÖNDER"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}