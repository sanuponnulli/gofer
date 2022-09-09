import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/colors.dart';
import 'package:flutter_application_1/screens/home/homepage_client.dart';

class FreelancerWallet extends StatelessWidget {
  const FreelancerWallet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      // appBar: AppBar(
      //   title: const Center(
      //     child: Text(
      //       "My Stats",
      //       style: TextStyle(color: kGreen),
      //     ),
      //   ),
      // ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                decoration: const BoxDecoration(
                    color: kGreen,
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                width: size.width * .96,
                height: 200,
                child: Padding(
                  padding: const EdgeInsets.all(18),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Total Balance",
                        style: TextStyle(color: Colors.white),
                      ),
                      StreamBuilder<DocumentSnapshot>(
                          stream: FirebaseFirestore.instance
                              .collection("wallet")
                              .doc(FirebaseAuth.instance.currentUser!.uid)
                              .snapshots(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              final wallet =
                                  snapshot.data!.data() as Map<String, dynamic>;
                              return Text("Rs.${wallet["balance"].toString()}",
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 30,
                                  ));
                            } else {
                              return const Text("0",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 30,
                                  ));
                            }
                          }),
                      const SizedBox(
                        height: 50,
                      ),
                      Row(
                        children: const [
                          // MaterialButton(
                          //   shape: RoundedRectangleBorder(
                          //       borderRadius: BorderRadius.circular(10.0),
                          //       side: BorderSide(color: Colors.white)),
                          //   color: Colors.white,
                          //   onPressed: () {},
                          //   child: const Text(
                          //     "Deposit",
                          //     style: TextStyle(color: kGreen),
                          //   ),
                          // ),
                          SizedBox(
                            width: 20,
                          ),
                          // MaterialButton(
                          //   shape: RoundedRectangleBorder(
                          //       borderRadius: BorderRadius.circular(10.0),
                          //       side: const BorderSide(color: Colors.green)),
                          //   color: Colors.red,
                          //   onPressed: () {},
                          //   child: const Text(
                          //     "Withdraw",
                          //     style: TextStyle(color: Colors.white),
                          //   ),
                          // ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 50),
            const Text(
              "JobHistory",
              style: TextStyle(
                  color: kGreen, fontSize: 22, fontWeight: FontWeight.bold),
            ),
            Row(
              children: const [],
            ),
            const Expanded(
              child: JobHistory(),
            )
          ],
        ),
      ),
    );
  }
}

class JobHistory extends StatelessWidget {
  const JobHistory({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection("proposals")
            .where("freelancer",
                isEqualTo: FirebaseAuth.instance.currentUser!.uid)
            .where("status", isEqualTo: "paid")
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: Text("Fetching data..."),
            );
          } else {
            return ListView.separated(
                itemBuilder: (ctx, index) {
                  final jobid = snapshot.data!.docs[index]["jobid"];
                  final jobprice = snapshot.data!.docs[index]["price"];
                  return StreamBuilder<DocumentSnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection("jobs")
                          .doc(jobid)
                          .snapshots(),
                      builder: (context, snap2) {
                        if (!snap2.hasData) {
                          return const Center(
                            child: Text("Fetching..."),
                          );
                        } else {
                          final jobdata =
                              snap2.data!.data() as Map<String, dynamic>;
                          // print(jobdata);
                          return ListTile(
                            // tileColor: kGreen,
                            title: Text(
                              jobdata["title"],
                              style: TextStyle(fontSize: 25),
                            ),
                            trailing: Text(
                              jobprice ?? "",
                              style: TextStyle(fontSize: 25),
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                              side: const BorderSide(
                                color: kGreen,
                              ),
                            ),
                            hoverColor: kGreen,
                            // title: Text(jobdata["jobtitle"]),
                            leading: const CircleAvatar(
                              child: Icon(
                                Icons.work,
                                color: kGreen,
                              ),
                              backgroundColor: Colors.white,
                            ),
                          );
                        }
                      });
                },
                separatorBuilder: (ctx, index) {
                  return const Divider();
                },
                itemCount: snapshot.data!.docs.length);
          }
        });
  }
}
