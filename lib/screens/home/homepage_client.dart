import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/addjobs/add_jobs.dart';
import 'package:flutter_application_1/screens/search/search_screen.dart';

import '../proposals/proposals_client.dart';
import 'app_drawer.dart';

ValueNotifier<int> as = ValueNotifier(0);

class HomePageClient extends StatelessWidget {
  const HomePageClient({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> pages = const [
      SearchScreen(),
      ClientProposals(),
      AddJob(),
      SafeArea(child: Text("sss")),
      SafeArea(child: Text("sss"))
    ];
    return Scaffold(
        bottomNavigationBar: ValueListenableBuilder(
            valueListenable: as,
            builder: (BuildContext context, int newindex, Widget? _) {
              return BottomNavigationBar(
                  currentIndex: newindex,
                  onTap: (value) => as.value = value,
                  unselectedItemColor: Colors.grey,
                  selectedItemColor: Colors.green,
                  items: const [
                    BottomNavigationBarItem(
                        icon: Icon(Icons.search), label: "Search"),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.mark_as_unread_rounded),
                        label: "Proposals"),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.add), label: "Add jobs"),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.message), label: "Messages"),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.alarm), label: "alerts")
                  ]);
            }),
        drawer: Appdrawer(),
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
            child: const Text(
              "Client",
              style: TextStyle(color: Colors.black),
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
