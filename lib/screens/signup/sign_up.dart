import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/colors.dart';
import 'package:flutter_application_1/constants/constants.dart';
import 'package:flutter_application_1/screens/addjobs/add_jobs.dart';
import 'package:flutter_application_1/screens/home/homepage_client.dart';
import 'package:flutter_application_1/screens/home/homepage_freelancer.dart';
import 'package:flutter_application_1/screens/login/login_page_client.dart';
import 'package:flutter_application_1/screens/messages/messages_screen.dart';

import '../proposals/proposals_client.dart';
import '../search/search_screen.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final items = ["Client", "Freelancer"];
  String dropdownvalue = "Freelancer";
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _firstname = TextEditingController();
  final TextEditingController _lastname = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password1 = TextEditingController();
  final TextEditingController _password2 = TextEditingController();
  @override
  Widget build(BuildContext context) {
    List<Widget> pages = const [
      SearchScreen(),
      ClientProposals(),
      AddJob(),
      Messagescreen(),
      SafeArea(child: Text("sss"))
    ];
    return Scaffold(
      backgroundColor: kGreen,
      body: SafeArea(
        child: ListView(
          children: [
            const SizedBox(
              height: 100,
              child: Center(child: Gofer()),
            ),
            Container(
              height: 800,
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(50))),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    child: Column(children: [
                      const SizedBox(
                        height: 30,
                      ),
                      DropdownButton(
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                          ),
                          value: dropdownvalue,
                          items: items.map((String items) {
                            return DropdownMenuItem(
                              value: items,
                              child: Text(items),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              dropdownvalue = newValue!;
                            });
                            // ignore: avoid_print
                            print(newValue);
                          }),
                      TextFields(
                        hint: "First Name",
                        texteditingcontroller: _firstname,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFields(
                        hint: "Last Name",
                        texteditingcontroller: _lastname,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      // TextFields(
                      //   hint: "E mail",
                      //   texteditingcontroller: _email,
                      // ),
                      TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Enter a valid Email";
                          } else if (EmailValidator.validate(_email.text) ==
                              false) {
                            //print(_email.text);
                            return "Enter a valid E mail";
                          }
                          return null;
                        },
                        controller: _email,
                        decoration: const InputDecoration(
                            focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: kGreen, width: 2)),
                            hintText: "E mail",
                            border: OutlineInputBorder()),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        // ignore: body_might_complete_normally_nullable
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Enter a valid Password";
                          }
                        },
                        controller: _password1,
                        decoration: const InputDecoration(
                            focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: kGreen, width: 2)),
                            hintText: "Password",
                            border: OutlineInputBorder()),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        // ignore: body_might_complete_normally_nullable
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Enter a valid Password";
                          } else if (value != _password1.text) {
                            // print(_password1.text);
                            // print(_password1.value);
                            return "Passwords dont match";
                          }
                        },
                        controller: _password2,
                        decoration: const InputDecoration(
                            focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: kGreen, width: 2)),
                            hintText: "Confirm Password",
                            border: OutlineInputBorder()),
                      ),
                      const SizedBox(
                        height: 60,
                      ),
                      MaterialButton(
                        shape: roundedRectangleBorder,
                        onPressed: () {
                          //print(_password1.text);
                          if (_formKey.currentState!.validate()) {
                            //print("validated");
                            // use the email provided here
                            if (_password1.text != _password2.text) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text("passwords dont match")));
                            } else {
                              log("saved");
                              signup(pages);
                            }
                          }
                        },
                        minWidth: 380,
                        height: 50,
                        color: kGreen,
                        child: const Text(
                          "Sign Up",
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ),
                      const SizedBox(
                        height: 200,
                      ),
                    ]),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future signup(List<Widget> pages) async {
    try {
      FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: _email.text.trim(), password: _password2.text.trim())
          .then((user) => FirebaseFirestore.instance
                  .collection(dropdownvalue)
                  .doc(user.user!.uid)
                  .set({
                "uid": user.user!.uid,
                "name1": _firstname.text,
                "name2": _lastname.text,
                "usertype": dropdownvalue,
                "password": _password2.text,
                "email": _email.text,
                "approved": false
              }))
          .then((value) => FirebaseFirestore.instance
              .collection("wallet")
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .set({"balance": 0}))
          .then((data) => dropdownvalue == "Client"
              ? Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) {
                  return HomePageClient(pages: pages, usertype: "Client");
                }))
              : Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) {
                  return const HomepageFreelancer();
                })));
    } on FirebaseAuthException catch (e) {
      print(e);
      return;
    }
  }
}
