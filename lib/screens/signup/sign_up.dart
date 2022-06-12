import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_application_1/constants/colors.dart';
import 'package:flutter_application_1/constants/constants.dart';
import 'package:flutter_application_1/screens/login/login_page_client.dart';

class SignUp extends StatelessWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kGreen,
      body: SafeArea(
        child: ListView(
          children: [
            Container(
              height: 100,
              child: const Center(child: Gofer()),
            ),
            Container(
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(50))),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(children: [
                  const SizedBox(
                    height: 30,
                  ),
                  const TextFields(hint: "First Name"),
                  const SizedBox(
                    height: 10,
                  ),
                  const TextFields(hint: "Last Name"),
                  const SizedBox(
                    height: 10,
                  ),
                  const TextFields(hint: "E mail"),
                  const SizedBox(
                    height: 10,
                  ),
                  const TextFields(hint: "Password"),
                  const SizedBox(
                    height: 10,
                  ),
                  const TextFields(hint: "Confirm Password"),
                  const SizedBox(
                    height: 60,
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
                    height: 200,
                  ),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
