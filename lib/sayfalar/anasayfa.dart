import 'package:flutter/material.dart';
import 'package:ogretmenimaayazilim/sayfalar/akis.dart';
import 'package:ogretmenimaayazilim/sayfalar/ara.dart';
import 'package:ogretmenimaayazilim/sayfalar/yukle.dart';
import 'package:ogretmenimaayazilim/sayfalar/duyurular.dart';
import 'package:ogretmenimaayazilim/sayfalar/profil.dart';
import 'package:ogretmenimaayazilim/servisler/yetkilendirmeServisi.dart';
import 'package:provider/provider.dart';

class AnaSayfa extends StatefulWidget {
  @override
  _AnaSayfaState createState() => _AnaSayfaState();
}

class _AnaSayfaState extends State<AnaSayfa> {
  int _aktifSayfaNo = 0;
  PageController sayfaKumandasi;

  @override
  void initState() {
    super.initState();
    sayfaKumandasi = PageController();
  }

  @override
  void dispose() {
    sayfaKumandasi.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //String aktifKullaniciId =
    //Provider.of<YetkilendirmeServisi>(context, listen: false)
    // .aktifKullaniciId;

    return Scaffold(
      body: PageView(
        physics: NeverScrollableScrollPhysics(),
        onPageChanged: (acilanSayfaNo) {
          setState(() {
            _aktifSayfaNo = acilanSayfaNo;
          });
        },
        controller: sayfaKumandasi,
        children: <Widget>[
          Akis(),
          Ara(),
          Yukle(),
          Duyurular(),
          Profil(
              // profilSahibiId: aktifKullaniciId,
              )
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _aktifSayfaNo,
        selectedItemColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.grey[600],
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), title: Text("Akış")),
          BottomNavigationBarItem(
              icon: Icon(Icons.explore), title: Text("Keşfet")),
          BottomNavigationBarItem(
              icon: Icon(Icons.file_upload), title: Text("Yükle")),
          BottomNavigationBarItem(
              icon: Icon(Icons.notifications), title: Text("Duyurular")),
          BottomNavigationBarItem(
              icon: Icon(Icons.person), title: Text("Profil")),
        ],
        onTap: (secilenSayfaNo) {
          setState(() {
            sayfaKumandasi.jumpToPage(secilenSayfaNo);
          });
        },
      ),
    );
  }
}
