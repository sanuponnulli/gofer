import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future signin(String email, String password, String usertype) async {
  try {
    UserCredential userCredential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    late Map<String, dynamic> data;
    await FirebaseFirestore.instance
        .collection("login")
        .doc(userCredential.user!.uid)
        .get()
        .then((DocumentSnapshot doc) {
      data = doc.data() as Map<String, dynamic>;
    });

    print(data["usertype"]);
    if (data["usertype"] == usertype) {
      return userCredential.user!.uid as String;
    } else {
      return;
    }
    // await FirebaseAuth.instance
    //     .signInWithEmailAndPassword(email: email, password: password)
    //     .then((value) {
    //   print(value.user!.uid);
    //   if (FirebaseFirestore.instance
    //           .collection(value.user!.uid)
    //           .doc("usertype") ==
    //       usertype) {
    //     print(value.user!.uid + "fghfgh");
    //     return true;
    //   } else {
    //     return false;
    //   }
    // });
  } catch (e) {
    print(e.toString());
    return;
  }
}
