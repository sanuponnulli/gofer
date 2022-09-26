import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// ignore: implementation_imports

import '../../constants/colors.dart';

class AddJob extends StatefulWidget {
  const AddJob({
    Key? key,
  }) : super(key: key);

  @override
  State<AddJob> createState() => _AddJobState();
}

TextEditingController title = TextEditingController();
TextEditingController description = TextEditingController();
TextEditingController location = TextEditingController();
TextEditingController budget = TextEditingController();

class _AddJobState extends State<AddJob> {
  @override
  void dispose() {
    // TODO: implement dispose
    // title.dispose();
    // description.dispose();
    // location.dispose();
    // budget.dispose();
    super.dispose();
  }

  DateTime? _selecteddate;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text("Add Job",
                  style: TextStyle(
                    fontSize: 20,
                  )),
            ),
            Row(
              children: [
                Flexible(
                  child: TextFormField(
                    controller: title,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                              color: Colors.white,
                            )),
                        hintText: "Job Title",
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide:
                                const BorderSide(color: kGreen, width: 2))),
                  ),
                ),
                TextButton.icon(
                    onPressed: () async {
                      final selecteddatetemp = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime.now(),
                          lastDate:
                              DateTime.now().add(const Duration(days: 180)));
                      if (selecteddatetemp == null) {
                        return;
                      }
                      // print(_selecteddatetemp.toString());
                      setState(() {
                        _selecteddate = selecteddatetemp;
                      });
                    },
                    icon: const Icon(
                      Icons.calendar_today,
                      color: kGreen,
                    ),
                    label: Text(
                      _selecteddate == null
                          ? "select deadline"
                          : _selecteddate.toString().trim().split(" ")[0],
                      style: const TextStyle(color: kGreen),
                    ))
                // else
                //   Text(_selecteddate.toString()),
                ,
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            TextFormField(
              controller: description,
              maxLines: 5,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                        color: Colors.white,
                      )),
                  hintText: "Job Description",
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: const BorderSide(color: kGreen, width: 2))),
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              children: [
                Flexible(
                  flex: 1,
                  child: TextFormField(
                    controller: location,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                              color: Colors.white,
                            )),
                        hintText: "Job Location",
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide:
                                const BorderSide(color: kGreen, width: 2))),
                  ),
                ),
                const SizedBox(
                  width: 150,
                )
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              children: [
                Flexible(
                  child: TextFormField(
                    controller: budget,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                              color: Colors.white,
                            )),
                        hintText: "Budget",
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide:
                                const BorderSide(color: kGreen, width: 2))),
                  ),
                ),
                const SizedBox(
                  width: 200,
                )
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            // TextFormField(
            //     decoration: InputDecoration(
            //         hintText: "Job title",
            //         focusedBorder: OutlineInputBorder(
            //             borderSide: BorderSide(color: kGreen, width: 2)),
            //         border: const OutlineInputBorder())),
            // SizedBox(
            //   height: 30,
            // ),
            // TextFormField(
            //     decoration: InputDecoration(
            //         hintText: "Job title",
            //         focusedBorder: OutlineInputBorder(
            //             borderSide: BorderSide(color: kGreen, width: 2)),
            //         border: const OutlineInputBorder())),
            const SizedBox(
              height: 30,
            ),
            ElevatedButton(
              onPressed: () async {
                //print(_selecteddate);
                FirebaseFirestore.instance
                    .collection("Client")
                    .doc(FirebaseAuth.instance.currentUser!.uid)
                    .get()
                    .then((value) async {
                  final user = value.data() as Map<String, dynamic>;
                  if (user["approved"]) {
                    if (title.text != '' &&
                        description.text != '' &&
                        _selecteddate != null &&
                        location.text != '' &&
                        budget.text != '') {
                      DateTime now = DateTime.now();
                      DocumentReference ref =
                          FirebaseFirestore.instance.collection("jobs").doc();
                      await ref.set({
                        "user": FirebaseAuth.instance.currentUser!.uid,
                        "title": title.text,
                        "deadline": _selecteddate,
                        "description": description.text,
                        "budget": int.parse(budget.text),
                        "location": location.text.toUpperCase(),
                        "jobid": ref.id,
                        "time": DateTime(now.year, now.month, now.day)
                      }).catchError((onError) => print(onError));
                      // .then((value) => );
                      await FirebaseFirestore.instance
                          .collection("Client")
                          .doc(FirebaseAuth.instance.currentUser!.uid)
                          .update({
                        "jobs": FieldValue.arrayUnion([ref.id])
                      }).catchError((onError) => print(onError));
                      const snackBar = SnackBar(
                          backgroundColor: kGreen,
                          content: Text('succesfully Added job'));
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);

                      title.clear();
                      _selecteddate = null;
                      description.clear();
                      budget.clear();
                      location.clear();
                    } else {
                      const snackBar = SnackBar(
                        content: Text('Please Enter all Data'),
                      );

                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    }
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("NOt APPROVED")));
                  }
                }).catchError((error, stackTrace) => print("error12"));
              },
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(kGreen)),
              child: const Text("   Post Job    "),
            )
          ],
        ),
      ),
    );
  }
}
