import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/colors.dart';
import 'package:flutter_application_1/screens/jobtemplate_screen/jobtemplate.dart';
import 'package:flutter_application_1/screens/profile/client_profile.dart';
import 'package:flutter_application_1/screens/search/searchresult.dart';

import '../../dataclasses/job.dart';
import 'widgets/widgets.dart';

//final userreff = FirebaseFirestore.instance.collection("Freelancer");

final List<Job> joblist = List.generate(
    10,
    (index) => Job("title$index", "description$index", "joblocation$index",
        index, DateTime.now()));

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  void initState() {
    getUsers("Client");
    getUsers("Freelancer");
    // TODO: implement initState
    super.initState();
  }

  Future<List> getUsers(String usertype) async {
    List<String> uids = [];
    //uids.clear();
    final userref = FirebaseFirestore.instance.collection(usertype);

    await userref.get().then((QuerySnapshot value) =>
        uids.addAll(value.docs.map((e) => e.id).toList()));
    // print(uids);
    return (uids);
  }

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    TextEditingController searchfield = TextEditingController();
    //print(uids);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 40,
                ),
                const Text(
                  "Top Clients",
                  style: TextStyle(fontSize: 25),
                ),
                Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: LimitedBox(
                        maxHeight: 200,
                        child: FutureBuilder<Object>(
                            future: getUsers("Client"),
                            builder: (context, snapshot) {
                              //print(snapshot.data);
                              late List<String> data;

                              if (snapshot.hasData) {
                                data = snapshot.data as List<String>;

                                return ListView(
                                  scrollDirection: Axis.horizontal,
                                  children: List.generate(
                                      data.length,
                                      (index) => Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 2),
                                            child: TopJobcontainer(
                                                uid: data[index]),
                                          )),
                                );
                              } else {
                                return ListView(
                                  scrollDirection: Axis.horizontal,
                                  children: List.generate(
                                      3,
                                      (index) => const Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 5),
                                            child:
                                                TopJobcontainer(uid: "Error"),
                                          )),
                                );
                              }
                            }))),
                const Text(
                  "Top Freelancers",
                  style: TextStyle(fontSize: 25),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: LimitedBox(
                    maxHeight: 200,
                    child: FutureBuilder<Object>(
                        future: getUsers("Freelancer"),
                        builder: (context, snapshot) {
                          // print(snapshot.data);
                          late List<String> data;

                          if (snapshot.hasData) {
                            data = snapshot.data as List<String>;

                            return ListView(
                              scrollDirection: Axis.horizontal,
                              children: List.generate(
                                  data.length,
                                  (index) => Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 2),
                                      child: TopFlancercontainer(
                                        uid: data[index],
                                      ))),
                            );
                          } else {
                            return ListView(
                              scrollDirection: Axis.horizontal,
                              children: List.generate(
                                  3,
                                  (index) => const Padding(
                                        padding:
                                            EdgeInsets.symmetric(horizontal: 5),
                                        child: TopJobcontainer(uid: "Error"),
                                      )),
                            );
                          }
                        }),
                  ),
                ),
                StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection("jobs")
                        .where("time",
                            isEqualTo: DateTime(now.year, now.month, now.day))
                        .snapshots(),
                    builder: (context, snapshot) {
                      return !snapshot.hasData
                          ? const Center(
                              child: CircularProgressIndicator(
                              color: kGreen,
                            ))
                          : ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: snapshot.data!.docs.length,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                            builder: ((context) => JobTemplate(
                                                  title: snapshot.data!
                                                      .docs[index]["title"],
                                                  description:
                                                      snapshot.data!.docs[index]
                                                          ["description"],
                                                  joblocation: snapshot.data!
                                                      .docs[index]["location"],
                                                  budget: snapshot.data!
                                                      .docs[index]["budget"],
                                                  jobid: snapshot.data!
                                                      .docs[index]["jobid"],
                                                  date: snapshot.data!
                                                      .docs[index]["deadline"]
                                                      .toDate()
                                                      .toString(),
                                                  user: snapshot.data!
                                                      .docs[index]["user"],
                                                ))));
                                  },
                                  child: SearchResultJobTile(
                                    budget: snapshot.data!.docs[index]["budget"]
                                        .toDouble(),
                                    description: snapshot.data!.docs[index]
                                        ["description"],
                                    joblocation: snapshot.data!.docs[index]
                                        ["location"],
                                    title: snapshot.data!.docs[index]["title"],
                                  ),
                                );
                              });
                    })
              ],
            ),
          ),
          CupertinoSearchTextField(
            controller: searchfield,
            onSubmitted: (data) {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: ((context) => SearchResult(
                        location: data.toUpperCase(),
                      ))));
              // print("searchworking $data");
            },
            placeholderStyle: const TextStyle(color: Colors.white),
            backgroundColor: Colors.grey,
            suffixIcon: const Icon(CupertinoIcons.xmark_circle_fill),
            suffixMode: OverlayVisibilityMode.editing,
          ),
        ],
      ),
    );
  }
}
