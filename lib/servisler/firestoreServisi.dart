import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ogretmenimaayazilim/modeller/kullanici.dart';

//firestore kayıt yapmak için kullanınacak olan servistir
class FireStoreServisi {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final DateTime zaman = DateTime.now();

  Future<void> kullaniciOlustur({id, email, kullaniciAdi, fotoUrl = ""}) async {
    await _firestore.collection("kullanicilar").doc(id).set({
      "kullaniciAdi": kullaniciAdi,
      "email": email,
      "fotoUrl": fotoUrl,
      "hakkinda": " ",
      "olusturulmaZamani": zaman
    });
  }

//kullanıcının ilk kez mi girş yaptığını kontrol eder.
  Future<Kullanici> kullaniciGetir(id) async {
    DocumentSnapshot doc =
        await _firestore.collection('kullanicilar').doc(id).get();

    if (doc.exists) {
      Kullanici kullanici = Kullanici.dokumandanUret(doc);
      return kullanici;
    }
    return null;
  }
}
