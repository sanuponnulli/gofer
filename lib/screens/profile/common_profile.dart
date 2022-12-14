import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/chat.dart';
import 'package:flutter_application_1/models/user.dart' as model;

import 'package:flutter_application_1/constants/colors.dart';
import 'package:flutter_application_1/dataclasses/job.dart';
import 'package:flutter_application_1/screens/home/homepage_client.dart';
import 'package:flutter_application_1/screens/jobtemplate_screen/jobtemplate.dart';
import 'package:flutter_application_1/screens/messages/chat.dart';
import 'package:flutter_application_1/screens/mystats/my_stats.dart';
import 'package:flutter_application_1/screens/profile/complaint_registration.dart';
import 'package:flutter_application_1/services/firebase_services.dart';
import 'package:url_launcher/url_launcher.dart';

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
    UserMethods userMethods = UserMethods();
    getChatRoomId(String a, String b) {
      if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
        return "$b\_$a";
      } else {
        return "$a\_$b";
      }
    }

    sendMessage(String useridd) {
      List<String> users = [FirebaseAuth.instance.currentUser!.uid, useridd];

      String chatRoomId =
          getChatRoomId(FirebaseAuth.instance.currentUser!.uid, useridd);

      Map<String, dynamic> chatRoom = {
        "users": users,
        "chatRoomId": chatRoomId,
        "usertype": {users[0]: currentusertype, users[1]: usertype}
      };

      userMethods.addChatRoom(chatRoom, chatRoomId);

      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ChatScreennnnn(chatRoomId: chatRoomId)));
    }

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
                                          children: [
                                            const Text("Rating"),
                                            const Icon(
                                              Icons.star,
                                              color: Colors.amber,
                                            ),
                                            Text(data1.rating[int.parse(
                                                    (data1.rating.length ~/ 2)
                                                        .toString())]
                                                .toString())
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
                                                  sendMessage(id);
                                                },
                                                child: const Text("Message")),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            data1.phonenumber != ""
                                                ? Icon(
                                                    Icons.call,
                                                    color: Colors.grey,
                                                  )
                                                : IconButton(
                                                    onPressed: () async {
                                                      var url = Uri.parse(
                                                          "tel:${data1.phonenumber}");
                                                      if (await canLaunchUrl(
                                                          url)) {
                                                        await launchUrl(url);
                                                      } else {
                                                        throw 'Could not launch $url';
                                                      }
                                                    },
                                                    icon: const Icon(
                                                      Icons.call,
                                                      color: kGreen,
                                                    )),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            if (FirebaseAuth.instance
                                                    .currentUser!.uid ==
                                                "Ash9QXRqVHPlYmmPJj5QmFUyDT42")
                                              Row(
                                                children: [
                                                  IconButton(
                                                      onPressed: () {
                                                        Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder: (context) =>
                                                                    MyStats(
                                                                        id: id,
                                                                        usertype:
                                                                            usertype)));
                                                      },
                                                      icon: Icon(Icons.wallet)),
                                                  data1.approval
                                                      ? IconButton(
                                                          onPressed: () {
                                                            FirebaseFirestore
                                                                .instance
                                                                .collection(
                                                                    usertype)
                                                                .doc(id)
                                                                .update({
                                                              "approved": false
                                                            });
                                                          },
                                                          icon: const Icon(
                                                            Icons
                                                                .remove_circle_outline,
                                                            color: Colors.red,
                                                          ))
                                                      : IconButton(
                                                          onPressed: () {
                                                            FirebaseFirestore
                                                                .instance
                                                                .collection(
                                                                    usertype)
                                                                .doc(id)
                                                                .update({
                                                              "approved": true
                                                            });
                                                          },
                                                          icon: const Icon(
                                                            Icons.approval,
                                                            color: Colors.green,
                                                          )),
                                                ],
                                              )
                                            else
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
                                                              postdate: dd[
                                                                      "time"]
                                                                  .toDate()
                                                                  .toString(),
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
