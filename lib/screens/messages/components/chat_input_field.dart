import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/constants.dart';
import 'package:flutter_application_1/models/chat.dart';

class ChatInputField extends StatelessWidget {
  const ChatInputField({
    Key? key,
    required this.messageid,
  }) : super(key: key);
  final String messageid;

  @override
  Widget build(BuildContext context) {
    TextEditingController message = TextEditingController();
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: kDefaultPadding,
        vertical: kDefaultPadding / 2,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 4),
            blurRadius: 32,
            color: const Color(0xFF087949).withOpacity(0.08),
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          children: [
            // const Icon(Icons.mic, color: kPrimaryColor),
            const SizedBox(width: kDefaultPadding),
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: kDefaultPadding * 0.75,
                ),
                decoration: BoxDecoration(
                  color: kPrimaryColor.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(40),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.keyboard,
                      color: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .color!
                          .withOpacity(0.64),
                    ),
                    const SizedBox(width: kDefaultPadding / 4),
                    Expanded(
                      child: TextField(
                        controller: message,
                        decoration: const InputDecoration(
                          hintText: "Type message",
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () async {
                        if (messageid == "null") {
                          Chat c = Chat(name: "d", lastMessage: "d", time: "d");
                          await FirebaseFirestore.instance
                              .collection("messages")
                              .doc()
                              .update({
                            "chats": FieldValue.arrayUnion(c.tojson as dynamic)
                          });
                        } else {
                          Chat c = Chat(name: "d", lastMessage: "d", time: "d");
                          await FirebaseFirestore.instance
                              .collection("messages")
                              .doc(messageid)
                              .update({
                            "chats": FieldValue.arrayUnion(c.tojson as dynamic)
                          });
                        }
                      },
                      child: Icon(
                        Icons.send,
                        color: Theme.of(context)
                            .textTheme
                            .bodyText1!
                            .color!
                            .withOpacity(0.64),
                      ),
                    ),
                    const SizedBox(width: kDefaultPadding / 4),
                    // Icon(
                    //   Icons.camera_alt_outlined,
                    //   color: Theme.of(context)
                    //       .textTheme
                    //       .bodyText1!
                    //       .color!
                    //       .withOpacity(0.64),
                    // ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
