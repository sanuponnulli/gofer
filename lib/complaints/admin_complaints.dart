import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/colors.dart';
import 'package:flutter_application_1/screens/messages/message.dart';

class ComplaintsAdmin extends StatelessWidget {
  const ComplaintsAdmin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection("complaints").snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            // print(snapshot.data!.docs.length);

            return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: ((context, index) {
                  return !snapshot.hasData
                      ? const CircularProgressIndicator()
                      : StreamBuilder<DocumentSnapshot>(
                          stream: FirebaseFirestore.instance
                              .collection(snapshot.data!.docs[index]["bytype"])
                              .doc(snapshot.data!.docs[index]["byid"])
                              .snapshots(),
                          builder: (context, snapshot2) {
                            if (snapshot2.hasData) {
                              final snapshotdata = snapshot2.data!.data()
                                  as Map<String, dynamic>;
                              //print(snapshotdata["phone"]);
                              //print(snapshot2.data!.data()["phone"]);
                              return StreamBuilder<DocumentSnapshot>(
                                  stream: FirebaseFirestore.instance
                                      .collection(
                                          snapshot.data!.docs[index]["ontype"])
                                      .doc(snapshot.data!.docs[index]["onid"])
                                      .snapshots(),
                                  builder: (context, snapshot3) {
                                    if (snapshot3.hasData) {
                                      final snapshotdata2 = snapshot3.data!
                                          .data() as Map<String, dynamic>;
                                      //print(snapshotdata["phone"]);
                                      //print(snapshot2.data!.data()["phone"]);
                                      return ListTile(
                                        onTap: () {
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: ((context) =>
                                                      const ChatScreen())));
                                        },
                                        leading: CircleAvatar(
                                            backgroundImage: NetworkImage(
                                                snapshotdata["file"]),
                                            backgroundColor: Colors.amber),
                                        title: Text(
                                            "By ${snapshotdata["name1"]} On ${snapshotdata2["name1"]}"),
                                        subtitle: Text(
                                            "complaint: ${snapshot.data!.docs[index]["complaint"]}"),
                                        trailing: IconButton(
                                            onPressed: () {},
                                            icon: const Icon(
                                                Icons.message_rounded)),
                                      );
                                    } else {
                                      return const Center(
                                        child: CircularProgressIndicator(
                                          color: kGreen,
                                        ),
                                      );
                                    }
                                  });
                            } else {
                              return const Center(
                                child: CircularProgressIndicator(
                                  color: kGreen,
                                ),
                              );
                            }
                          });
                }));
          } else {
            return const Center(
                child: CircularProgressIndicator(
              color: kGreen,
            ));
          }
        });
  }
}
