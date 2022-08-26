import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_application_1/constants/colors.dart';
import 'package:flutter_application_1/screens/home/homepage_client.dart';
import 'package:flutter_application_1/screens/login/login_page_client.dart';

class ComplaintRegister extends StatelessWidget {
  const ComplaintRegister({Key? key, required this.uid, required this.usertype})
      : super(key: key);
  final String uid;
  final String usertype;

  @override
  Widget build(BuildContext context) {
    TextEditingController complaint = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: const Text("Complaint"),
      ),
      body: SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TextField(
            controller: complaint,
            maxLines: 5,
            decoration: const InputDecoration(
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: kGreen, width: 2)),
                hintText: "Complaint",
                border: OutlineInputBorder()),
          ),
          const SizedBox(
            height: 80,
          ),
          ElevatedButton(
            onPressed: () async {
              {}
              FirebaseFirestore.instance.collection("complaints").doc().set({
                "complaint": complaint.text,
                "onid": uid,
                "byid": FirebaseAuth.instance.currentUser!.uid,
                "bytype": currentusertype,
                "ontype": usertype
              }).then((value) => Navigator.pop(context));
            },
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(kGreen)),
            child: const Text("File complaint"),
          )
        ],
      )),
    );
  }
}
