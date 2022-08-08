import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/colors.dart';

class Requestpage extends StatelessWidget {
  const Requestpage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: ListView.separated(
              itemBuilder: (context, index) {
                return const AcceptReject();
              },
              separatorBuilder: (context, index) {
                return const Divider();
              },
              itemCount: 20)),
    );
  }
}

class AcceptReject extends StatelessWidget {
  const AcceptReject({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
        child: SizedBox(
      width: double.infinity,
      height: 100,
      //color: Colors.amber,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const CircleAvatar(
            radius: 40,
            backgroundColor: kGreen,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  "username",
                  style: TextStyle(fontSize: 20),
                ),
                Text(
                  "Gmail",
                  style: TextStyle(fontSize: 20),
                ),
              ],
            ),
          ),
          const SizedBox(
            width: 50,
          ),
          Column(children: [
            ElevatedButton(onPressed: () {}, child: const Text("Accept")),
            ElevatedButton(
              onPressed: () {},
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.red)),
              child: const Text("Reject"),
            )
          ])
        ],
      ),
    ));
  }
}
