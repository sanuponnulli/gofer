import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  String uid;
  String email;
  String name1;
  String name2;
  String password;
  String usertype;
  String about;
  String phonenumber;
  String companyname;
  String companydetails;
  String file;
  List jobs;
  List rating;
  User(
      {required this.email,
      required this.name1,
      required this.name2,
      required this.password,
      required this.usertype,
      required this.uid,
      this.about = "no data",
      this.phonenumber = 'no data',
      this.companyname = 'no data',
      this.companydetails = 'no data',
      this.file = "",
      this.rating = const [],
      this.jobs = const []});

  Map<String, dynamic> tojson() => {
        "email": email,
        "name1": name1,
        "name2": name2,
        "password": password,
        "usertype": usertype,
        "about": about,
        "phonenumber": phonenumber,
        "companyname": companyname,
        "companydetails": companydetails,
        "uid": uid,
        "file": file,
        "rating": rating
      };

  static User fromsnap(DocumentSnapshot snapshot) {
    if (snapshot.data() != null) {
      var snap = snapshot.data() as Map<String, dynamic>;
      final rating = snap["rating"];
      rating.sort;
      return User(
          email: snap["email"],
          name1: snap["name1"],
          name2: snap["name2"],
          password: snap["password"],
          usertype: snap["usertype"],
          about: snap["about"] ?? "",
          companydetails: snap["companydetails"] ?? "",
          phonenumber: snap["phone"] ?? "",
          companyname: snap["companyname"] ?? "",
          uid: snap["uid"],
          jobs: snap["jobs"] ?? [],
          rating: rating,
          file: snap["file"] ?? "");
    } else {
      return User(
          email: "",
          name1: "",
          name2: "",
          password: "",
          usertype: "",
          about: "",
          companydetails: "",
          phonenumber: "",
          companyname: "",
          uid: "",
          jobs: [],
          rating: [0],
          file: "");
    }
  }
}
