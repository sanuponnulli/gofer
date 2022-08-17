import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_1/models/user.dart' as models;

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

  Future<models.User> getUserDetails(String usertype) async {
    User currentuser = _auth.currentUser!;
    DocumentSnapshot snap =
        await _firestore.collection(usertype).doc(currentuser.uid).get();
    return models.User.fromsnap(snap);
  }

  Future<bool> addUserdetails(String usertype, models.User userdata) async {
    try {
      User currentuser = _auth.currentUser!;
      FirebaseFirestore.instance
          .collection(usertype)
          .doc(currentuser.uid)
          .set(userdata.tojson());
      return true;
    } catch (e) {
      return false;
    }
  }
}
// try {
//       FirebaseAuth.instance
//           .createUserWithEmailAndPassword(
//               email: _email.text.trim(), password: _password2.text.trim())
//           .then((user) => FirebaseFirestore.instance
//                   .collection(dropdownvalue)
//                   .doc(user.user!.uid)
//                   .set({
//                 "name1": _firstname.text,
//                 "name2": _lastname.text,
//                 "usertype": dropdownvalue,
//                 "password": _password2.text,
//                 "email": _email.text
//               }))