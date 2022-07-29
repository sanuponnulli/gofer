import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_application_1/screens/messages/message.dart';

class Messagescreen extends StatelessWidget {
  const Messagescreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
        children: List.generate(
            15,
            (index) => ListTile(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: ((context) => MessagingScreen())));
                  },
                  leading: CircleAvatar(backgroundColor: Colors.amber),
                  title: Text("Users name"),
                  subtitle: Text("message content"),
                )));
  }
}
