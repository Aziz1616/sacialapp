import 'package:flutter/material.dart';
import 'package:ogretmenimaayazilim/modeller/kullanici.dart';
import 'package:ogretmenimaayazilim/servisler/yetkilendirmeservisi.dart';
import 'package:ogretmenimaayazilim/servisler/firestoreServisi.dart';
import 'package:provider/provider.dart';

class HesapOlustur extends StatefulWidget {
  @override
  _HesapOlusturState createState() => _HesapOlusturState();
}

class _HesapOlusturState extends State<HesapOlustur> {
  bool yukleniyor = false;
  final _formAnahtari = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldAnahtari = GlobalKey<ScaffoldState>();
  String kullaniciAdi, email, sifre;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldAnahtari,
      appBar: AppBar(
        title: Text('Hesap Oluştur'),
      ),
      body: ListView(
        children: [
          yukleniyor
              ? LinearProgressIndicator()
              : SizedBox(
                  height: 0,
                ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: _formAnahtari,
              child: Column(
                children: [
                  TextFormField(
                    autocorrect: true,
                    decoration: InputDecoration(
                      hintText: 'Kullanıcı adı giriniz',
                      labelText: 'Kullanıcı Adı:',
                      prefixIcon: Icon(Icons.person),
                      errorStyle: TextStyle(fontSize: 16),
                    ),
                    validator: (girilenDeger) {
                      if (girilenDeger.isEmpty) {
                        return 'Kullanıcı adı boş bırakılamaz!';
                      } else if (girilenDeger.trim().length < 4 ||
                          girilenDeger.trim().length > 12) {
                        return 'En az 4 en fazla 12 karakter';
                      }
                      return null;
                    },
                    onSaved: (girilenDeger) => kullaniciAdi = girilenDeger,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    autocorrect: true,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      hintText: 'Email adresi giriniz',
                      labelText: 'Email:',
                      prefixIcon: Icon(Icons.mail),
                      errorStyle: TextStyle(fontSize: 16),
                    ),
                    validator: (girilenDeger) {
                      if (girilenDeger.isEmpty) {
                        return 'Email alanı boş bırakılamaz!';
                      } else if (!girilenDeger.contains('@')) {
                        return 'Geçerli bir email adresi giriniz ';
                      }
                      return null;
                    },
                    onSaved: (girilenDeger) => email = girilenDeger,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: 'Şifrenizi giriniz',
                        labelText: 'Şifre:',
                        prefixIcon: Icon(Icons.lock),
                        errorStyle: TextStyle(fontSize: 16),
                      ),
                      validator: (girilenDeger) {
                        if (girilenDeger.isEmpty) {
                          return 'Şifre alanı boş bırakılamaz!';
                        } else if (girilenDeger.trim().length < 6) {
                          return 'Şifreniz en az 6 karakter olmalıdır!';
                        }
                        return null;
                      },
                      onSaved: (girilenDeger) => sifre = girilenDeger),
                  SizedBox(
                    height: 50,
                  ),
                  Container(
                    width: double.infinity,
                    child: FlatButton(
                      onPressed: _kullaniciOlustur,
                      child: Text(
                        'Hesap Oluştur',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      color: Theme.of(context).primaryColor,
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _kullaniciOlustur() async {
    final _yetkilendirmeServisi =
        Provider.of<YetkilendirmeServisi>(context, listen: false);
    var _formState = _formAnahtari.currentState;
    if (_formState.validate()) {
      _formState.save();
      setState(() {
        yukleniyor = true;
      });

      try {
        Kullanici kullanici =
            await _yetkilendirmeServisi.mailIleKayit(email, sifre);
        if (kullanici != null) {
          FireStoreServisi().kullaniciOlustur(
              id: kullanici.id, email: email, kullaniciAdi: kullaniciAdi);
        }
        Navigator.pop(context);
      } catch (hata) {
        setState(() {
          yukleniyor = false;
        });
        uyariGoster(hataKodu: hata.code);
      }
    }
  }

  // kullanıcıya daha anlaşılır bir uyarı mesajı göndermek için
  uyariGoster({hataKodu}) {
    String hataMesaji;

    if (hataKodu == "invalid-email") {
      hataMesaji = "Girdiğiniz mail adresi geçersizdir";
    } else if (hataKodu == "email-already-in-use") {
      hataMesaji = "Girdiğiniz mail kayıtlıdır";
    } else if (hataKodu == "weak-password") {
      hataMesaji = "Daha zor bir şifre tercih edin";
    }

    var snackBar = SnackBar(content: Text(hataMesaji));
    _scaffoldAnahtari.currentState.showSnackBar(snackBar);
  }
}
