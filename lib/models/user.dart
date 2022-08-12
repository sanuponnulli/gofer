import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  String email;
  String name1;
  String name2;
  String password;
  String usertype;
  User(
      {required this.email,
      required this.name1,
      required this.name2,
      required this.password,
      required this.usertype});

  Map<String, dynamic> tojson() => {
        "email": email,
        "name1": name1,
        "name2": name2,
        "password": password,
        "usertype": usertype
      };

  static User fromsnap(DocumentSnapshot snapshot) {
    var snap = snapshot.data() as Map<String, dynamic>;
    return User(
        email: snap["email"],
        name1: snap["name1"],
        name2: snap["name2"],
        password: snap["password"],
        usertype: snap["usertype"]);
  }
}
