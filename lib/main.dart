import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ogretmenimapp/gönderikarti.dart';
import 'package:ogretmenimapp/profilSayfasi.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Öğretmenim',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: AnaSayfa(),
    );
  }
}

class AnaSayfa extends StatefulWidget {
  @override
  _AnaSayfaState createState() => _AnaSayfaState();
}

class _AnaSayfaState extends State<AnaSayfa> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.grey[100],
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.menu,
            color: Colors.blueAccent,
            size: 32,
          ),
          onPressed: () {},
        ),
        title: Text(
          'Öğretmenim',
          style: TextStyle(fontSize: 20, color: Colors.blueAccent),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(
              Icons.notifications,
              color: Colors.yellow[300],
              size: 32,
            ),
            onPressed: () {
              showModalBottomSheet(
                  context: context,
                  builder: (BuildContext context) {
                    return Column(
                      children: [
                        duyuru('Fatih beğendi', '3 dk önce'),
                        duyuru('İsmail Takip ediyor', '1 saat önce'),
                        duyuru('Aykut Yazıyor', '2 dk önce'),
                      ],
                    );
                  });
            },
          ),
        ],
      ),
      body: ListView(
        children: [
          Container(
            height: 100,
            decoration: BoxDecoration(
              color: Colors.grey[100],
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  offset: Offset(0.0, 3.0),
                  blurRadius: 5.0,
                ),
              ],
            ),
            child: ListView(
              //yatay kaydırma işlemi burda yapılıyor
              scrollDirection: Axis.horizontal,
              children: [
                profilKartiOlustur(
                    'Aziz',
                    'https://cdn.pixabay.com/photo/2018/07/29/23/16/football-3571336_960_720.jpg',
                    'Aziz TURHAN',
                    'https://cdn.pixabay.com/photo/2020/12/10/10/17/jasper-national-park-5819878_960_720.jpg'),
                profilKartiOlustur(
                    'fatih',
                    'https://cdn.pixabay.com/photo/2015/09/02/12/58/woman-918788_960_720.jpg',
                    'İsmail TURHAN',
                    'https://cdn.pixabay.com/photo/2020/12/10/10/17/jasper-national-park-5819878_960_720.jpg'),
                profilKartiOlustur(
                    'ismail',
                    'https://cdn.pixabay.com/photo/2016/11/21/14/53/adult-1845814_960_720.jpg',
                    'Aykut ALTAY',
                    'https://cdn.pixabay.com/photo/2020/12/10/10/17/jasper-national-park-5819878_960_720.jpg'),
                profilKartiOlustur(
                    'hasan',
                    'https://cdn.pixabay.com/photo/2014/04/12/14/59/portrait-322470_960_720.jpg',
                    'Hasan KILIK',
                    'https://cdn.pixabay.com/photo/2020/12/10/10/17/jasper-national-park-5819878_960_720.jpg'),
                profilKartiOlustur(
                    'mehmet',
                    'https://cdn.pixabay.com/photo/2016/04/13/19/20/binary-1327493_960_720.jpg',
                    'Mustafa ALTAY',
                    'https://cdn.pixabay.com/photo/2020/12/10/10/17/jasper-national-park-5819878_960_720.jpg'),
                profilKartiOlustur(
                    'mustafa',
                    'https://cdn.pixabay.com/photo/2014/09/17/20/03/profile-449912_960_720.jpg',
                    'Mehmet TURHAN',
                    'https://cdn.pixabay.com/photo/2020/12/10/10/17/jasper-national-park-5819878_960_720.jpg'),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          GonderiKarti(
            profilResimLinki:
                'https://cdn.pixabay.com/photo/2018/07/29/23/16/football-3571336_960_720.jpg',
            gonderiResimLinki:
                'https://cdn.pixabay.com/photo/2020/12/10/10/17/jasper-national-park-5819878_960_720.jpg',
            isimSoyad: 'Aziz TUrhan',
            aciklama: 'geçen seneden',
            gecenSure: '1 saat önce',
          ),
          GonderiKarti(
            profilResimLinki:
                'https://cdn.pixabay.com/photo/2016/11/21/14/53/adult-1845814_960_720.jpg',
            gonderiResimLinki:
                'https://cdn.pixabay.com/photo/2020/12/10/10/17/jasper-national-park-5819878_960_720.jpg',
            isimSoyad: 'İsmail Turhan',
            aciklama: 'Güzel foto',
            gecenSure: '2 saat önce',
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: null,
        backgroundColor: Colors.blueAccent,
        child: Icon(
          Icons.add_a_photo,
          color: Colors.white,
        ),
      ),
    );
  }

  Padding duyuru(String yazisi, String zamani) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            yazisi,
            style: TextStyle(fontSize: 15),
          ),
          Text(zamani),
        ],
      ),
    );
  }

  Widget profilKartiOlustur(String kullaniciAdi, String resimLinki,
      String isimSoyad, String kapakresimLinki) {
    return Material(
      child: InkWell(
        onTap: () async {
          bool donenVeri = await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) => ProfilSayfasi(
                  profilResimLinki: resimLinki,
                  kullaniciAdi: kullaniciAdi,
                  isimSoyad: isimSoyad,
                  kapakresimLinki: kapakresimLinki,
                ),
              ));
          if (donenVeri) {
            print('Profil Sayfasına Dönüldü');
          }
        },
        child: Padding(
          padding: const EdgeInsets.only(left: 8, right: 8),
          child: Column(
            children: [
              Stack(
                alignment: Alignment.topRight,
                children: [
                  Hero(
                    tag: kullaniciAdi,
                    child: Container(
                      width: 70,
                      height: 70,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                          width: 2,
                          color: Colors.grey,
                        ),
                        borderRadius: BorderRadius.circular(35),
                        image: DecorationImage(
                            image: NetworkImage(resimLinki), fit: BoxFit.cover),
                      ),
                    ),
                  ),
                  Container(
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(25),
                      border: Border.all(width: 2, color: Colors.white),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 4,
              ),
              Text(
                kullaniciAdi,
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
