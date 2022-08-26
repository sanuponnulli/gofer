import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/colors.dart';

class ClientProposals extends StatelessWidget {
  const ClientProposals({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        initialIndex: 1,
        length: 2,
        child: Scaffold(
          appBar: const TabBar(
            labelColor: Colors.black,
            indicatorColor: kGreen,
            tabs: <Widget>[
              Tab(
                text: "Offers",
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
                      .where("client",
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
                                    subtitle: Text(
                                        snapshot.data!.docs[index]["fname"]),
                                    title: SizedBox(
                                      height: 200,
                                      child: ListView(
                                        children: [
                                          const Text("Description"),
                                          Text(snapshot.data!.docs[index]
                                              ["description"])
                                        ],
                                      ),
                                    ),
                                    trailing: IconButton(
                                      color: kGreen,
                                      icon: const Icon(Icons.check),
                                      onPressed: () async {
                                        await FirebaseFirestore.instance
                                            .collection("proposals")
                                            .doc(snapshot.data!.docs[index].id)
                                            .update({"accept": true});
                                      },
                                    ),
                                    leading: Column(children: [
                                      const Text(
                                        "Bid Price",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(snapshot.data!.docs[index]["price"]),
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
                      .where("client",
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
                                    title: Text(
                                        snapshot.data!.docs[index]["fname"]),
                                    leading: const Text("Job title"),
                                    trailing: ElevatedButton.icon(
                                        onPressed: () {},
                                        icon: const Icon(Icons.check),
                                        label: const Text("job complete PAY")),
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
