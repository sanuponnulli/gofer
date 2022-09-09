import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/colors.dart';
import 'package:flutter_application_1/screens/messages/chat.dart';
import 'package:flutter_application_1/services/firebase_services.dart';

import '../home/homepage_client.dart';

class Freelancerproposals extends StatelessWidget {
  const Freelancerproposals({Key? key}) : super(key: key);

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
        "usertype": {users[0]: currentusertype, users[1]: "Client"}
      };

      userMethods.addChatRoom(chatRoom, chatRoomId);

      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ChatScreennnnn(chatRoomId: chatRoomId)));
    }

    return DefaultTabController(
        initialIndex: 1,
        length: 2,
        child: Scaffold(
          appBar: const TabBar(
            labelColor: Colors.black,
            indicatorColor: kGreen,
            tabs: <Widget>[
              Tab(
                text: "Open proposals",
                icon: Icon(Icons.pages_outlined),
              ),
              Tab(
                text: "Accepted proposals",
                icon: Icon(Icons.local_offer),
              ),
            ],
          ),
          body: TabBarView(
            children: [
              StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection("proposals")
                      .where("freelancer",
                          isEqualTo: FirebaseAuth.instance.currentUser!.uid)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(
                        child: CircularProgressIndicator(
                          color: kGreen,
                        ),
                      );
                    } else {
                      return ListView.separated(
                          itemBuilder: (context, index) {
                            return !snapshot.data!.docs[index]["accept"]
                                ? ListTile(
                                    title: SizedBox(
                                      height: 200,
                                      child: ListView(
                                        children: [
                                          Text(snapshot.data!.docs[index]
                                              ["description"]),
                                        ],
                                      ),
                                    ),
                                    trailing: IconButton(
                                      color: Colors.red,
                                      icon: const Icon(
                                          Icons.multiple_stop_outlined),
                                      onPressed: () {},
                                    ),
                                    leading: Column(children: [
                                      const Text(
                                        "Bid Price",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(snapshot.data!.docs[index]["price"])
                                    ]),
                                  )
                                : const SizedBox();
                          },
                          separatorBuilder: (context, index) {
                            return const Divider();
                          },
                          itemCount: snapshot.data!.docs.length);
                    }
                  }),
              StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection("proposals")
                      .where("freelancer",
                          isEqualTo: FirebaseAuth.instance.currentUser!.uid)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(
                        child: CircularProgressIndicator(
                          color: kGreen,
                        ),
                      );
                    } else {
                      return ListView.separated(
                          itemBuilder: (context, index) {
                            return snapshot.data!.docs[index]["accept"]
                                ? ListTile(
                                    title: Text(snapshot.data!.docs[index]
                                        ["description"]),
                                    leading: const Text("Job title"),
                                    trailing: ElevatedButton.icon(
                                        onPressed: () {
                                          sendMessage(snapshot.data!.docs[index]
                                              ["client"]);
                                        },
                                        icon: const Icon(Icons.check),
                                        label: const Text("Message Client")),
                                    subtitle: Row(
                                      children: [
                                        const Text("Status:"),
                                        Text(
                                          snapshot.data!.docs[index]["status"],
                                          style: const TextStyle(color: kGreen),
                                        )
                                      ],
                                    ),
                                    //     trailing: IconButton(
                                    //   onPressed: () {},
                                    //   icon: Icon(Icons.check),
                                    // )
                                  )
                                : const SizedBox();
                          },
                          separatorBuilder: (context, index) {
                            return const Divider();
                          },
                          itemCount: snapshot.data!.docs.length);
                    }
                  })
            ],
          ),
        ));
  }
}
