import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/colors.dart';
import 'package:flutter_application_1/screens/addjobs/add_jobs.dart';

class PutProposal extends StatelessWidget {
  const PutProposal({Key? key, required this.jobid, required this.clientid})
      : super(key: key);
  final String jobid;
  final String clientid;

  @override
  Widget build(BuildContext context) {
    TextEditingController price = TextEditingController();
    TextEditingController Description = TextEditingController();

    return Scaffold(
        body: SafeArea(
            child: SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 100,
            ),
            const Text(
              "Bid Price",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              width: 200,
              child: TextFormField(
                controller: price,
                keyboardType: TextInputType.number,
                // validator: (value) {
                //   if (value!.isEmpty) {
                //     return "Enter a valid Password";
                //   }
                // },
                decoration: const InputDecoration(
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: kGreen, width: 2)),
                    hintText: "Price",
                    border: OutlineInputBorder()),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              "Description ",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: description,
              maxLines: 8,
              // keyboardType: TextInputType.number,
              // validator: (value) {
              //   if (value!.isEmpty) {
              //     return "Enter a valid Password";
              //   }
              // },
              decoration: const InputDecoration(
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: kGreen, width: 2)),
                  hintText: "Description",
                  border: OutlineInputBorder()),
            ),
            const SizedBox(
              height: 10,
            ),
            // const Text(
            //   "Bid Price",
            //   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            // ),
            // const SizedBox(
            //   height: 10,
            // ),
            // TextFormField(
            //   // keyboardType: TextInputType.number,
            //   // validator: (value) {
            //   //   if (value!.isEmpty) {
            //   //     return "Enter a valid Password";
            //   //   }
            //   // },
            //   decoration: const InputDecoration(
            //       focusedBorder: OutlineInputBorder(
            //           borderSide: BorderSide(color: kGreen, width: 2)),
            //       hintText: "Price",
            //       border: OutlineInputBorder()),
            // ),
            const SizedBox(
              height: 30,
            ),
            ElevatedButton(
              onPressed: () async {
                print("object");
                FirebaseFirestore.instance
                    .collection("Freelancer")
                    .doc(FirebaseAuth.instance.currentUser!.uid)
                    .get()
                    .then((value) {
                  final user = value.data() as Map<String, dynamic>;
                  FirebaseFirestore.instance
                      .collection("proposals")
                      .doc()
                      .set({
                        "description": description.text,
                        "price": price.text,
                        "jobid": jobid,
                        "time": DateTime.now(),
                        "freelancer": FirebaseAuth.instance.currentUser!.uid,
                        "client": clientid,
                        "status": "unpaid",
                        "accept": false,
                        "fname": user["name1"]
                      })
                      .then((value) => Navigator.pop(context))
                      .onError((error, stackTrace) =>
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text("Some error occured"))));
                });
              },
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(kGreen)),
              child: const Text("   Put Proposal    "),
            )
          ],
        ),
      ),
    )));
  }
}
