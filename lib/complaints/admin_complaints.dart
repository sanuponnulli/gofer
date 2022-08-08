import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/messages/message.dart';

class ComplaintsAdmin extends StatelessWidget {
  const ComplaintsAdmin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
        children: List.generate(
            15,
            (index) => ListTile(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: ((context) => const ChatScreen())));
                  },
                  leading: const CircleAvatar(backgroundColor: Colors.amber),
                  title: const Text("Users name"),
                  subtitle: const Text("Complaint content"),
                  trailing: IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.message_rounded)),
                )));
  }
}
