import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/colors.dart';
import 'package:flutter_application_1/constants/constants.dart';
import 'package:flutter_application_1/models/chatmessages.dart';

import 'chat_input_field.dart';
import 'message.dart';

class Body extends StatelessWidget {
  const Body({Key? key, required this.messageid}) : super(key: key);
  final String messageid;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: messageid != " "
          ? StreamBuilder<DocumentSnapshot>(
              stream: FirebaseFirestore.instance
                  .collection("messages")
                  .doc(messageid)
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(color: kGreen),
                  );
                } else {
                  final messages =
                      snapshot.data!.data() as Map<String, dynamic>;
                  final chatdata = messages["chat"] as List;
                  return Column(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: kDefaultPadding),
                          child: ListView.builder(
                            itemCount: chatdata.length,
                            itemBuilder: (context, index) =>
                                Message(message: messages[index]),
                          ),
                        ),
                      ),
                      ChatInputField(
                        messageid: messageid,
                      ),
                    ],
                  );
                }
              })
          : Column(
              children: [
                Expanded(
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: kDefaultPadding),
                    child: ListView.builder(
                      itemCount: 0,
                      itemBuilder: (context, index) => SizedBox(),
                    ),
                  ),
                ),
                ChatInputField(
                  messageid: "null",
                ),
              ],
            ),
    );
  }
}
