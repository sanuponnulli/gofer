import 'dart:async';
import 'dart:ui';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_application_1/constants/colors.dart';
import 'package:flutter_application_1/screens/home/homepage_client.dart';
import 'package:flutter_application_1/screens/home/homepage_freelancer.dart';
import 'package:flutter_application_1/screens/login/login_page_client.dart';
import 'package:flutter_application_1/screens/login/login_page_freelance.dart';
import 'package:flutter_application_1/screens/signup/sign_up.dart';

import 'constants/constants.dart';
import 'screens/addjobs/add_jobs.dart';
import 'screens/messages/messages_screen.dart';
import 'screens/proposals/proposals_client.dart';
import 'screens/search/search_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          //scaffoldBackgroundColor: Color.fromARGB(153, 145, 145, 145),
          appBarTheme: const AppBarTheme(
              iconTheme: IconThemeData(color: kGreen),
              backgroundColor: Colors.white)),
      debugShowCheckedModeBanner: false,
      home: const Splash(),
    );
  }
}

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  void check() async {
    print("check running");
    final user = FirebaseAuth.instance.currentUser;

    if (user == null || user.email == "admin@gmail.com") {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Startpage()));
    } else {
      try {
        final result = await InternetAddress.lookup('example.com');
        if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
          print('connected');
        }
        final d = await FirebaseFirestore.instance
            .collection("Client")
            .doc(user.uid)
            .get();
        if (d.exists) {
          final type = d.data()!["usertype"];
          print(type);
          // ignore: use_build_context_synchronously
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => const HomePageClient(pages: [
                        SearchScreen(),
                        ClientProposals(),
                        AddJob(),
                        Messagescreen(),
                      ], usertype: "Client")));
        } else {
          final p = await FirebaseFirestore.instance
              .collection("Freelancer")
              .doc(user.uid)
              .get();
          final type = p.data()!["usertype"];
          print(type);
          // ignore: use_build_context_synchronously
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => const HomepageFreelancer()));

          // if (p.exists == false) {
          //   // ignore: use_build_context_synchronously
          //   Navigator.pushReplacement(context,
          //       MaterialPageRoute(builder: (context) => const Startpage()));
          // }
        }
      } on SocketException catch (_) {
        const snackBar = SnackBar(
            backgroundColor: Colors.red,
            content: Text('No internet connection'));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        // setState(() {});

        Timer(Duration(seconds: 3), () {
          check();
          print("Yeah, this line is printed after 3 seconds");
        });
        print('not connected');
      } catch (e) {
        print(e);
      }
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    // ScaffoldMessenger.of(context).hideCurrentSnackBar();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      // do something
      check();
      print("Build Completed");
    });
    return Scaffold(
      backgroundColor: kGreen,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: const [
          Center(
            child: Text(
              "gofer",
              style: TextStyle(
                  color: Colors.white, fontSize: 60, fontFamily: "Schyler"),
            ),
          ),
          Center(
              child: SizedBox(
            width: 20,
            height: 20,
            child: CircularProgressIndicator(
              color: Colors.white,
            ),
          ))
        ],
      ),
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
                        "Freelancer",
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
