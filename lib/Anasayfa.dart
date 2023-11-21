import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter_application_1/main.dart';

class Anasayfa extends StatefulWidget {
  const Anasayfa({Key? key}) : super(key: key);

  @override
  State<Anasayfa> createState() => _AnasayfaState();
}

class _AnasayfaState extends State<Anasayfa> {
 String? spKullaniciAdi;
 String? spSifre;


  // ignore: non_constant_identifier_names
  Future<void> OturumBilgisiOku() async {
    var sp = await SharedPreferences.getInstance();

    setState(() {
      spKullaniciAdi = sp.getString("kullanıcıAdi") ?? "Kullanıcı Adı Yok";
      spSifre = sp.getString("sifre") ?? "Şifre Yok";
    });
  }

  @override
  void initState() {
    super.initState();
    OturumBilgisiOku();
    spKullaniciAdi = spKullaniciAdi;
    spSifre = spSifre;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Anasayfa"),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginEkrani(
                                title: '',
                              )));
                },
                icon: const Icon(Icons.exit_to_app)),
          ],
        ),
        body: Center(
          child: Column(
            children: [
              Text(
                "Kullanıcı Adı: $spKullaniciAdi",
                style: const TextStyle(
                  fontSize: 30,
                ),
              ),
              Text(
                "Sifre: $spSifre",
                style: const TextStyle(
                  fontSize: 30,
                ),
              ),
            ],
          ),
        ));
  }
}
