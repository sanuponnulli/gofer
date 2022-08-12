import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_1/models/user.dart' as models;
import 'package:flutter_application_1/screens/home/homepage_client.dart';

Future signin(String email, String password, String usertype) async {
  try {
    UserCredential userCredential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    late Map<String, dynamic> data;
    await FirebaseFirestore.instance
        .collection(usertype)
        .doc(userCredential.user!.uid)
        .get()
        .then((DocumentSnapshot doc) {
      data = doc.data() as Map<String, dynamic>;
    });

    print(data["usertype"]);
    if (data["usertype"] == usertype) {
      return true;
    } else {
      return false;
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
    print("error occured");
    print(e.toString());
    return false;
  }
}

class UserMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<models.User> getUserDetails() async {
    User currentuser = _auth.currentUser!;
    DocumentSnapshot snap =
        await _firestore.collection("User").doc(currentuser.uid).get();
    return models.User.fromsnap(snap);
  }
}
