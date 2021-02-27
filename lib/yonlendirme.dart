import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ogretmenimaayazilim/modeller/kullanici.dart';
import 'package:ogretmenimaayazilim/servisler/yetkilendirmeservisi.dart';
import 'package:ogretmenimaayazilim/sayfalar/anasayfa.dart';
import 'package:ogretmenimaayazilim/sayfalar/girissayfasi.dart';
import 'package:provider/provider.dart';

class Yonlendirme extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _yetkilendirmeServisi =
        Provider.of<YetkilendirmeServisi>(context, listen: false);

    return StreamBuilder(
        stream: _yetkilendirmeServisi.durumTakipcisi,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Scaffold(body: Center(child: CircularProgressIndicator()));
          }

          if (snapshot.hasData) {
            Kullanici aktifKullanici = snapshot.data;
            _yetkilendirmeServisi.aktifKullaniciId = aktifKullanici.id;
            return AnaSayfa();
          } else {
            return GirisSayfasi();
          }
        });
  }
}
