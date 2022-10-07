import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/colors.dart';
import 'package:flutter_application_1/constants/constants.dart';
import 'package:flutter_application_1/screens/home/admin_home.dart';
import 'package:flutter_application_1/screens/home/homepage_client.dart';
import 'package:flutter_application_1/screens/login/login_page_client.dart';
import 'package:flutter_application_1/services/firebase_services.dart';

import '../addjobs/add_jobs.dart';
import '../messages/messages_screen.dart';
import '../proposals/proposals_client.dart';
import '../search/search_screen.dart';

class Forgotpassword extends StatefulWidget {
  const Forgotpassword({Key? key}) : super(key: key);

  @override
  State<Forgotpassword> createState() => _ForgotpasswordState();
}

bool isloading = false;

class _ForgotpasswordState extends State<Forgotpassword> {
  @override
  Widget build(BuildContext context) {
    TextEditingController emailcontroller = TextEditingController();

    @override
    void dispose() {
      emailcontroller.dispose();

      super.dispose();
    }

    // void login() async {
    //   // setState(() {
    //   //   isloading = true;
    //   // });
    //   //print(isloading);

    //   bool value = await signin(emailcontroller.text.trim(),
    //       passwordcontroller.text.trim(), "Client");

    //   if (value) {
    //     //print(isloading);

    //     Navigator.push(
    //         context,
    //         MaterialPageRoute(
    //             builder: (context) =>
    //                 HomePageClient(pages: pages, usertype: "Client")));
    //   } else {
    //     const Center(
    //       child: SnackBar(
    //         content: Text("Some error occured try again"),
    //         backgroundColor: Colors.amber,
    //       ),
    //     );
    //     setState(() {
    //       isloading = false;
    //     });
    //   }
    // }

    return Scaffold(
      backgroundColor: kGreen,
      body: SafeArea(
          child: ListView(
        children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Center(
              child: Gofer(),
            ),
          ),

          Container(
            height: MediaQuery.of(context).size.height,
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(50))),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const Text("Reset password",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontFamily: "Schyler")),
                    const SizedBox(
                      height: 50,
                    ),
                    TextFields(
                      hint: 'E mail',
                      texteditingcontroller: emailcontroller,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    MaterialButton(
                      shape: roundedRectangleBorder,
                      onPressed: () async {
                        setState(() {
                          isloading = true;
                        });
                        await FirebaseAuth.instance
                            .sendPasswordResetEmail(
                                email: emailcontroller.text.trim())
                            .then((value) => Navigator.pop(context));

                        setState(() {
                          isloading = false;
                        });
                      },
                      minWidth: 380,
                      height: 50,
                      color: kGreen,
                      child: isloading
                          ? const CircularProgressIndicator(
                              color: Colors.white,
                            )
                          : const Text(
                              "Reset password",
                              style: TextStyle(color: Colors.white),
                            ),
                    ),
                    Container(
                      height: 400,
                      // color: isloading ? Colors.amber : Colors.black,
                    ),
                  ],
                ),
              ),
            ),
          )
          // Divider(
          //   color: kGreen,
          //   height: 15,
          // )
        ],
      )),
    );
  }
}

class Gofer extends StatelessWidget {
  const Gofer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Text(
      "gofer",
      style:
          TextStyle(color: Colors.white, fontSize: 40, fontFamily: "Schyler"),
    );
  }
}
