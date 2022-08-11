import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'app_drawer.dart';

ValueNotifier<int> as = ValueNotifier(0);

class HomePageClient extends StatelessWidget {
  final List<Widget> pages;
  final String usertype;
  String? userdata;

  HomePageClient(
      {Key? key, required this.pages, required this.usertype, this.userdata})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(userdata);
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
                    if (usertype == "Client")
                      const BottomNavigationBarItem(
                          icon: Icon(Icons.add), label: "Add jobs")
                    else
                      const BottomNavigationBarItem(
                          icon: Icon(Icons.money), label: "Wallet"),
                    const BottomNavigationBarItem(
                        icon: Icon(Icons.message), label: "Messages"),
                    const BottomNavigationBarItem(
                        icon: Icon(Icons.alarm), label: "alerts")
                  ]);
            }),
        drawer: Appdrawer(
          name: "Text(",
          usertype: usertype,
        ),
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
              usertype,
              style: const TextStyle(color: Colors.black),
            ),
          ),
          backgroundColor: Colors.white,
        ),
        body: ValueListenableBuilder(
            valueListenable: as,
            builder: (BuildContext ctx, int newpage, Widget? _) {
              return pages[newpage];
            }));
  }
}
