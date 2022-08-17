import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/user.dart' as model;
import 'package:flutter_application_1/constants/colors.dart';
import 'package:flutter_application_1/screens/profile/common_profile.dart';

class TopJobcontainer extends StatelessWidget {
  const TopJobcontainer({Key? key, required this.uid}) : super(key: key);

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
        child: Container(
          decoration: BoxDecoration(
              color: kcontainercolor, borderRadius: BorderRadius.circular(10)),
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
                late model.User data1;

                if (snapshot.hasData) {
                  data1 =
                      model.User.fromsnap(snapshot.data as DocumentSnapshot);
                  print(data1.phonenumber);
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
                          )
                        ],
                      );
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
      child: GestureDetector(
        onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
                builder: ((context) => CommonProfile(
                      id: uid,
                      usertype: 'Freelancer',
                    )))),
        child: Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
          height: 170,
          width: 300,
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
                                    : CircleAvatar(
                                        backgroundColor: Colors.amber,
                                      ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(data1.name1)
                              ],
                            ),
                          )
                        ],
                      );
              }),
        ),
      ),
    );
  }
}

class SearchResultJobTile extends StatelessWidget {
  final String title;
  final String description;
  final String joblocation;
  final double budget;
  const SearchResultJobTile({
    Key? key,
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
                        child: Text(
                          title,
                          style: const TextStyle(
                              color: kGreen,
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  IconButton(
                    icon: const Icon(Icons.save),
                    onPressed: () {},
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: const [
                  Text("posted 24m ago", style: TextStyle(color: Colors.grey))
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
                  children: const [
                    Text(
                      "10-05-2022",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "Date",
                      style: TextStyle(color: Colors.grey),
                    )
                  ],
                ),
              ),
              Column(
                children: [
                  Text(
                      style: const TextStyle(fontSize: 15),
                      "${description}le content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for 'lorem ipsum' will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like).")
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: const [
                  Text("tag", style: TextStyle(color: Colors.grey)),
                  Text("tag2", style: TextStyle(color: Colors.grey)),
                  Text("tag3", style: TextStyle(color: Colors.grey))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
