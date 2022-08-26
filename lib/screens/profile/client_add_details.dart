import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/user.dart' as model;
import 'package:flutter_application_1/screens/home/homepage_client.dart';

import '../../constants/colors.dart';

class ClientAddDetails extends StatelessWidget {
  const ClientAddDetails({Key? key, required this.usertype}) : super(key: key);
  final String usertype;

  @override
  Widget build(BuildContext context) {
    TextEditingController about = TextEditingController();
    TextEditingController phone = TextEditingController();
    TextEditingController companyname = TextEditingController();
    TextEditingController companydetails = TextEditingController();

    return SafeArea(
        child: Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Text(
                "Profile",
                style: TextStyle(fontSize: 20),
              ),
              // TextFormField(
              //     decoration: const InputDecoration(
              //         hintText: "Nill  ",
              //         focusedBorder: OutlineInputBorder(
              //             borderSide: BorderSide(color: kGreen, width: 2)),
              //         border: OutlineInputBorder())),
              TextFormField(
                  controller: about,
                  maxLines: 10,
                  decoration: const InputDecoration(
                      hintText: "About ",
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: kGreen, width: 2)),
                      border: OutlineInputBorder())),
              TextFormField(
                  decoration: const InputDecoration(
                      hintText: "E mail",
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: kGreen, width: 2)),
                      border: OutlineInputBorder())),
              TextFormField(
                  controller: phone,
                  decoration: const InputDecoration(
                      hintText: "Phone number",
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: kGreen, width: 2)),
                      border: OutlineInputBorder())),
              TextFormField(
                  controller: companyname,
                  decoration: const InputDecoration(
                      hintText: "Company Name ",
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: kGreen, width: 2)),
                      border: OutlineInputBorder())),
              TextFormField(
                  controller: companydetails,
                  maxLines: 10,
                  decoration: const InputDecoration(
                      hintText: "Company details ",
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: kGreen, width: 2)),
                      border: OutlineInputBorder())),
              ElevatedButton(
                onPressed: () {
                  FirebaseFirestore.instance
                      .collection(usertype)
                      .doc(FirebaseAuth.instance.currentUser!.uid)
                      .update({
                    if (about.text != "") "about": about.text,
                    if (companyname.text != "") "companyname": companyname.text,
                    if (companydetails.text != "")
                      "companydetails": companydetails.text,
                    if (phone.text != "") "phone": phone.text
                  });
                  Navigator.pop(context);
                  // userdata=model.User()
                  // a.addUserdetails("Client", userdata);
                },
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(kGreen)),
                child: const Text(
                  "     Save     ",
                ),
              )
            ],
          ),
        ),
      ),
    ));
  }
}
