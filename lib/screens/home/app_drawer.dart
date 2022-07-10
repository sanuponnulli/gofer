import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/mystats/my_stats.dart';
import 'package:flutter_application_1/screens/profile/client_profile.dart';

class Appdrawer extends StatelessWidget {
  const Appdrawer({
    Key? key,
  }) : super(key: key);

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
            onTap: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (ctx) => const Clientprofile())),
            leading: const Icon(Icons.person),
            title: const Text("Profile"),
          ),
          ListTile(
            onTap: () => Navigator.of(context)
                .push(MaterialPageRoute(builder: (ctx) => MyStats())),
            leading: Icon(Icons.query_stats),
            title: Text("My stats"),
          ),
          ListTile(
            leading: Icon(Icons.web),
            title: Text("Reports"),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text("Settings"),
          ),
          ListTile(
            leading: Icon(Icons.question_mark_rounded),
            title: Text("Help&Support"),
          )
        ],
      ),
    );
  }
}
