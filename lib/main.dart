import 'package:flutter/material.dart';
import 'views/auth/login_page.dart'; // Giriş sayfanın adresi
import 'views/home/home_page.dart';  // Baha'nın olusturdugu(Navigasyon) sayfasının adresi.
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kampüs Güvenlik',
        debugShowCheckedModeBanner: false, // bandı kaldırdım.
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
        useMaterial3: true,
      ),
      // Uygulama benim giriş sayfamla açılacak.
      home: const LoginPage(), 
    );
  }
}

