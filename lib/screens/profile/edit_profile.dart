import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/user.dart' as model;
import 'package:flutter_application_1/screens/home/homepage_client.dart';

import '../../constants/colors.dart';

class EditProfile extends StatelessWidget {
  const EditProfile(
      {Key? key,
      required this.usertype,
      required this.phone,
      required this.companyname,
      required this.companydescription,
      required this.about1,
      required this.name1,
      required this.name2})
      : super(key: key);
  final String usertype,
      phone,
      companyname,
      companydescription,
      about1,
      name1,
      name2;

  @override
  Widget build(BuildContext context) {
    TextEditingController about = TextEditingController();
    TextEditingController phonecontroller = TextEditingController();
    TextEditingController companynamecontroller = TextEditingController();
    TextEditingController companydetailscontroller = TextEditingController();
    TextEditingController name1controller = TextEditingController();
    TextEditingController name2controller = TextEditingController();
    about.text = about1;
    phonecontroller.text = phone;
    companydetailscontroller.text = companydescription;
    companynamecontroller.text = companyname;
    name1controller.text = name1;
    name2controller.text = name2;

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
                "Edit Profile",
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(
                height: 20,
              ),
              // TextFormField(
              //     decoration: const InputDecoration(
              //         hintText: "Nill  ",
              //         focusedBorder: OutlineInputBorder(
              //             borderSide: BorderSide(color: kGreen, width: 2)),
              //         border: OutlineInputBorder())),
              TextFormField(
                  controller: name1controller,
                  decoration: InputDecoration(
                    filled: true, //<-- SEE HERE
                    fillColor: kGreen.withOpacity(.1),
                    hintText: "Firstname",
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: kGreen, width: 2)),
                    border: InputBorder.none,
                  )),
              SizedBox(
                height: 15,
              ),
              TextFormField(
                  controller: name2controller,
                  decoration: InputDecoration(
                    filled: true, //<-- SEE HERE
                    fillColor: kGreen.withOpacity(.1),
                    hintText: "Last Name",
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: kGreen, width: 2)),
                    border: InputBorder.none,
                  )),
              SizedBox(
                height: 15,
              ),
              TextFormField(
                  controller: about,
                  maxLines: 10,
                  decoration: InputDecoration(
                    filled: true, //<-- SEE HERE
                    fillColor: kGreen.withOpacity(.1),
                    hintText: "About",
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: kGreen, width: 2)),
                    border: InputBorder.none,
                  )),
              SizedBox(
                height: 15,
              ),
              // TextFormField(
              //     decoration: const InputDecoration(
              //         hintText: "E mail",
              //         focusedBorder: OutlineInputBorder(
              //             borderSide: BorderSide(color: kGreen, width: 2)),
              //         border: OutlineInputBorder())),
              TextFormField(
                  controller: phonecontroller,
                  decoration: InputDecoration(
                    filled: true, //<-- SEE HERE
                    fillColor: kGreen.withOpacity(.1),
                    hintText: "Phone number",
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: kGreen, width: 2)),
                    border: InputBorder.none,
                  )),
              SizedBox(
                height: 15,
              ),
              TextFormField(
                  controller: companynamecontroller,
                  decoration: InputDecoration(
                    filled: true, //<-- SEE HERE
                    fillColor: kGreen.withOpacity(.1),
                    hintText: "Company Name",
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: kGreen, width: 2)),
                    border: InputBorder.none,
                  )),
              SizedBox(
                height: 15,
              ),
              TextFormField(
                  controller: companydetailscontroller,
                  maxLines: 10,
                  decoration: InputDecoration(
                    filled: true, //<-- SEE HERE
                    fillColor: kGreen.withOpacity(.1),
                    hintText: "Company Details",
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: kGreen, width: 2)),
                    border: InputBorder.none,
                  )),
              SizedBox(
                height: 15,
              ),
              ElevatedButton(
                onPressed: () {
                  FirebaseFirestore.instance
                      .collection(usertype)
                      .doc(FirebaseAuth.instance.currentUser!.uid)
                      .update({
                    "name1": name1controller.text,
                    "name2": name2controller.text,
                    "about": about.text,
                    "companyname": companynamecontroller.text,
                    "companydetails": companydetailscontroller.text,
                    "phone": phonecontroller.text
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
