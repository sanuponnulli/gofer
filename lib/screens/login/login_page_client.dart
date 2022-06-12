import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_application_1/constants/colors.dart';
import 'package:flutter_application_1/constants/constants.dart';
import 'package:flutter_application_1/screens/home/homepage.dart';

class ClientLogin extends StatelessWidget {
  const ClientLogin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(50))),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
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
                    onPressed: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (ctx) => HomePage()));
                      // Navigator.of(context).pushAndRemoveUntil(
                      //     MaterialPageRoute(builder: (ctx) => HomePage()),
                      //     (Route<dynamic> route) => false);
                    },
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
  const TextFields({
    Key? key,
    required this.hint,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
          focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: kGreen, width: 2)),
          hintText: hint,
          border: OutlineInputBorder()),
    );
  }
}
