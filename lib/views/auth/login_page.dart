import '../home/home_page.dart';
import 'package:flutter/material.dart';
import '../../data/user_data.dart'; // kullanıcıları getır
import 'register_page.dart'; // Kayıt Ol Sayfası
import 'forgot_pasword_page.dart'; // Şifre Sıfırlama Sayfası

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
                  String girilenEmail = _emailController.text.trim(); // trim() boşlukları temizler
                  String girilenSifre = _passwordController.text.trim();
                  // 2. Kutular boşsa uyarı verelim
                    if (girilenEmail.isEmpty || girilenSifre.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Lütfen e-posta ve şifreyi giriniz.")),
                      );
                      return; // İşlemi burada durdur
                    }

                    // 3. Kontrol Mantığı (Bayrak Yöntemi)
                    bool girisBasarili = false;

                    // user_data.dart dosyasındaki 'users' listesini kontrol ediyoruz.
                    // DİKKAT: Eğer senin listendeki değişken adı 'users' değilse burası kırmızı yanar.
                    // O zaman 'users' yazısını senin liste adınla değiştirmelisin.
                    for (var user in kayitliKullanicilar ) {
                      if (user['email'] == girilenEmail && user['password'] == girilenSifre) {
                        girisBasarili = true;
                        break; // Bulduk, döngüden çık
                      }
                    }

                    // 4. Sonuca göre hareket edelim
                    if (girisBasarili) {
                      // Şifre Doğru -> Ana Sayfaya Git
                      Navigator.pushReplacement( // Geri tuşuyla login'e dönmesin diye pushReplacement
                        context,
                        MaterialPageRoute(builder: (context) => const HomePage()),
                      );
                    } else {
                      // Şifre Yanlış -> Hata Mesajı Göster
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: const Text("Hatalı E-posta veya Şifre!"),
                          backgroundColor: Colors.redAccent,
                          behavior: SnackBarBehavior.floating,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        ),
                      );
                    }
                  },
                    style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.redAccent,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    "GİRİŞ YAP",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              // --- EKLENEN LİNKLER BURADA (HATASIZ HALİ) ---
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Şifremi Unuttum
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ForgotPasswordPage()),
                      );
                    },
                    child: const Text("Şifremi Unuttum", style: TextStyle(color: Colors.grey)),
                  ),

                  // Kayıt Ol
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const RegisterPage()),
                      );
                    },
                    child: const Text("Kayıt Ol", style: TextStyle(color: Colors.redAccent, fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}