import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/colors.dart';
import 'package:flutter_application_1/models/user.dart' as model;
import 'package:flutter_application_1/services/firebase_services.dart';

import 'app_drawer.dart';

ValueNotifier<int> as = ValueNotifier(0);
UserMethods a = UserMethods();
String currentusertype = '';

class HomePageClient extends StatefulWidget {
  final List<Widget> pages;
  final String usertype;

  const HomePageClient({Key? key, required this.pages, required this.usertype})
      : super(key: key);

  @override
  State<HomePageClient> createState() => _HomePageClientState();
}

class _HomePageClientState extends State<HomePageClient> {
  model.User? _user;

  @override
  void initState() {
    getDetails();
    super.initState();
  }

  void getDetails() async {
    try {
      DocumentSnapshot _snap = await FirebaseFirestore.instance
          .collection("Client")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get();
      print("snapshot recieved");
      //Map<String, dynamic> data = _snap.data() as Map<String, dynamic>;
      _user = model.User.fromsnap(_snap);
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      currentusertype = widget.usertype;
    });
    return Scaffold(
        bottomNavigationBar: ValueListenableBuilder(
            valueListenable: as,
            builder: (BuildContext context, int newindex, Widget? _) {
              return BottomNavigationBar(
                  type: BottomNavigationBarType.fixed,
                  currentIndex: newindex,
                  onTap: (value) => as.value = value,
                  unselectedItemColor: Colors.grey,
                  selectedItemColor: Colors.green,
                  items: [
                    const BottomNavigationBarItem(
                        icon: Icon(Icons.search), label: "Search"),
                    const BottomNavigationBarItem(
                        icon: Icon(Icons.mark_as_unread_rounded),
                        label: "Proposals"),
                    if (widget.usertype == "Client")
                      const BottomNavigationBarItem(
                          icon: Icon(Icons.add), label: "Add jobs")
                    else
                      const BottomNavigationBarItem(
                          icon: Icon(Icons.money), label: "Wallet"),
                    const BottomNavigationBarItem(
                        icon: Icon(Icons.message), label: "Messages"),
                    // const BottomNavigationBarItem(
                    //     icon: Icon(Icons.alarm), label: "alerts")
                  ]);
            }),
        drawer: StreamBuilder<Object>(
            stream: FirebaseFirestore.instance
                .collection(widget.usertype)
                .doc(FirebaseAuth.instance.currentUser!.uid)
                .snapshots(),
            builder: (context, snapshot) {
              //late model.User data1;
              // = model.User(
              //     email: "", password: "", usertype: "", name1: "", name2: "");
              if (snapshot.hasData) {
                model.User data1 =
                    model.User.fromsnap(snapshot.data as DocumentSnapshot);
                print(data1.uid);

                return Appdrawer(
                  name: data1.name1.isEmpty ? "..." : data1.name1,
                  approvalstatus: data1.approval,
                  usertype: widget.usertype,
                  uid: data1.uid,
                  file: data1.file.isEmpty ? "" : data1.file,
                );
              } else {
                return const Drawer(
                  child:
                      Center(child: CircularProgressIndicator(color: kGreen)),
                );
              }
            }),
        backgroundColor: Colors.white,
        appBar: AppBar(
          actions: const [
            SizedBox(
              width: 12,
            ),
            Icon(Icons.logout_rounded),
            SizedBox(
              width: 10,
            )
          ],
          iconTheme: const IconThemeData(color: Colors.green),
          toolbarHeight: 50,
          title: Center(
            child: Text(
              widget.usertype,
              style: const TextStyle(color: Colors.black),
            ),
          ),
          backgroundColor: Colors.white,
        ),
        body: ValueListenableBuilder(
            valueListenable: as,
            builder: (BuildContext ctx, int newpage, Widget? _) {
              return widget.pages[newpage];
            }));
  }
}
