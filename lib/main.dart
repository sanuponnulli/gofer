import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/colors.dart';
import 'package:flutter_application_1/screens/login/login_page_client.dart';
import 'package:flutter_application_1/screens/login/login_page_freelance.dart';
import 'package:flutter_application_1/screens/signup/sign_up.dart';

import 'constants/constants.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          appBarTheme: const AppBarTheme(
              iconTheme: IconThemeData(color: kGreen),
              backgroundColor: Colors.white)),
      debugShowCheckedModeBanner: false,
      home: const Startpage(),
    );
  }
}

class Startpage extends StatelessWidget {
  const Startpage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
          child: Stack(
        children: [
          Container(
            width: size.width,
            height: size.height,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [kGreen, kGreen, Color.fromARGB(255, 125, 223, 142)],
                end: FractionalOffset.bottomCenter,
              ),
              color: kGreen,
              // image: DecorationImage(
              //     image: AssetImage("assets/default.png"), fit: BoxFit.fill)
            ),
            child: Stack(
              children: [
                Positioned(
                  bottom: size.height - 200,
                  //top: 80,
                  left: 110,
                  child: const Text(
                    "gofer",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 60,
                        fontFamily: "Schyler"),
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: AlignmentDirectional.bottomCenter,
            child: ClipRRect(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(50)),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
                child: Container(
                  height: size.height * .6,
                  decoration: BoxDecoration(
                      color: Colors.white.withOpacity(.9),
                      borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(50))),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 300,
                        width: double.infinity,
                      ),
                      MaterialButton(
                        shape: roundedRectangleBorder,
                        onPressed: () {
                          bottomsheet(context);
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
                        height: 20,
                      ),
                      InkWell(
                        onTap: () => Navigator.of(context)
                            .push(MaterialPageRoute(builder: (ctx) {
                          return const SignUp();
                        })),
                        child: const Text(
                          "New to Gofer ? Sign Up",
                          style: TextStyle(color: kGreen),
                        ),
                      ),
                      const SizedBox()
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      )),
    );
  }

  Future<dynamic> bottomsheet(BuildContext context) {
    return showModalBottomSheet(
        shape: roundedRectangleBorder,
        backgroundColor: Colors.transparent,
        context: context,
        builder: (context) {
          return BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                      style: ButtonStyle(
                          minimumSize:
                              MaterialStateProperty.all(const Size(300, 90)),
                          shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18.0))),
                          backgroundColor: MaterialStateProperty.all(kGreen)),
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: ((context) => const ClientLogin())));
                      },
                      child: const Text(
                        "Client",
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold),
                      )),
                  const SizedBox(
                    height: 50,
                  ),
                  ElevatedButton(
                      style: ButtonStyle(
                          minimumSize:
                              MaterialStateProperty.all(const Size(300, 90)),
                          shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18.0))),
                          backgroundColor:
                              MaterialStateProperty.all(Colors.white)),
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: ((context) => const FreelanceLogin())));
                      },
                      child: const Text(
                        "Freelance",
                        style: TextStyle(
                            fontSize: 30,
                            color: kGreen,
                            fontWeight: FontWeight.bold),
                      ))
                ],
              ),
            ),
          );
        });
  }
}
