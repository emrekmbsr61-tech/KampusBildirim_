import 'package:flutter/material.dart';

// Burası projemizin girişi
// Ekranın durumu değişeceği için (yazı yazma vs.) StatefulWidget kullandım.
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // Kullanıcının e-posta ve şifre kutusuna yazdığı yazıları yakalamak için
  // bu "Controller"ları (kumandaları) tanımladım.git add .
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Temiz bir görünüm için beyaz arka plan
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0), // Kenarlardan yapışmasın diye boşluk bıraktım
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center, // Her şeyi ekranın ortasına topladım
            children: [
              
              // 1. BÖLÜM: LOGO VE GÜVENLİK SİMGESİ
              // Güvenlik uygulaması olduğu için kırmızı tonlarını tercih ettim.
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.redAccent.withOpacity(0.1), // Hafif kırmızı bir hale
                  shape: BoxShape.circle, // Yuvarlak tasarım
                ),
                child: const Icon(
                  Icons.shield_rounded, // Kalkan ikonu
                  size: 80,
                  color: Colors.redAccent,
                ),
              ),
              const SizedBox(height: 20),
              
              // Uygulamamızın İsmi ve Sloganı
              const Text(
                "Kampüs Güvenlik",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const Text(
                "Güvenli Kampüs, Güvenli Gelecek",
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
              const SizedBox(height: 40), // Araya biraz mesafe

              // 2. BÖLÜM: E-POSTA GİRİŞ ALANI
              TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: "Kurumsal E-posta", // Kullanıcı ne gireceğini bilsin
                  prefixIcon: const Icon(Icons.email_outlined), // Başına zarf ikonu koydum
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // 3. BÖLÜM: ŞİFRE GİRİŞ ALANI
              TextField(
                controller: _passwordController,
                obscureText: true, // Şifre gizli görünsün
                decoration: InputDecoration(
                  labelText: "Şifre",
                  prefixIcon: const Icon(Icons.lock_outline), // Başına kilit ikonu
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // 4. BÖLÜM: GİRİŞ YAP BUTONU
              SizedBox(
                width: double.infinity, // Buton ekranı yatayda kaplasın
                height: 50, // yüksekliği artırdım
                child: ElevatedButton(
                  onPressed: () {
                    // konsola not düşüyorum.
                    print("Giriş yapiliyor");
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.redAccent, // Ana rengimiz kırmızı
                    foregroundColor: Colors.white, // Yazı beyaz
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12), // Butonun köşeleri de uyumlu olsun
                    ),
                  ),
                  child: const Text(
                    "GİRİŞ YAP", 
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}