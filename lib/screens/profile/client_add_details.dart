import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../constants/colors.dart';

class ClientAddDetails extends StatelessWidget {
  const ClientAddDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Profile",
              style: TextStyle(fontSize: 20),
            ),
            TextFormField(
                decoration: const InputDecoration(
                    hintText: "First Name",
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: kGreen, width: 2)),
                    border: OutlineInputBorder())),
            TextFormField(
                decoration: const InputDecoration(
                    hintText: "Last Name ",
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: kGreen, width: 2)),
                    border: OutlineInputBorder())),
            TextFormField(
                decoration: const InputDecoration(
                    hintText: "E mail",
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: kGreen, width: 2)),
                    border: OutlineInputBorder())),
            TextFormField(
                decoration: const InputDecoration(
                    hintText: "Phone number",
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: kGreen, width: 2)),
                    border: OutlineInputBorder())),
            TextFormField(
                decoration: const InputDecoration(
                    hintText: "Company Name ",
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: kGreen, width: 2)),
                    border: OutlineInputBorder())),
            ElevatedButton(
              onPressed: () {},
              child: Text(
                "     Save     ",
              ),
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(kGreen)),
            )
          ],
        ),
      ),
    ));
  }
}
