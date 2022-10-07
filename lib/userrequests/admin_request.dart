import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/colors.dart';
import 'package:flutter_application_1/screens/profile/common_profile.dart';

class Requestpage extends StatelessWidget {
  const Requestpage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: const TabBar(labelColor: Colors.black, tabs: [
          Tab(
            text: "freelancer",
          ),
          Tab(
            text: "client",
          )
        ]),
        body: SafeArea(
            child: TabBarView(
          children: [
            StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection("Freelancer")
                    .where("approved", isEqualTo: false)
                    .snapshots(),
                builder: (context, snapshot1) {
                  if (snapshot1.hasData) {
                    return ListView.separated(
                        itemBuilder: (context, index) {
                          return AcceptReject(
                            email: snapshot1.data!.docs[index]["email"],
                            id: snapshot1.data!.docs[index]["uid"],
                            name: snapshot1.data!.docs[index]["name1"],
                            usertype: snapshot1.data!.docs[index]["usertype"],
                          );
                        },
                        separatorBuilder: (context, index) {
                          return const Divider();
                        },
                        itemCount: snapshot1.data!.docs.length);
                  } else {
                    return const Text("no data!!");
                  }
                }),
            StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection("Client")
                    .where("approved", isEqualTo: false)
                    .snapshots(),
                builder: (context, snapshot2) {
                  if (snapshot2.hasData) {
                    return ListView.separated(
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return AcceptReject(
                            email: snapshot2.data!.docs[index]["email"],
                            id: snapshot2.data!.docs[index]["uid"],
                            name: snapshot2.data!.docs[index]["name1"],
                            usertype: snapshot2.data!.docs[index]["usertype"],
                          );
                        },
                        separatorBuilder: (context, index) {
                          return const Divider();
                        },
                        itemCount: snapshot2.data!.docs.length);
                  } else {
                    return const Text("no data!!");
                  }
                }),
          ],
        )),
      ),
    );
  }
}

class AcceptReject extends StatelessWidget {
  const AcceptReject({
    Key? key,
    required this.name,
    required this.email,
    required this.id,
    required this.usertype,
  }) : super(key: key);
  final String name;
  final String email;
  final String id;
  final String usertype;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => CommonProfile(id: id, usertype: usertype))),
      child: Card(
          child: SizedBox(
        width: double.infinity,
        height: 100,
        //color: Colors.amber,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: TextStyle(fontSize: 20),
                  ),
                  Text(
                    email,
                    style: TextStyle(fontSize: 20),
                  ),
                  Text(usertype)
                ],
              ),
            ),
            const SizedBox(
              width: 50,
            ),
            Column(children: [
              ElevatedButton(
                  onPressed: () async {
                    FirebaseFirestore.instance
                        .collection(usertype)
                        .doc(id)
                        .update({"approved": true});
                  },
                  child: const Text("Accept")),
              // ElevatedButton(
              //   onPressed: () {},
              //   style: ButtonStyle(
              //       backgroundColor:
              //           MaterialStateProperty.all<Color>(Colors.red)),
              //   child: const Text("Reject"),
              // )
            ])
          ],
        ),
      )),
    );
  }
}
