// ignore_for_file: unused_import

import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/Anasayfa.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  Future<bool> oturumKontrol()async{
    var sp = await SharedPreferences.getInstance();

    String spKullaniciAdi=sp.getString("Kullaniciadi")??"kullanici adi yok";
    String spSifre=sp.getString("sifre")?? "Şifre yok";
   if (spKullaniciAdi=="admin" && spSifre=="123"){
    return true;

   }else{
    return false;

   }
  }
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:  FutureBuilder<bool>(
        future: oturumKontrol(),
        builder: (context,snapshot){
          if(snapshot.hasData){
            if(snapshot.data==true){
              return const Anasayfa();
            }else{
              return  const LoginEkrani(title: 'Giriş Ekranı',);
            }
          }else{
            return const CircularProgressIndicator();
          }
        },
        
      ),
    );
  }
}

class LoginEkrani extends StatefulWidget {
  const LoginEkrani({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<LoginEkrani> createState() => _LoginEkraniPageState();
}

class _LoginEkraniPageState extends State<LoginEkrani> {
  var tfKullaniciAdi = TextEditingController();
  var tfSifre = TextEditingController();
  var scaffoldKey = GlobalKey<ScaffoldState>();
  Future<void> girisKontrol() async {
    var ka = tfKullaniciAdi.text;
    var s = tfSifre.text;
    if (ka == "admin" && s == "123") {
      var sp = await SharedPreferences.getInstance();
      sp.setString("kullanıcıAdi", ka);
      sp.setString("sifre", s);
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const Anasayfa()));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Hatalı Kullanıcı Adı veya Şifresi")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: const Text("Anasayfa"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
             Padding(
              padding: const EdgeInsets.all(8.0),
              child:  TextField(
                controller: tfKullaniciAdi,
                decoration: const InputDecoration(hintText: "Kullanici İsmi"),
              ),
            ),
             Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                obscureText: true,
                controller: tfSifre,
                decoration: const InputDecoration(hintText: "Şifre"),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: () {
                  girisKontrol();
                },
                child: const Text("Giriş Yap")),
          ],
        ),
      ),
    );
  }
}
