import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  
  // Kayıt için gerekli controllerlar.
  final TextEditingController _adSoyadController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _sifreController = TextEditingController();
  final TextEditingController _birimController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Kayıt Ol"),
        backgroundColor: Colors.redAccent,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const Icon(Icons.person_add, size: 80, color: Colors.redAccent),
              const SizedBox(height: 20),
              
              // 1. AD SOYAD
              TextFormField(
                controller: _adSoyadController,
                decoration: const InputDecoration(
                  labelText: "Ad Soyad",
                  prefixIcon: Icon(Icons.person),
                  border: OutlineInputBorder(),
                ),
                validator: (val) => val!.isEmpty ? "Ad soyad giriniz" : null,
              ),
              const SizedBox(height: 15),

              // 2. E-POSTA
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: "E-posta",
                  prefixIcon: Icon(Icons.email),
                  border: OutlineInputBorder(),
                ),
                validator: (val) => val!.isEmpty ? "E-posta giriniz" : null,
              ),
              const SizedBox(height: 15),

              // 3. BİRİM BİLGİSİ
              TextFormField(
                controller: _birimController,
                decoration: const InputDecoration(
                  labelText: "Birim / Bölüm",
                  prefixIcon: Icon(Icons.school),
                  border: OutlineInputBorder(),
                ),
                validator: (val) => val!.isEmpty ? "Birim bilgisi giriniz" : null,
              ),
              const SizedBox(height: 15),

              // 4. ŞİFRE
              TextFormField(
                controller: _sifreController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: "Şifre",
                  prefixIcon: Icon(Icons.lock),
                  border: OutlineInputBorder(),
                ),
                validator: (val) => val!.length < 3 ? "Şifre en az 3 karakter olmalı" : null,
              ),
              const SizedBox(height: 25),

              // 5. KAYIT OL BUTONU
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // Kayıt işlemi simülasyonu
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text("Kayıt Başarılı"),
                          content: const Text("Hesabınız oluşturuldu. Lütfen giriş yapınız."),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context); 
                                Navigator.pop(context); // Login sayfasına dönebiliriz
                              },
                              child: const Text("Tamam"),
                            )
                          ],
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.redAccent,
                    foregroundColor: Colors.white,
                  ),
                  child: const Text("KAYIT OL", style: TextStyle(fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}