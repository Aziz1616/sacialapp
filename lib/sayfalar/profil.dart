import 'package:flutter/material.dart';
import 'package:ogretmenimaayazilim/modeller/kullanici.dart';
import 'package:ogretmenimaayazilim/servisler/firestoreServisi.dart';
import 'package:ogretmenimaayazilim/servisler/yetkilendirmeServisi.dart';
import 'package:provider/provider.dart';

class Profil extends StatefulWidget {
  final String profilSahibiId;

  const Profil({Key key, this.profilSahibiId}) : super(key: key);

  @override
  _ProfilState createState() => _ProfilState();
}

class _ProfilState extends State<Profil> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
            'Profil',
            style: TextStyle(color: Colors.blueAccent),
          ),
          backgroundColor: Colors.grey[100],
          actions: [
            IconButton(
              icon: Icon(
                Icons.exit_to_app,
                color: Colors.black,
              ),
              onPressed: _cikisYap,
            ),
          ]),
      body: FutureBuilder<Object>(
          future: FireStoreServisi().kullaniciGetir(widget.profilSahibiId),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            }
            print('test');

            return ListView(
              children: <Widget>[
                _profilDetaylari(snapshot.data),
              ],
            );
          }),
    );
  }

  Widget _profilDetaylari(Kullanici profilData) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundColor: Colors.grey[300],
                radius: 50,
                backgroundImage: NetworkImage(profilData.fotoUrl),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _sosyalSayac(
                      baslik: 'Gönderiler',
                      sayi: 35,
                    ),
                    _sosyalSayac(
                      baslik: 'Takipçi',
                      sayi: 3,
                    ),
                    _sosyalSayac(
                      baslik: 'Takip',
                      sayi: 5,
                    )
                  ],
                ),
              )
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            profilData.kullaniciAdi,
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 5,
          ),
          Text(profilData.hakkinda),
          SizedBox(
            height: 25,
          ),
          _profiliDuzenleButon(),
        ],
      ),
    );
  }

  Widget _profiliDuzenleButon() {
    return Container(
      width: double.infinity,
      child: OutlineButton(
        onPressed: () {},
        child: Text('Profili Düzenle'),
      ),
    );
  }

  Widget _sosyalSayac({String baslik, int sayi}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          sayi.toString(),
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 2,
        ),
        Text(
          baslik,
          style: TextStyle(
            fontSize: 15,
          ),
        ),
      ],
    );
  }

  void _cikisYap() {
    Provider.of<YetkilendirmeServisi>(context, listen: false).cikisYap();
  }
}
