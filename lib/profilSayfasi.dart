import 'package:flutter/material.dart';
import 'package:ogretmenimapp/gönderikarti.dart';

class ProfilSayfasi extends StatelessWidget {
  final String isimSoyad;
  final String kullaniciAdi;
  final String kapakresimLinki;
  final String profilResimLinki;

  const ProfilSayfasi(
      {Key key,
      this.isimSoyad,
      this.kullaniciAdi,
      this.kapakresimLinki,
      this.profilResimLinki})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[100],
        body: ListView(
          children: [
            Stack(
              children: [
                Container(
                  height: 230,
                  //color: Colors.yellow,
                ),
                Container(
                  height: 180,
                  decoration: BoxDecoration(
                    color: Colors.green,
                    image: DecorationImage(
                      image: NetworkImage(profilResimLinki),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  left: 20,
                  bottom: 0,
                  child: Hero(
                    tag: kullaniciAdi,
                    child: Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(60),
                        color: Colors.lightBlue,
                        border: Border.all(width: 2, color: Colors.white),
                        image: DecorationImage(
                          image: NetworkImage(kapakresimLinki),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 190,
                  left: 145,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        isimSoyad,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        kullaniciAdi,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                        ),
                      )
                    ],
                  ),
                ),
                Positioned(
                  top: 130,
                  right: 15,
                  child: Container(
                    width: 100,
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.grey[200],
                      border: Border.all(width: 2, color: Colors.white),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.add_circle,
                          size: 18,
                        ),
                        SizedBox(
                          width: 2,
                        ),
                        Text(
                          'Takip Et',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(
                    Icons.arrow_back,
                  ),
                  onPressed: () {
                    Navigator.pop(context, true);
                  },
                )
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              height: 75,
              color: Colors.grey.withOpacity(0.1),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  sayac('Takipci', '20 K'),
                  sayac('Takip', '500'),
                  sayac('Gönderi', '75'),
                ],
              ),
            ),
            GonderiKarti(
              profilResimLinki:
                  'https://cdn.pixabay.com/photo/2020/04/24/03/35/heart-5084900_960_720.jpg',
              gonderiResimLinki:
                  'https://cdn.pixabay.com/photo/2020/12/10/10/17/jasper-national-park-5819878_960_720.jpg',
              isimSoyad: 'Cony Sins',
              aciklama: 'Güzel foto',
              gecenSure: '2 saat önce',
            ),
          ],
        ));
  }

  Column sayac(String baslik, String sayi) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          sayi,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        SizedBox(
          height: 1,
        ),
        Text(
          baslik,
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }
}
