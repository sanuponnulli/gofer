import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/jobtemplate_screen/jobtemplate.dart';
import 'package:flutter_application_1/screens/profile/client_profile.dart';

import 'widgets/widgets.dart';

//final userreff = FirebaseFirestore.instance.collection("Freelancer");

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
                    padding: const EdgeInsets.all(8.0),
                    child: LimitedBox(
                        maxHeight: 200,
                        child: FutureBuilder<Object>(
                            future: getUsers("Client"),
                            builder: (context, snapshot) {
                              print(snapshot.data);
                              late List<String> data;

                              if (snapshot.hasData) {
                                data = snapshot.data as List<String>;

                                return ListView(
                                  scrollDirection: Axis.horizontal,
                                  children: List.generate(
                                      data.length,
                                      (index) => Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 5),
                                            child: TopJobcontainer(
                                                uid: data[index]),
                                          )),
                                );
                              } else {
                                return ListView(
                                  scrollDirection: Axis.horizontal,
                                  children: List.generate(
                                      3,
                                      (index) => Padding(
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
                  padding: const EdgeInsets.all(8.0),
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
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 5),
                                      child: TopFlancercontainer(
                                        uid: data[index],
                                      ))),
                            );
                          } else {
                            return ListView(
                              scrollDirection: Axis.horizontal,
                              children: List.generate(
                                  3,
                                  (index) => Padding(
                                        padding:
                                            EdgeInsets.symmetric(horizontal: 5),
                                        child: TopJobcontainer(uid: "Error"),
                                      )),
                            );
                          }
                        }),
                  ),
                ),
                ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: joblist.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: ((context) => JobTemplate(
                                  title: joblist[index].title,
                                  description: joblist[index].description,
                                  joblocation: joblist[index].joblocation,
                                  budget: joblist[index].budget))));
                        },
                        child: SearchResultJobTile(
                          budget: joblist[index].budget.toDouble(),
                          description: joblist[index].description,
                          joblocation: joblist[index].joblocation,
                          title: joblist[index].title,
                        ),
                      );
                    })
              ],
            ),
          ),
          const CupertinoSearchTextField(
            placeholderStyle: TextStyle(color: Colors.white),
            backgroundColor: Colors.grey,
            suffixIcon: Icon(CupertinoIcons.xmark_circle_fill),
            suffixMode: OverlayVisibilityMode.editing,
          ),
        ],
      ),
    );
  }
}
