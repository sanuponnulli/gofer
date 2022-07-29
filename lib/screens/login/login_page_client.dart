import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_application_1/constants/colors.dart';
import 'package:flutter_application_1/constants/constants.dart';
import 'package:flutter_application_1/screens/home/homepage_client.dart';

import '../addjobs/add_jobs.dart';
import '../messages/messages_screen.dart';
import '../proposals/proposals_client.dart';
import '../search/search_screen.dart';

List<Widget> pages = const [
  SearchScreen(),
  ClientProposals(),
  AddJob(),
  Messagescreen(),
  SafeArea(child: Text("sss"))
];

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
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (ctx) => HomePageClient(
                                  pages: pages,
                                )));
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
      // ignore: body_might_complete_normally_nullable
      validator: (value) {
        print(texteditingcontroller!.value.toString());
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
          focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: kGreen, width: 2)),
          hintText: hint,
          border: OutlineInputBorder()),
    );
  }
}
