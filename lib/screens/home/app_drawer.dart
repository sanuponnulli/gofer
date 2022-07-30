import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/mystats/my_stats.dart';
import 'package:flutter_application_1/screens/profile/client_profile.dart';
import 'package:flutter_application_1/screens/profile/freelancer_profile.dart';

class Appdrawer extends StatelessWidget {
  final String usertype;
  const Appdrawer({Key? key, required this.usertype}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          const DrawerHeader(
              decoration: BoxDecoration(color: Colors.white),
              child: ListTile(
                subtitle: Text(
                  "Client",
                ),
                title: Text(
                  "Name",
                  style: TextStyle(fontSize: 20),
                ),
                leading: CircleAvatar(
                  backgroundColor: Colors.amber,
                ),
              )),
          ListTile(
            onTap: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (ctx) => usertype == "Client"
                    ? const Clientprofile()
                    : const FreelancerProfile())),
            leading: const Icon(Icons.person),
            title: const Text("Profile"),
          ),
          ListTile(
            onTap: () => Navigator.of(context)
                .push(MaterialPageRoute(builder: (ctx) => const MyStats())),
            leading: const Icon(Icons.query_stats),
            title: const Text("My stats"),
          ),
          const ListTile(
            leading: Icon(Icons.web),
            title: Text("Reports"),
          ),
          const Divider(),
          const ListTile(
            leading: Icon(Icons.settings),
            title: Text("Settings"),
          ),
          const ListTile(
            leading: Icon(Icons.question_mark_rounded),
            title: Text("Help&Support"),
          )
        ],
      ),
    );
  }
}
