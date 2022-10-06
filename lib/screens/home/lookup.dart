import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_application_1/screens/profile/common_profile.dart';

class ProfileLookup extends StatefulWidget {
  const ProfileLookup({Key? key}) : super(key: key);

  @override
  State<ProfileLookup> createState() => _ProfileLookupState();
}

class _ProfileLookupState extends State<ProfileLookup> {
  List userdata = [];
  Future<void> fetchuser(String s) async {
    userdata.clear();

    await FirebaseFirestore.instance
        .collection("Client")
        .where("name1", isEqualTo: s)
        .get()
        .then((value) {
      final w = value.docs;
      for (var a in w) {
        userdata.add({
          "name": a["name1"],
          "id": a["uid"],
          "type": "Client",
          "file": a.data()["file"] ?? ""
        });
      }
    }).then((value) => FirebaseFirestore.instance
                .collection("Freelancer")
                .where("name1", isEqualTo: s)
                .get()
                .then((value) {
              final w = value.docs.toList();
              for (var a in w) {
                userdata.add({
                  "name": a["name1"],
                  "id": a["uid"],
                  "type": "Freelancer",
                  "file": a.data()["file"] ?? ""
                });
              }
            }));
    setState(() {});

    // print(userdata);
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController searchcontroller = TextEditingController();
    return Scaffold(
        body: SafeArea(
            child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          CupertinoSearchTextField(
            controller: searchcontroller,
            onSubmitted: (String s) {
              fetchuser(s);
              // setState(() {});
              // print("ss$userdata");

              // print(s);
            },
          ),
          Expanded(
            child: ListView.separated(
                itemBuilder: (context, index) {
                  return ListTile(
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CommonProfile(
                              id: userdata[index]["id"],
                              usertype: userdata[index]["type"]),
                        )),
                    leading: userdata[index]["file"] == ""
                        ? CircleAvatar(
                            backgroundColor: Colors.amber,
                          )
                        : CircleAvatar(
                            backgroundImage:
                                NetworkImage(userdata[index]["file"]),
                          ),
                    title: Text(userdata[index]["name"]),
                    subtitle: Text(userdata[index]["type"]),
                  );
                },
                separatorBuilder: (context, index) => Divider(),
                itemCount: userdata.length),
          )
        ],
      ),
    )));
  }
}
