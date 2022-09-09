import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/colors.dart';
import 'package:flutter_application_1/services/firebase_services.dart';
import 'package:flutter_application_1/models/user.dart' as model;

import 'chat.dart';

class Messagescreen extends StatelessWidget {
  const Messagescreen({Key? key}) : super(key: key);

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

      // Map<String, dynamic> chatRoom = {
      //   "users": users,
      //   "chatRoomId": chatRoomId,
      // };

      //userMethods.addChatRoom(chatRoom, chatRoomId);

      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ChatScreennnnn(chatRoomId: chatRoomId)));
    }

    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection("chatRoom")
            .where("users",
                arrayContains: FirebaseAuth.instance.currentUser!.uid)
            .snapshots(),
        builder: (context, snapshot) {
          return !snapshot.hasData
              ? const Center(
                  child: CircularProgressIndicator(
                  color: kGreen,
                ))
              : ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: ((context, index) {
                    final List idd =
                        snapshot.data!.docs[index]["users"] as List;

                    idd.remove(FirebaseAuth.instance.currentUser!.uid);
                    return StreamBuilder<DocumentSnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection(snapshot.data!.docs[index]["usertype"]
                                [idd.first])
                            .doc(idd.first)
                            .snapshots(),
                        builder: (context, snapshot2) {
                          if (!snapshot2.hasData) {
                            return const Center(
                                child: CircularProgressIndicator(
                              color: kGreen,
                            ));
                          } else {
                            model.User data1 = model.User.fromsnap(
                                snapshot2.data as DocumentSnapshot);
                            return ListTile(
                              onTap: () {
                                sendMessage(idd.first);
                              },
                              leading: data1.file == ''
                                  ? const CircleAvatar(
                                      backgroundColor: Colors.amber,
                                    )
                                  : CircleAvatar(
                                      backgroundImage: NetworkImage(
                                          snapshot2.data!.get("file") ?? ""),
                                      backgroundColor: Colors.amber),
                              title: Text(snapshot2.data!.get("name1")),
                              subtitle: const Text("message content"),
                            );
                          }
                        });
                  }));
        });
  }
}
