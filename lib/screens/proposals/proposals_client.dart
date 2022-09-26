import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/colors.dart';
import 'package:flutter_application_1/screens/profile/common_profile.dart';
import 'package:flutter_application_1/services/firebase_services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ClientProposals extends StatefulWidget {
  const ClientProposals({Key? key}) : super(key: key);

  @override
  State<ClientProposals> createState() => _ClientProposalsState();
}

class _ClientProposalsState extends State<ClientProposals> {
  double? _ratingValue;
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
                        child: Center(
                          child: CircularProgressIndicator(
                            color: kGreen,
                          ),
                        ),
                      );
                    } else {
                      return Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: ListView.separated(
                            itemBuilder: (context, index) {
                              return !snapshot.data!.docs[index]["accept"]
                                  ? Card(
                                      shape: RoundedRectangleBorder(
                                        side: const BorderSide(
                                          width: 2,
                                          color: Colors.red,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                      ),
                                      child: ListTile(
                                        subtitle: InkWell(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        CommonProfile(
                                                            id: snapshot.data!
                                                                    .docs[index]
                                                                ["freelancer"],
                                                            usertype:
                                                                "Freelancer")));
                                          },
                                          child: Text(snapshot.data!.docs[index]
                                              ["fname"]),
                                        ),
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
                                                .doc(snapshot
                                                    .data!.docs[index].id)
                                                .update({"accept": true});
                                          },
                                        ),
                                        leading: Column(children: [
                                          const Text(
                                            "Bid Price",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(snapshot.data!.docs[index]
                                              ["price"]),
                                        ]),
                                      ),
                                    )
                                  : const SizedBox();
                            },
                            separatorBuilder: (context, index) {
                              return const Divider();
                            },
                            itemCount: snapshot.data!.docs.length),
                      );
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
                        child: Center(
                          child: CircularProgressIndicator(
                            color: kGreen,
                          ),
                        ),
                      );
                    } else {
                      return Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: ListView.separated(
                            itemBuilder: (context, index) {
                              return snapshot.data!.docs[index]["accept"]
                                  ? Card(
                                      shape: RoundedRectangleBorder(
                                        side: BorderSide(
                                          width: 2,
                                          color: kGreen,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                      ),
                                      child: ListTile(
                                        onTap: (() {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      CommonProfile(
                                                          id: snapshot.data!
                                                                  .docs[index]
                                                              ["freelancer"],
                                                          usertype:
                                                              "Freelancer")));
                                        }),
                                        shape: const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(20))),
                                        subtitle: Row(
                                          children: [
                                            Text(
                                              "Status",
                                              style:
                                                  TextStyle(color: Colors.grey),
                                            ),
                                            Text(
                                              snapshot.data!.docs[index]
                                                  ["status"],
                                              style: TextStyle(color: kGreen),
                                            ),
                                          ],
                                        ),
                                        title: Text(snapshot.data!.docs[index]
                                            ["fname"]),
                                        leading: CircleAvatar(
                                          child: Text(snapshot.data!.docs[index]
                                              ["jobtitle"]),
                                        ),
                                        trailing: snapshot.data!.docs[index]
                                                    ["status"] ==
                                                "paid"
                                            ? Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  // ElevatedButton(
                                                  //     onPressed: () {},
                                                  //     child:
                                                  //         Text("paid,Add rating")),
                                                  snapshot.data!.docs[index]
                                                          ["ratingc"]
                                                      ? Icon(
                                                          Icons.done,
                                                          color: Colors.amber,
                                                        )
                                                      : RatingBar(
                                                          itemSize: 25,
                                                          initialRating: 0,
                                                          direction:
                                                              Axis.horizontal,
                                                          allowHalfRating: true,
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
                                                                    color: Colors
                                                                        .orange,
                                                                  ),
                                                                  empty:
                                                                      const Icon(
                                                                    Icons
                                                                        .star_outline,
                                                                    color: Colors
                                                                        .orange,
                                                                  )),
                                                          onRatingUpdate:
                                                              (value) async {
                                                            await FirebaseFirestore
                                                                .instance
                                                                .collection(
                                                                    "Freelancer")
                                                                .doc(snapshot
                                                                            .data!
                                                                            .docs[
                                                                        index][
                                                                    "freelancer"])
                                                                .update({
                                                              "rating": FieldValue
                                                                  .arrayUnion(
                                                                      [value])
                                                            }).then((value) =>
                                                                    FirebaseFirestore
                                                                        .instance
                                                                        .collection(
                                                                            "proposals")
                                                                        .doc(snapshot
                                                                            .data!
                                                                            .docs[
                                                                                index]
                                                                            .id)
                                                                        .update({
                                                                      "ratingc":
                                                                          true
                                                                    }));
                                                            setState(() {
                                                              _ratingValue =
                                                                  value;
                                                            });
                                                          }),
                                                ],
                                              )
                                            : ElevatedButton.icon(
                                                onPressed: () async {
                                                  UserMethods userMethods =
                                                      UserMethods();
                                                  bool result =
                                                      await userMethods.pay(
                                                          int.parse(snapshot
                                                                  .data!
                                                                  .docs[index]
                                                              ["price"]),
                                                          snapshot.data!
                                                              .docs[index].id,
                                                          snapshot.data!
                                                                  .docs[index]
                                                              ["freelancer"]);
                                                  result
                                                      ? ScaffoldMessenger.of(
                                                              context)
                                                          .showSnackBar(SnackBar(
                                                              content: Text(
                                                                  "succes")))
                                                      : ScaffoldMessenger.of(
                                                              context)
                                                          .showSnackBar(SnackBar(
                                                              content: Text(
                                                                  "failed")));
                                                },
                                                icon: const Icon(Icons.check),
                                                label: Text(
                                                    "PAY Rs.${snapshot.data!.docs[index]["price"]}")),
                                        //     trailing: IconButton(
                                        //   onPressed: () {},
                                        //   icon: Icon(Icons.check),
                                        // )
                                      ),
                                    )
                                  : const SizedBox();
                            },
                            separatorBuilder: (context, index) {
                              return const Divider();
                            },
                            itemCount: snapshot.data!.docs.length),
                      );
                    }
                  })
            ],
          ),
        ));
  }
}
