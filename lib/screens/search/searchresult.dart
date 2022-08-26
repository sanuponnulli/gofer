import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_application_1/constants/colors.dart';
import 'package:flutter_application_1/screens/jobtemplate_screen/jobtemplate.dart';

class SearchResult extends StatelessWidget {
  const SearchResult({Key? key, required this.location}) : super(key: key);
  final String location;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection("jobs")
                  .where("location", isEqualTo: location)
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const CircularProgressIndicator(
                    color: kGreen,
                  );
                } else {
                  return ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: ((context, index) => ListTile(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => JobTemplate(
                                          title: snapshot.data!.docs[index]
                                              ["title"],
                                          description: snapshot
                                              .data!.docs[index]["description"],
                                          joblocation: snapshot
                                              .data!.docs[index]["location"],
                                          budget: snapshot.data!.docs[index]
                                              ["budget"],
                                          jobid: snapshot.data!.docs[index]
                                              ["jobid"],
                                          date: snapshot
                                              .data!.docs[index]["deadline"]
                                              .toDate()
                                              .toString(),
                                          user: snapshot.data!.docs[index]
                                              ["user"])));
                            },
                            title: Text(snapshot.data!.docs[index]['title']),
                            trailing:
                                Text(snapshot.data!.docs[index]['location']),
                          )));
                }
              })),
    );
  }
}
