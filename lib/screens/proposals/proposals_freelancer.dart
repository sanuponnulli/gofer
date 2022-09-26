import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/colors.dart';
import 'package:flutter_application_1/screens/messages/chat.dart';
import 'package:flutter_application_1/screens/profile/common_profile.dart';
import 'package:flutter_application_1/services/firebase_services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../home/homepage_client.dart';

class Freelancerproposals extends StatefulWidget {
  const Freelancerproposals({Key? key}) : super(key: key);

  @override
  State<Freelancerproposals> createState() => _FreelancerproposalsState();
}

class _FreelancerproposalsState extends State<Freelancerproposals> {
  double? _ratingValue;
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
                                ? Card(
                                    shape: RoundedRectangleBorder(
                                      side: const BorderSide(
                                        width: 2,
                                        color: Colors.red,
                                      ),
                                      borderRadius: BorderRadius.circular(20.0),
                                    ),
                                    child: ListTile(
                                      title: SizedBox(
                                        height: 100,
                                        child: ListView(
                                          children: [
                                            Text(snapshot.data!.docs[index]
                                                ["description"]),
                                          ],
                                        ),
                                      ),
                                      trailing: const Icon(
                                        Icons.timer,
                                        color: Colors.red,
                                      ),
                                      leading: Column(children: [
                                        const Text(
                                          "Bid Price",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                            snapshot.data!.docs[index]["price"])
                                      ]),
                                    ),
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
                            // print(index);
                            return snapshot.data!.docs[index]["accept"]
                                ? Padding(
                                    padding: const EdgeInsets.only(top: 8.0),
                                    child: SizedBox(
                                      child: GestureDetector(
                                        onTap: () {
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      CommonProfile(
                                                          id: snapshot.data!
                                                                  .docs[index]
                                                              ["client"],
                                                          usertype: "Client")));
                                        },
                                        child: Card(
                                          shape: RoundedRectangleBorder(
                                            side: const BorderSide(
                                              width: 2,
                                              color: kGreen,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(20.0),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                children: [
                                                  CircleAvatar(
                                                    radius: 30,
                                                    backgroundColor:
                                                        Colors.grey,
                                                    child: Text(snapshot
                                                            .data!.docs[index]
                                                        ["jobtitle"]),
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  SizedBox(
                                                    width: 150,
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                            "${snapshot.data!.docs[index]["description"].toString()}..."),
                                                        SizedBox(
                                                          height: 20,
                                                        ),
                                                        Row(
                                                          children: [
                                                            const Text(
                                                                "Status:"),
                                                            Text(
                                                              snapshot.data!
                                                                          .docs[
                                                                      index]
                                                                  ["status"],
                                                              style:
                                                                  const TextStyle(
                                                                      color:
                                                                          kGreen),
                                                            ),
                                                          ],
                                                        ),
                                                        snapshot.data!.docs[
                                                                    index]
                                                                ["ratingf"]
                                                            ? const Icon(
                                                                Icons.done_all,
                                                                color: Colors
                                                                    .amber,
                                                              )
                                                            : RatingBar(
                                                                itemSize: 25,
                                                                initialRating:
                                                                    0,
                                                                direction: Axis
                                                                    .horizontal,
                                                                allowHalfRating:
                                                                    true,
                                                                itemCount: 5,
                                                                ratingWidget:
                                                                    RatingWidget(
                                                                        full: const Icon(
                                                                            Icons
                                                                                .star,
                                                                            color: Colors
                                                                                .orange),
                                                                        half:
                                                                            const Icon(
                                                                          Icons
                                                                              .star_half,
                                                                          color:
                                                                              Colors.orange,
                                                                        ),
                                                                        empty:
                                                                            const Icon(
                                                                          Icons
                                                                              .star_outline,
                                                                          color:
                                                                              Colors.orange,
                                                                        )),
                                                                onRatingUpdate:
                                                                    (value) async {
                                                                  await FirebaseFirestore
                                                                      .instance
                                                                      .collection(
                                                                          "Client")
                                                                      .doc(snapshot
                                                                              .data!
                                                                              .docs[index]
                                                                          [
                                                                          "client"])
                                                                      .update({
                                                                    "rating":
                                                                        FieldValue
                                                                            .arrayUnion([
                                                                      value
                                                                    ])
                                                                  }).then((value) => FirebaseFirestore
                                                                          .instance
                                                                          .collection(
                                                                              "proposals")
                                                                          .doc(snapshot
                                                                              .data!
                                                                              .docs[index]
                                                                              .id)
                                                                          .update({"ratingf": true}));
                                                                  setState(() {
                                                                    _ratingValue =
                                                                        value;
                                                                  });
                                                                }),
                                                      ],
                                                    ),
                                                  ),

                                                  TextButton(
                                                    child: const Icon(
                                                      Icons.message,
                                                      color: kGreen,
                                                    ),
                                                    onPressed: () {
                                                      sendMessage(snapshot
                                                              .data!.docs[index]
                                                          ["client"]);
                                                    },
                                                  ),

                                                  //     trailing: IconButton(
                                                  //   onPressed: () {},
                                                  //   icon: Icon(Icons.check),
                                                  // )
                                                ]),
                                          ),
                                        ),
                                      ),
                                    ),
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
