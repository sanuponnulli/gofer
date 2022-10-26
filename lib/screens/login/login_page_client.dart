import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/colors.dart';
import 'package:flutter_application_1/constants/constants.dart';
import 'package:flutter_application_1/screens/home/admin_home.dart';
import 'package:flutter_application_1/screens/home/homepage_client.dart';
import 'package:flutter_application_1/screens/login/forgotpassword.dart';
import 'package:flutter_application_1/services/firebase_services.dart';

import '../addjobs/add_jobs.dart';
import '../messages/messages_screen.dart';
import '../proposals/proposals_client.dart';
import '../search/search_screen.dart';

class ClientLogin extends StatefulWidget {
  const ClientLogin({Key? key}) : super(key: key);

  @override
  State<ClientLogin> createState() => _ClientLoginState();
}

bool isloading = false;

class _ClientLoginState extends State<ClientLogin> {
  @override
  Widget build(BuildContext context) {
    List<Widget> pages = const [
      SearchScreen(),
      ClientProposals(),
      AddJob(),
      Messagescreen(),
      // SafeArea(child: Text("sss")
      // )
    ];
    TextEditingController emailcontroller = TextEditingController();
    TextEditingController passwordcontroller = TextEditingController();

    @override
    void dispose() {
      emailcontroller.dispose();
      passwordcontroller.dispose();
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
                    const Text("For Clients",
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
                    TextFields(
                      texteditingcontroller: passwordcontroller,
                      hint: 'Password',
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    MaterialButton(
                      onLongPress: () async {
                        if (emailcontroller.text == "admin@gmail.com") {
                          await FirebaseAuth.instance
                              .signInWithEmailAndPassword(
                                  email: emailcontroller.text,
                                  password: passwordcontroller.text)
                              .then((value) => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const AdminHome())));
                        }
                      },
                      shape: roundedRectangleBorder,
                      onPressed: () async {
                        setState(() {
                          isloading = true;
                        });
                        bool value = await signin(emailcontroller.text.trim(),
                            passwordcontroller.text.trim(), "Client");
                        if (value) {
                          // ignore: use_build_context_synchronously
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomePageClient(
                                      pages: pages, usertype: "Client")),
                              (route) => false);
                        } else {
                          const Center(
                            child: SnackBar(
                              content: Text("Some error occured try again"),
                              backgroundColor: Colors.amber,
                            ),
                          );
                        }
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
                              "Log In ",
                              style: TextStyle(color: Colors.white),
                            ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Forgotpassword()));
                        },
                        child: const Text(
                          "Forgot password !",
                          style: TextStyle(color: Colors.grey),
                        ),
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

class TextFields extends StatelessWidget {
  final String hint;
  final TextEditingController? texteditingcontroller;
  const TextFields({
    Key? key,
    required this.hint,
    this.texteditingcontroller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: texteditingcontroller,
      // ignore: body_might_complete_normally_nullable
      validator: (value) {
        log(texteditingcontroller!.value.toString());
        if (value!.isEmpty) {
          return "Enter a valid $hint";
        }
        //  else if (hint == "E mail" &&
        //     (EmailValidator.validate(texteditingcontroller!.text) == false)) {
        //   print(texteditingcontroller!.text);
        //   // final bool isValid = EmailValidator.validate(texteditingcontroller!.text);

        //   return "Enter a valid Eeee mail";
        // }
      },
      decoration: InputDecoration(
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(
                color: Colors.white,
              )),
          hintText: hint,
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: const BorderSide(color: kGreen, width: 2))),
    );
  }
}
