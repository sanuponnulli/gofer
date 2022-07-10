import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_application_1/constants/colors.dart';
import 'package:flutter_application_1/constants/constants.dart';
import 'package:flutter_application_1/screens/login/login_page_client.dart';

class FreelanceLogin extends StatelessWidget {
  const FreelanceLogin({Key? key}) : super(key: key);

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
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(50))),
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
                  const TextFields(
                    hint: 'E mail',
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const TextFields(
                    hint: 'Password',
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  MaterialButton(
                    shape: roundedRectangleBorder,
                    onPressed: () {},
                    minWidth: 380,
                    height: 50,
                    color: kGreen,
                    child: const Text(
                      "Log In",
                      style: TextStyle(color: Colors.white, fontSize: 16),
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
