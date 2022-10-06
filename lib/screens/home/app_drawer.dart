import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/home/lookup.dart';
import 'package:flutter_application_1/screens/mystats/my_stats.dart';
import 'package:flutter_application_1/screens/profile/client_profile.dart';
import 'package:flutter_application_1/screens/profile/common_profile.dart';
import 'package:flutter_application_1/screens/profile/freelancer_profile.dart';

class Appdrawer extends StatelessWidget {
  final String usertype;
  final String name;
  final String uid;
  final String file;
  final bool approvalstatus;
  const Appdrawer(
      {Key? key,
      required this.usertype,
      required this.name,
      required this.uid,
      this.file = "",
      required this.approvalstatus})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
              decoration: const BoxDecoration(color: Colors.white),
              child: ListTile(
                subtitle:
                    approvalstatus ? Text(" Approved") : Text(" Not Approved"),
                // trailing: Text(
                //   usertype,
                // ),
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
                    : FreelancerProfile(
                        uid: uid,
                      ))),
            leading: const Icon(Icons.person),
            title: const Text("Profile"),
          ),
          ListTile(
            onTap: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (ctx) => MyStats(usertype: usertype, id: uid))),
            leading: const Icon(Icons.query_stats),
            title: const Text("My stats"),
          ),
          ListTile(
            onTap: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: ((context) => ProfileLookup())));
            },
            leading: const Icon(Icons.search_rounded),
            title: const Text("Profile Lookup"),
          ),
          const ListTile(
            leading: Icon(Icons.logout),
            title: Text("Logout"),
          ),
          const Divider(),
        ],
      ),
    );
  }
}
