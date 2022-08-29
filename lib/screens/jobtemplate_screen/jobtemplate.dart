import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/colors.dart';
import 'package:flutter_application_1/screens/home/homepage_client.dart';
import 'package:flutter_application_1/screens/profile/common_profile.dart';
import 'package:flutter_application_1/screens/putproposals/put_proposals.dart';
import 'package:flutter_application_1/models/user.dart' as model;

class JobTemplate extends StatelessWidget {
  const JobTemplate({
    Key? key,
    required this.title,
    required this.description,
    required this.joblocation,
    required this.budget,
    required this.jobid,
    required this.date,
    required this.user,
    this.l,
  }) : super(key: key);
  final String title;
  final String description;
  final String joblocation;
  final int budget;
  final String jobid;
  final String date;
  final String user;
  final List? l;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SafeArea(
          child: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: ListView(
              padding: EdgeInsets.zero,
              scrollDirection: Axis.vertical,
              children: [
                SizedBox(
                  width: 100,
                  height: 100,
                  child: StreamBuilder<Object>(
                      stream: FirebaseFirestore.instance
                          .collection("Client")
                          .doc(user)
                          .snapshots(),
                      builder: (context, snapshot) {
                        late model.User data1;
                        if (snapshot.hasData) {
                          data1 = model.User.fromsnap(
                              snapshot.data as DocumentSnapshot);
                          //print(data1.phonenumber);
                        }
                        return !snapshot.hasData
                            ? const Center(
                                child: CircularProgressIndicator(
                                color: kGreen,
                              ))
                            : GestureDetector(
                                onTap: () => Navigator.of(context).push(
                                    MaterialPageRoute(
                                        builder: (context) => CommonProfile(
                                            id: data1.uid,
                                            usertype: "Client"))),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    data1.file == ''
                                        ? const CircleAvatar(
                                            backgroundColor: Colors.amber,
                                            radius: 40,
                                          )
                                        : CircleAvatar(
                                            radius: 40,
                                            backgroundColor: Colors.amber,
                                            backgroundImage:
                                                NetworkImage(data1.file),
                                          ),
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Text(
                                          data1.name1,
                                          style: const TextStyle(fontSize: 25),
                                        ),
                                        Text(
                                          data1.phonenumber,
                                          style: const TextStyle(fontSize: 18),
                                        ),
                                        Text(
                                          DateTime.parse(date)
                                              .toString()
                                              .split(" ")[0],
                                          style: const TextStyle(fontSize: 13),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              );
                      }),
                ),
                Text(
                  title,
                  style: const TextStyle(
                      fontSize: 25, fontWeight: FontWeight.bold),
                ),
                Card(
                  child: Container(
                    width: MediaQuery.of(context).size.width * 95,
                    height: 270,
                    color: const Color(0xFFF5F5F5),
                    child: Text(
                      description,
                      style: const TextStyle(fontSize: 15),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        const Text(
                          'Budget',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          budget.toString(),
                          style: const TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                    Align(
                      alignment: const AlignmentDirectional(0, 0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          const Text(
                            'Location',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            joblocation,
                            style: const TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  width: 100,
                  height: 100,
                ),
                user == FirebaseAuth.instance.currentUser!.uid && l != null
                    ? ElevatedButton(
                        onPressed: () {
                          Widget okButton = TextButton(
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.red)),
                            child: const Text(
                              "Delete",
                              style: TextStyle(color: Colors.white),
                            ),
                            onPressed: () {
                              //print(l);
                              l!.remove(jobid);
                              //print(l);
                              FirebaseFirestore.instance
                                  .collection("Client")
                                  .doc(user)
                                  .update({"jobs": l}).then((value) {
                                FirebaseFirestore.instance
                                    .collection("jobs")
                                    .doc(jobid)
                                    .delete();
                              }).then((value) {
                                Navigator.pop(context);
                                Navigator.pop(context);
                              }).onError((error, stackTrace) {
                                const snackBar = SnackBar(
                                    backgroundColor: Colors.red,
                                    content: Text('sorry some error occured'));
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
                              });
                            },
                          );
                          AlertDialog alert = AlertDialog(
                            title: const Text("Delete the job"),
                            content: const Text(
                                "Are you sure you want to delete? if yes press the Delete button"),
                            actions: [
                              okButton,
                            ],
                          );

                          // show the dialog
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return alert;
                            },
                          );
                        },
                        child: const Text("Delete"))
                    : ElevatedButton(
                        onPressed: () {
                          if (currentusertype == "Freelancer") {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => PutProposal(
                                          clientid: user,
                                          jobid: jobid,
                                          jobtitle: title,
                                        )));
                          } else {
                            const snackBar = SnackBar(
                                backgroundColor: Colors.red,
                                content: Text(
                                    'Create a freelancer account to put proposals'));
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          }
                        },
                        child: const Text("Put proposal")),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
