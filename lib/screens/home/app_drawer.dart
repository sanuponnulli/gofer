import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/mystats/my_stats.dart';
import 'package:flutter_application_1/screens/profile/client_profile.dart';
import 'package:flutter_application_1/screens/profile/common_profile.dart';
import 'package:flutter_application_1/screens/profile/freelancer_profile.dart';

class Appdrawer extends StatelessWidget {
  final String usertype;
  final String name;
  final String uid;
  final String file;
  const Appdrawer(
      {Key? key,
      required this.usertype,
      required this.name,
      required this.uid,
      this.file = ""})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
              decoration: const BoxDecoration(color: Colors.white),
              child: ListTile(
                subtitle: const Text(
                  "Client",
                ),
                title: Text(
                  name,
                  style: const TextStyle(fontSize: 20),
                ),
                leading: file == ""
                    ? const CircleAvatar(
                        backgroundColor: Colors.amber,
                      )
                    : CircleAvatar(
                        backgroundImage: NetworkImage(file),
                      ),
              )),
          ListTile(
            onTap: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (ctx) => usertype == "Client"
                    ? Clientprofile(
                        uid: uid,
                      )
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
          ListTile(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: ((context) => const CommonProfile(
                        id: "",
                        usertype: 'Client',
                      ))));
            },
            leading: const Icon(Icons.settings),
            title: const Text("Settings"),
          ),
        ],
      ),
    );
  }
}
