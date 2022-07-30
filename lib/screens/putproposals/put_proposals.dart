import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_application_1/constants/colors.dart';

class PutProposal extends StatelessWidget {
  const PutProposal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
            Text(
              "Bid Price",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            SizedBox(
              height: 10,
            ),
            SizedBox(
              width: 200,
              child: TextFormField(
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
            SizedBox(
              height: 10,
            ),
            Text(
              "Description ",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
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
            SizedBox(
              height: 10,
            ),
            Text(
              "Bid Price",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              // keyboardType: TextInputType.number,
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
            const SizedBox(
              height: 30,
            ),
            ElevatedButton(
              onPressed: () {},
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
