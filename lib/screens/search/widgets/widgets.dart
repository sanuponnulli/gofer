import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/constants.dart';
import 'package:flutter_application_1/models/user.dart' as model;
import 'package:flutter_application_1/constants/colors.dart';
import 'package:flutter_application_1/screens/profile/common_profile.dart';

class TopClient extends StatelessWidget {
  const TopClient({Key? key, required this.uid}) : super(key: key);

  final String uid;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (() => Navigator.push(
            context,
            MaterialPageRoute(
              builder: ((context) => CommonProfile(
                    id: uid,
                    usertype: 'Client',
                  )),
            ),
          )),
      child: Card(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20))),
        elevation: 3,
        child: Container(
          decoration: BoxDecoration(
              border: Border.all(width: 1, color: kGreen),
              color: kcontainercolor,
              borderRadius: BorderRadius.circular(10)),
          height: 150,
          width: 120,
          child: StreamBuilder<Object>(
              stream: FirebaseFirestore.instance
                  .collection("Client")
                  .doc(uid)
                  .snapshots(),
              builder: (context, snapshot) {
                // = model.User(
                //     email: "", password: "", usertype: "", name1: "", name2: "");
                //late model.User data1;

                if (snapshot.hasData) {
                  model.User data1 =
                      model.User.fromsnap(snapshot.data as DocumentSnapshot);
                  // print(data1.phonenumber);

                  return !snapshot.hasData || data1 == null
                      ? const Center(
                          child: CircularProgressIndicator(
                          color: kGreen,
                        ))
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  data1.file != ''
                                      ? CircleAvatar(
                                          backgroundImage:
                                              NetworkImage(data1.file))
                                      : const CircleAvatar(
                                          backgroundColor: Colors.amber,
                                        ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    data1.name1,
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: data1.about.length > 89
                                  ? Text(
                                      "${data1.about.substring(0, 89)}..",
                                      style: TextStyle(),
                                    )
                                  : Text(""),
                            )
                          ],
                        );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: kGreen,
                    ),
                  );
                }
              }),
        ),
      ),
    );
  }
}

class TopFlancercontainer extends StatelessWidget {
  final String uid;
  const TopFlancercontainer({Key? key, required this.uid}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20))),
      child: GestureDetector(
        onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
                builder: ((context) => CommonProfile(
                      id: uid,
                      usertype: 'Freelancer',
                    )))),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(width: 1, color: kGreen),
          ),
          height: 170,
          width: 250,
          child: StreamBuilder<Object>(
              stream: FirebaseFirestore.instance
                  .collection("Freelancer")
                  .doc(uid)
                  .snapshots(),
              builder: (context, snapshot) {
                late model.User data1;

                if (snapshot.hasData) {
                  print("snapshot has data in widget$snapshot");
                  data1 =
                      model.User.fromsnap(snapshot.data as DocumentSnapshot);
                  //print(data1.phonenumber);
                }
                return !snapshot.hasData
                    ? const Center(
                        child: CircularProgressIndicator(
                        color: kGreen,
                      ))
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                data1.file != ''
                                    ? CircleAvatar(
                                        backgroundImage:
                                            NetworkImage(data1.file))
                                    : const CircleAvatar(
                                        backgroundColor: Colors.amber,
                                      ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(data1.name1)
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: data1.about.length > 100
                                ? Text(
                                    "${data1.about.substring(0, 100)}..",
                                    style: TextStyle(),
                                  )
                                : Text(""),
                          ),
                        ],
                      );
              }),
        ),
      ),
    );
  }
}

class SearchResultJobTile extends StatelessWidget {
  final String date;
  final String title;
  final String description;
  final String joblocation;
  final double budget;
  const SearchResultJobTile({
    Key? key,
    required this.date,
    required this.title,
    required this.description,
    required this.joblocation,
    required this.budget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      // ignore: avoid_unnecessary_containers
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(width: 1, color: kGreen),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      SizedBox(
                        width: 250,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            title,
                            style: const TextStyle(
                                color: kGreen,
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  ),
                  // IconButton(
                  //   icon: const Icon(Icons.save),
                  //   onPressed: () {},
                  // )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: const [
                  // Text("posted 24m ago", style: TextStyle(color: Colors.grey))
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              ListTile(
                leading: Column(
                  children: [
                    Text(
                      budget.toString(),
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const Text(
                      "Budget",
                      style: TextStyle(color: Colors.grey),
                    )
                  ],
                ),
                trailing: Column(
                  children: [
                    Text(
                      DateTime.parse(date).toString().split(" ")[0],
                      style: const TextStyle(fontSize: 13, color: Colors.red),
                    ),
                    const Text(
                      "Deadline",
                      style: TextStyle(color: Colors.grey),
                    )
                  ],
                ),
              ),
              Column(
                children: [
                  Text(style: const TextStyle(fontSize: 15), "${description}")
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //   children: const [
              //     Text("tag", style: TextStyle(color: Colors.grey)),
              //     Text("tag2", style: TextStyle(color: Colors.grey)),
              //     Text("tag3", style: TextStyle(color: Colors.grey))
              //   ],
              // )
            ],
          ),
        ),
      ),
    );
  }
}
