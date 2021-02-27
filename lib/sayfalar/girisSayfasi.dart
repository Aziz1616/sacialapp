import 'package:flutter/material.dart';
import 'package:ogretmenimaayazilim/modeller/kullanici.dart';
import 'package:ogretmenimaayazilim/sayfalar/HesapOlustur.dart';
import 'package:provider/provider.dart';
import 'package:ogretmenimaayazilim/servisler/yetkilendirmeservisi.dart';
import 'package:ogretmenimaayazilim/servisler/firestoreServisi.dart';

class GirisSayfasi extends StatefulWidget {
  @override
  _GirisSayfasiState createState() => _GirisSayfasiState();
}

class _GirisSayfasiState extends State<GirisSayfasi> {
  final _formAnahtari = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldAnahtari = GlobalKey<ScaffoldState>();
  bool yukleniyor = false;
  String email, sifre;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldAnahtari,
        body: Stack(
          children: [
            _sayfaElemanlari(),
            _yuklemeAnimasyonu(),
          ],
        ));
  }

  _yuklemeAnimasyonu() {
    if (yukleniyor) {
      return Center(child: CircularProgressIndicator());
    } else {
      return SizedBox(
        height: 0,
      );
    }
  }

  Widget _sayfaElemanlari() {
    return Form(
      key: _formAnahtari,
      child: ListView(
        padding: EdgeInsets.only(left: 20, right: 20, top: 60),
        children: [
          Container(
            height: 100,
            child: Image(
              image: NetworkImage(
                  'https://cdn.pixabay.com/photo/2013/07/13/13/42/tux-161406_960_720.png'),
            ),
          ),
          SizedBox(
            height: 80,
          ),
          TextFormField(
            autocorrect: true,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              hintText: 'Email adresi giriniz',
              prefixIcon: Icon(Icons.mail),
              errorStyle: TextStyle(fontSize: 16),
            ),
            validator: (girilenDeger) {
              if (girilenDeger.isEmpty) {
                return 'Email alanı boş bırakılamaz!';
              } else if (!girilenDeger.contains('@')) {
                return 'Var olan bir email adresi giriniz';
              }
              return null;
            },
            onSaved: (girilenDeger) => email = girilenDeger,
          ),
          SizedBox(
            height: 40,
          ),
          TextFormField(
            obscureText: true,
            decoration: InputDecoration(
              hintText: 'Şifrenizi giriniz',
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
            onSaved: (girilenDeger) => sifre = girilenDeger,
          ),
          SizedBox(
            height: 40,
          ),
          Row(
            children: [
              Expanded(
                child: FlatButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => HesapOlustur()));
                  },
                  child: Text(
                    'Hesap Oluştur',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  color: Theme.of(context).primaryColor,
                ),
              ),
              SizedBox(
                width: 20,
              ),
              Expanded(
                child: FlatButton(
                  onPressed: _girisYap,
                  child: Text(
                    'Giriş Yap',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  color: Theme.of(context).primaryColorDark,
                ),
              )
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Center(
            child: Text('veya'),
          ),
          SizedBox(
            height: 20,
          ),
          Center(
            child: InkWell(
              onTap: _googleIleGiris,
              child: Text(
                'Google ile giriş yap',
                style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[600]),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Center(
            child: Text('Şifremi unuttum'),
          )
        ],
      ),
    );
  }

  void _girisYap() async {
    final _yetkilendirmeServisi =
        Provider.of<YetkilendirmeServisi>(context, listen: false);
    if (_formAnahtari.currentState.validate()) {
      _formAnahtari.currentState.save();
      setState(() {
        yukleniyor = true;
      });
      try {
        await _yetkilendirmeServisi.mailIleGiris(email, sifre);
      } catch (hata) {
        setState(() {
          yukleniyor = false;
        });
        uyariGoster(hataKodu: hata.code);
      }
    }
  }

  void _googleIleGiris() async {
    var _yetkilendirmeServisi =
        Provider.of<YetkilendirmeServisi>(context, listen: false);
    setState(() {
      yukleniyor = true;
    });
    try {
      Kullanici kullanici = await _yetkilendirmeServisi.googleIleGiris();
      if (kullanici != null) {
        Kullanici firestoreKullanici =
            await FireStoreServisi().kullaniciGetir(kullanici.id);
        if (firestoreKullanici == null) {
          FireStoreServisi().kullaniciOlustur(
              id: kullanici.id,
              email: kullanici.email,
              kullaniciAdi: kullanici.kullaniciAdi,
              fotoUrl: kullanici.fotoUrl);
        }
      }
    } catch (hata) {
      setState(() {
        yukleniyor = false;
      });
      uyariGoster(hataKodu: hata.code);
    }
  }

  uyariGoster({hataKodu}) {
    String hataMesaji;

    if (hataKodu == "user-not-found") {
      hataMesaji = "Böyle bir kullanıcı bulunmuyor";
    } else if (hataKodu == "invalid-email") {
      hataMesaji = "Girdiğiniz mail adresi geçersizdir";
    } else if (hataKodu == "wrong-password") {
      hataMesaji = "Girilen şifre hatalı";
    } else if (hataKodu == "user-disabled") {
      hataMesaji = "Kullanıcı engellenmiş";
    } else {
      hataMesaji = "Tanımlanamayan bir hata oluştu $hataKodu";
    }

    var snackBar = SnackBar(content: Text(hataMesaji));
    _scaffoldAnahtari.currentState.showSnackBar(snackBar);
  }
}
