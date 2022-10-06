import 'package:flutter/material.dart';
import 'package:flutter_application_1/complaints/admin_complaints.dart';
import 'package:flutter_application_1/screens/home/lookup.dart';
import 'package:flutter_application_1/screens/search/search_screen.dart';
import 'package:flutter_application_1/userrequests/admin_request.dart';

import '../messages/messages_screen.dart';

ValueNotifier<int> cc = ValueNotifier(0);

class AdminHome extends StatelessWidget {
  const AdminHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final adminpages = [
      const SearchScreen(),
      const ProfileLookup(),
      const Requestpage(),
      // SafeArea(child: Text("sss")),
      const Messagescreen(),
      const ComplaintsAdmin()
    ];
    return Scaffold(
        bottomNavigationBar: ValueListenableBuilder(
            valueListenable: cc,
            builder: (BuildContext context, int newindex, Widget? _) {
              return BottomNavigationBar(
                  currentIndex: newindex,
                  onTap: (value) => cc.value = value,
                  unselectedItemColor: Colors.grey,
                  selectedItemColor: Colors.green,
                  items: const [
                    BottomNavigationBarItem(
                        icon: Icon(Icons.search), label: "Search"),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.person_search),
                        label: "profile lookup"),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.mark_as_unread_rounded),
                        label: "Requests"),
                    // BottomNavigationBarItem(
                    //     icon: Icon(Icons.money), label: "Wallet"),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.message), label: "Messages"),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.error_outline_rounded),
                        label: "Complaints")
                  ]);
            }),
        // drawer: Appdrawer(
        //   usertype: "Admin",
        // ),
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
          title: const Center(
            child: Text(
              "Admin",
              style: TextStyle(color: Colors.black),
            ),
          ),
          backgroundColor: Colors.white,
        ),
        body: ValueListenableBuilder(
            valueListenable: cc,
            builder: (BuildContext ctx, int newpage, Widget? _) {
              return adminpages[newpage];
            }));
  }
}
