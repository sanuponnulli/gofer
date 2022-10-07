import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/colors.dart';
import 'package:flutter_application_1/constants/constants.dart';
import 'package:flutter_application_1/screens/home/homepage_freelancer.dart';

import 'package:flutter_application_1/screens/login/login_page_client.dart';
import 'package:flutter_application_1/services/firebase_services.dart';

import 'forgotpassword.dart';

class FreelanceLogin extends StatefulWidget {
  const FreelanceLogin({Key? key}) : super(key: key);

  @override
  State<FreelanceLogin> createState() => _FreelanceLoginState();
}

bool isloading = false;

class _FreelanceLoginState extends State<FreelanceLogin> {
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();

  @override
  void dispose() {
    emailcontroller.dispose();
    passwordcontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: kGreen,
      body: SafeArea(
          child: ListView(
        children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Center(
              child: Text(
                "gofer",
                style: TextStyle(
                    color: Colors.white, fontSize: 40, fontFamily: "Schyler"),
              ),
            ),
          ),

          Container(
            height: size.height,
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(50))),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  const Text("For Freelancers",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontFamily: "Schyler")),
                  const SizedBox(
                    height: 50,
                  ),
                  TextFields(
                    texteditingcontroller: emailcontroller,
                    hint: 'E mail',
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
                    shape: roundedRectangleBorder,
                    onPressed: () async {
                      setState(() {
                        isloading = true;
                      });

                      bool value = await signin(emailcontroller.text.trim(),
                          passwordcontroller.text.trim(), "Freelancer");
                      if (value) {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: ((context) =>
                                const HomepageFreelancer())));
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

                    // Navigator.of(context).push(MaterialPageRoute(
                    //     builder: ((context) => const HomepageFreelancer())));

                    minWidth: 380,
                    height: 50,
                    color: kGreen,
                    child: isloading
                        ? CircularProgressIndicator(
                            color: Colors.white,
                          )
                        : const Text(
                            "Log In",
                            style: TextStyle(color: Colors.white, fontSize: 16),
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
                  const SizedBox(
                    height: 400,
                  ),
                ],
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
