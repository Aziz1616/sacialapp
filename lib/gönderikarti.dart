import 'package:flutter/material.dart';

class GonderiKarti extends StatelessWidget {
  final String profilResimLinki;
  final String isimSoyad;
  final String gecenSure;
  final String gonderiResimLinki;
  final String aciklama;

  const GonderiKarti(
      {this.gonderiResimLinki,
      this.isimSoyad,
      this.gecenSure,
      this.profilResimLinki,
      this.aciklama});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Material(
        borderRadius: BorderRadius.circular(12),
        elevation: 1,
        child: Container(
          padding: EdgeInsets.all(15),
          width: double.infinity,
          height: 380,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12), color: Colors.white),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: Colors.indigo,
                            image: DecorationImage(
                              image: NetworkImage(profilResimLinki),
                              fit: BoxFit.cover,
                            )),
                      ),
                      SizedBox(
                        width: 7,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            isimSoyad,
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                          Text(
                            gecenSure,
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Icon(
                    Icons.more_vert,
                  )
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                aciklama,
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey),
              ),
              SizedBox(
                height: 10,
              ),
              Image.network(
                gonderiResimLinki,
                width: double.infinity,
                height: 200,
                fit: BoxFit.cover,
              ),
              SizedBox(
                height: 4,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ikonluButonlar(
                    ikonum: Icons.favorite,
                    yazi: 'Beğen',
                    fonksiyonum: () {
                      print('bağenildi');
                    },
                  ),
                  ikonluButonlar(
                    ikonum: Icons.comment,
                    yazi: 'Yorum yap',
                    fonksiyonum: () {
                      print('yorum yapıldı');
                    },
                  ),
                  FlatButton.icon(
                    onPressed: () {},
                    icon: Icon(
                      Icons.share,
                      color: Colors.grey,
                    ),
                    label: Text(
                      'Paylaş',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class ikonluButonlar extends StatelessWidget {
  final IconData ikonum;
  final String yazi;
  final fonksiyonum;
  ikonluButonlar({this.ikonum, this.yazi, this.fonksiyonum});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: InkWell(
        onTap: fonksiyonum,
        child: Container(
          padding: EdgeInsets.all(5),
          child: Row(
            children: [
              Icon(
                ikonum,
                color: Colors.grey,
              ),
              SizedBox(
                width: 7,
              ),
              Text(
                yazi,
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),
              )
            ],
          ),
        ),
      ),
    );
  }
}
