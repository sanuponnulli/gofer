import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/colors.dart';
import 'package:flutter_application_1/services/firebase_services.dart';

class ChatScreennnnn extends StatefulWidget {
  final String chatRoomId;

  const ChatScreennnnn({Key? key, required this.chatRoomId}) : super(key: key);

  @override
  _ChatScreennnnnState createState() => _ChatScreennnnnState();
}

class _ChatScreennnnnState extends State<ChatScreennnnn> {
  Stream<QuerySnapshot>? chats;
  TextEditingController messageEditingController = new TextEditingController();

  Widget chatMessages() {
    return StreamBuilder<QuerySnapshot>(
      stream: chats,
      builder: (context, snapshot) {
        return snapshot.hasData
            ? ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  return MessageTile(
                    message: snapshot.data!.docs[index]["message"],
                    sendByMe: FirebaseAuth.instance.currentUser!.uid ==
                        snapshot.data!.docs[index]["sendBy"],
                  );
                })
            : Container();
      },
    );
  }

  addMessage() {
    if (messageEditingController.text.isNotEmpty) {
      Map<String, dynamic> chatMessageMap = {
        "sendBy": FirebaseAuth.instance.currentUser!.uid,
        "message": messageEditingController.text,
        'time': DateTime.now().millisecondsSinceEpoch,
      };

      UserMethods().addMessage(widget.chatRoomId, chatMessageMap);

      setState(() {
        messageEditingController.text = "";
      });
    }
  }

  @override
  void initState() {
    UserMethods().getChats(widget.chatRoomId).then((val) {
      setState(() {
        chats = val;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.amber,
      appBar: AppBar(),
      body: Container(
        child: Stack(
          children: [
            chatMessages(),
            Container(
              alignment: Alignment.bottomCenter,
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: kGreen,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(50))),
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                          child: TextField(
                        controller: messageEditingController,
                        decoration: const InputDecoration(
                            hintText: "Message ...",
                            hintStyle: TextStyle(
                              color: Color.fromARGB(255, 0, 0, 0),
                              fontSize: 16,
                            ),
                            border: InputBorder.none),
                      )),
                      SizedBox(
                        width: 16,
                      ),
                      GestureDetector(
                          onTap: () {
                            addMessage();
                          },
                          child: Icon(
                            Icons.send_rounded,
                            color: kGreen,
                          )),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MessageTile extends StatelessWidget {
  final String message;
  final bool sendByMe;

  const MessageTile({Key? key, required this.message, required this.sendByMe})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
          top: 8, bottom: 8, left: sendByMe ? 0 : 24, right: sendByMe ? 24 : 0),
      alignment: sendByMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: sendByMe
            ? const EdgeInsets.only(left: 30)
            : EdgeInsets.only(right: 30),
        padding:
            const EdgeInsets.only(top: 17, bottom: 17, left: 20, right: 20),
        decoration: BoxDecoration(
            border: sendByMe
                ? Border.all(color: Colors.white)
                : Border.all(color: kGreen),
            borderRadius: sendByMe
                ? const BorderRadius.only(
                    topLeft: Radius.circular(23),
                    topRight: Radius.circular(23),
                    bottomLeft: Radius.circular(23))
                : const BorderRadius.only(
                    topLeft: Radius.circular(23),
                    topRight: Radius.circular(23),
                    bottomRight: Radius.circular(23)),
            gradient: LinearGradient(
              colors: sendByMe
                  ? [kGreen, kGreen]
                  : [
                      Color.fromARGB(255, 255, 255, 255),
                      Color.fromARGB(255, 255, 255, 255)
                    ],
            )),
        child: Text(message,
            textAlign: TextAlign.start,
            style: const TextStyle(
                color: Color.fromARGB(255, 2, 2, 2),
                fontSize: 16,
                fontFamily: 'OverpassRegular',
                fontWeight: FontWeight.w300)),
      ),
    );
  }
}
