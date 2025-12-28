import 'package:flutter/material.dart';

class ReportPage extends StatefulWidget {
  const ReportPage({super.key});

  @override
  State<ReportPage> createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  // Formun durumunu kontrol etmek için anahtar ekledik
  final _formKey = GlobalKey<FormState>();

  // Kullanıcının girdiği verileri tutan değişkenler
  String? _secilenTur;
  final TextEditingController _baslikController = TextEditingController();
  final TextEditingController _aciklamaController = TextEditingController();
  
  // Denemek için kullanılan değişkenler
  String _konumBilgisi = ""; 
  bool _konumYukleniyor = false;
  bool _fotoEklendi = false;

  // Bildirim türlerinin listesi
  final List<String> _turler = ['Güvenlik', 'Yangın', 'Sağlık', 'Trafik', 'Teknik Arıza'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Yeni Bildirim Oluştur"),
        backgroundColor: Colors.redAccent,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView( // Klavye açılınca ekran kayabilsin diye
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey, // Form anahtarını buraya bağladık
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              
              // 1. Bildirim türünü seçtiğimiz alan
              const Text("Bildirim Türü", style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              DropdownButtonFormField<String>(
                value: _secilenTur,
                decoration: InputDecoration(
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                  prefixIcon: const Icon(Icons.category_outlined),
                  hintText: "Seçiniz...",
                ),
                items: _turler.map((String tur) {
                  return DropdownMenuItem<String>(
                    value: tur,
                    child: Text(tur),
                  );
                }).toList(),
                onChanged: (deger) {
                  setState(() {
                    _secilenTur = deger;
                  });
                },
                // Seçilmezse hata vermesi için
                validator: (value) => value == null ? "Lütfen bir tür seçiniz" : null,
              ),
              const SizedBox(height: 20),

              // 2. Bildirim başlığının girildiği alan
              const Text("Başlık", style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              TextFormField(
                controller: _baslikController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                  prefixIcon: const Icon(Icons.title),
                  hintText: "Örn: Kütüphane önünde şüpheli paket",
                ),
                // Boşsa hata vermesi için
                validator: (value) {
                  if (value == null || value.isEmpty) return "Başlık boş bırakılamaz";
                  return null;
                },
              ),
              const SizedBox(height: 20),

              // 3.Bildirimin detaylarının yazıldığı açıklama alanı
              const Text("Açıklama", style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              TextFormField(
                controller: _aciklamaController,
                maxLines: 4, // 4 satır büyüklüğünde
                decoration: InputDecoration(
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                  hintText: "Detayları buraya yazınız...",
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) return "Açıklama boş bırakılamaz";
                  return null;
                },
              ),
              const SizedBox(height: 20),

              // 4. Konum ve fotoğraf yükleme alanları
              Row(
                children: [
                  // konum yeri
                  Expanded(
                    child: InkWell( 
                      onTap: _konumGetirSimulasyon,
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(10),
                          color: _konumBilgisi.isNotEmpty ? Colors.green.withOpacity(0.1) : Colors.white,
                        ),
                        child: Column(
                          children: [
                            if (_konumYukleniyor)
                              const SizedBox(
                                width: 20, height: 20, 
                                child: CircularProgressIndicator(strokeWidth: 2)
                              )
                            else
                              Icon(
                                _konumBilgisi.isNotEmpty ? Icons.check_circle : Icons.add_location_alt,
                                color: _konumBilgisi.isNotEmpty ? Colors.green : Colors.redAccent,
                              ),
                            const SizedBox(height: 5),
                            Text(
                              _konumBilgisi.isNotEmpty ? "Konum Alındı" : "Konum Ekle",
                              style: TextStyle(
                                color: _konumBilgisi.isNotEmpty ? Colors.green : Colors.black87,
                                fontSize: 12,
                                fontWeight: FontWeight.bold
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 15),
                  
                  // Foto ekleme butonu
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          _fotoEklendi = !_fotoEklendi;
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(10),
                          color: _fotoEklendi ? Colors.green.withOpacity(0.1) : Colors.white,
                        ),
                        child: Column(
                          children: [
                            Icon(
                              _fotoEklendi ? Icons.check_circle : Icons.add_a_photo,
                              color: _fotoEklendi ? Colors.green : Colors.blue,
                            ),
                            const SizedBox(height: 5),
                            Text(
                              _fotoEklendi ? "Foto Eklendi" : "Fotoğraf Ekle",
                              style: TextStyle(
                                color: _fotoEklendi ? Colors.green : Colors.black87,
                                fontSize: 12,
                                fontWeight: FontWeight.bold
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              
              // Konum seçildiyse ekranda kordinat bilgisi gösteriliyor
              if (_konumBilgisi.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    "📍 $_konumBilgisi",
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                    textAlign: Center,
                  ),
                ),

              const SizedBox(height: 30),

              // Bildirim gönderme butonu
              SizedBox(
                height: 55,
                child: ElevatedButton(
                  onPressed: _formuGonder,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.redAccent,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    elevation: 5,
                  ),
                  child: const Text(
                    "BİLDİRİMİ GÖNDER",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Yardımcı fonksiyonlarımız

  // Konum alma işlemini gerçek GPS yokmuş gibi taklit eder
  void _konumGetirSimulasyon() async {
    setState(() {
      _konumYukleniyor = true;
    });

    // Sanki GPS bağlanıyormuş gibi biraz bekletiyoruz
    await Future.delayed(const Duration(milliseconds: 1500));

    setState(() {
      _konumYukleniyor = false;
      _konumBilgisi = "38.7205° N, 35.4826° E (Kampüs İçi)";
    });
  }

  // Gönder butonuna basınca çalışır
  void _formuGonder() {
    // formdaki alanlar düzgün doldurulmuş mu diye kontrol ediyoruz
    if (_formKey.currentState!.validate()) {
      
      // Konum eklenmemişse kullanıcıyı uyarıyoruz
      if (_konumBilgisi.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Lütfen konum ekleyiniz.")),
        );
        return;
      }

      // Her şey doğru ilerlerse kullanıcıya başarılı mesajını gösteriyoruz
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text("Başarılı"),
          content: const Text("İhbarınız güvenlik birimlerine iletilmiştir. Teşekkür ederiz."),
          icon: const Icon(Icons.check_circle, color: Colors.green, size: 50),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(ctx).pop(); // Dialogu kapat
                Navigator.of(context).pop(); // Ana sayfaya geri dön
              },
              child: const Text("Tamam"),
            )
          ],
        ),
      );
    }
  }
}