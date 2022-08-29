import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/chat.dart';
import 'package:flutter_application_1/models/user.dart' as model;

import 'package:flutter_application_1/constants/colors.dart';
import 'package:flutter_application_1/dataclasses/job.dart';
import 'package:flutter_application_1/screens/home/homepage_client.dart';
import 'package:flutter_application_1/screens/jobtemplate_screen/jobtemplate.dart';
import 'package:flutter_application_1/screens/messages/message.dart';
import 'package:flutter_application_1/screens/messages/messages_screen.dart';
import 'package:flutter_application_1/screens/profile/complaint_registration.dart';

import 'client_add_details.dart';

final List<Job> joblist = List.generate(
    10,
    (index) => Job("title$index", "description$index", "joblocation$index",
        index, DateTime.now()));

class CommonProfile extends StatelessWidget {
  final String id;
  final String usertype;

  const CommonProfile({Key? key, required this.id, required this.usertype})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          usertype,
          style: const TextStyle(color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        physics: const ScrollPhysics(),
        child: StreamBuilder<Object>(
            stream: FirebaseFirestore.instance
                .collection(usertype)
                .doc(id)
                .snapshots(),
            builder: (context, snapshot) {
              late model.User data1;
              // = model.User(
              //     email: "", password: "", usertype: "", name1: "", name2: "");
              if (snapshot.hasData) {
                data1 = model.User.fromsnap(snapshot.data as DocumentSnapshot);
                //print(data1.phonenumber);
              }
              return !snapshot.hasData
                  ? const Center(
                      child: CircularProgressIndicator(
                      color: kGreen,
                    ))
                  : Column(
                      children: [
                        const SizedBox(
                          height: 15,
                          width: 15,
                        ),
                        SizedBox(
                          height: 250,
                          child: Stack(
                            children: [
                              Align(
                                alignment: Alignment.bottomCenter,
                                child: Card(
                                  elevation: 10,
                                  child: SizedBox(
                                    height: 220,
                                    width: MediaQuery.of(context).size.width,
                                    child: Column(
                                      children: [
                                        const SizedBox(
                                          width: 200,
                                          height: 60,
                                        ),
                                        Text(data1.name1,
                                            style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 25)),
                                        Text(data1.email),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: const [
                                            Text("Rating"),
                                            Icon(
                                              Icons.star,
                                              color: Colors.amber,
                                            ),
                                            Text("4")
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            ElevatedButton(
                                                style: ButtonStyle(
                                                    backgroundColor:
                                                        MaterialStateProperty
                                                            .all(kGreen)),
                                                onPressed: () {
                                                  Navigator.of(context).push(
                                                      MaterialPageRoute(
                                                          builder: ((context) {
                                                    return ChatScreen(
                                                      fromid: FirebaseAuth
                                                          .instance
                                                          .currentUser!
                                                          .uid,
                                                      fromtype: currentusertype,
                                                      participants: [
                                                        FirebaseAuth.instance
                                                            .currentUser!.uid,
                                                        id
                                                      ],
                                                      toid: id,
                                                      totype: usertype,
                                                    );
                                                  })));
                                                },
                                                child: const Text("Message")),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            IconButton(
                                                onPressed: () {},
                                                icon: const Icon(
                                                  Icons.call,
                                                  color: kGreen,
                                                )),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            IconButton(
                                                onPressed: () {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              ComplaintRegister(
                                                                uid: id,
                                                                usertype:
                                                                    usertype,
                                                              )));
                                                },
                                                icon: const Icon(
                                                  Icons.flag,
                                                  color: Colors.red,
                                                ))
                                            // ElevatedButton(
                                            //     style: ButtonStyle(
                                            //         backgroundColor:
                                            //             MaterialStateProperty.all(kGreen)),
                                            //     onPressed: () {
                                            //       Navigator.of(context).push(
                                            //           MaterialPageRoute(
                                            //               builder: ((context) {
                                            //         return const ClientAddDetails();
                                            //       })));
                                            //     },
                                            //     child: const Text("Edit Profile")),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.topCenter,
                                child: data1.file != ''
                                    ? CircleAvatar(
                                        radius: 40,
                                        backgroundImage:
                                            NetworkImage(data1.file),
                                        backgroundColor: Colors.amber,
                                      )
                                    : const CircleAvatar(
                                        radius: 40,
                                        backgroundColor: Colors.amber,
                                      ),
                              ),
                            ],
                          ),
                        ),
                        Column(
                          children: [
                            Card(
                              child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  padding: const EdgeInsets.all(10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        "About",
                                        style: TextStyle(fontSize: 25),
                                      ),
                                      Text(data1.about),
                                    ],
                                  )),
                            ),
                          ],
                        ),
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: Text("Work history",
                                style: TextStyle(fontSize: 25)),
                          ),
                        ),
                        ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: data1.jobs.length,
                            itemBuilder: (context, index) {
                              final List jid = data1.jobs;
                              return StreamBuilder<Object>(
                                  stream: FirebaseFirestore.instance
                                      .collection("jobs")
                                      .doc(jid[index])
                                      .snapshots(),
                                  builder: (context, snapshot) {
                                    late Map<String, dynamic> dd;
                                    if (snapshot.hasData) {
                                      DocumentSnapshot daat =
                                          snapshot.data as DocumentSnapshot;
                                      dd = daat.data() as Map<String, dynamic>;
                                    }
                                    // print(dd);
                                    return !snapshot.hasData
                                        ? const Center(
                                            child: CircularProgressIndicator(
                                                color: Colors.amber),
                                          )
                                        : Card(
                                            child: ListTile(
                                              onTap: () {
                                                //print(dd["deadline"].date());
                                                Navigator.of(context).push(
                                                    MaterialPageRoute(
                                                        builder: ((context) =>
                                                            JobTemplate(
                                                              title:
                                                                  dd["title"],
                                                              description: dd[
                                                                  "description"],
                                                              joblocation: dd[
                                                                  "location"],
                                                              budget:
                                                                  dd["budget"],
                                                              jobid:
                                                                  dd["jobid"],
                                                              date: dd[
                                                                      "deadline"]
                                                                  .toDate()
                                                                  .toString(),
                                                              user: dd["user"],
                                                            ))));
                                              },
                                              trailing: Text(DateTime.parse(
                                                      dd["deadline"]
                                                          .toDate()
                                                          .toString())
                                                  .toString()
                                                  .split(" ")[0]),
                                              leading: Text(dd["title"]),
                                              subtitle: Text(dd["description"]),
                                            ),
                                          );
                                  });
                            })
                      ],
                    );
            }),
      ),
    );
  }
}

// import 'package:flutter/src/foundation/key.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter_application_1/screens/profile/client_profile.dart';

// class MyWidget extends StatelessWidget {
//   const MyWidget({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return const Clientprofile();
//   }
// }
