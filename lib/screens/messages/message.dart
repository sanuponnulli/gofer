import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/constants.dart';
import 'package:flutter_application_1/models/chatmessages.dart';

import 'components/body.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen(
      {Key? key,
      required this.fromid,
      required this.toid,
      required this.fromtype,
      required this.totype,
      required this.participants})
      : super(key: key);
  final String fromid, toid, fromtype, totype;
  final List<String> participants;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection("messages")
            .where("participants", isEqualTo: participants)
            .snapshots(),
        builder: (context, snapshot) {
          print(snapshot.data!.docs);
          return Scaffold(
            appBar: buildAppBar(),
            body: snapshot.data!.docs == []
                ? Body(
                    messageid: "",
                  )
                : Body(messageid: "messageid"),
          );
        });
  }
}

AppBar buildAppBar() {
  return AppBar(
    automaticallyImplyLeading: false,
    title: Row(
      children: [
        const BackButton(),
        const CircleAvatar(
            //backgroundImage: AssetImage("assets/images/user_2.png"),
            ),
        const SizedBox(width: kDefaultPadding * 0.75),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              "Kristin Watson",
              style: TextStyle(fontSize: 16),
            ),
            Text(
              "Active 3m ago",
              style: TextStyle(fontSize: 12),
            )
          ],
        )
      ],
    ),
    actions: [
      IconButton(
        icon: const Icon(Icons.local_phone),
        onPressed: () {},
      ),
      // IconButton(
      //   icon: const Icon(Icons.videocam),
      //   onPressed: () {},
      // ),
      const SizedBox(width: kDefaultPadding / 2),
    ],
  );
}
