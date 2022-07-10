import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_application_1/constants/colors.dart';

import 'client_add_details.dart';

class Clientprofile extends StatelessWidget {
  const Clientprofile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          "Client",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        physics: const ScrollPhysics(),
        child: Column(
          children: [
            const SizedBox(
              height: 15,
              width: 15,
            ),
            SizedBox(
              height: 250,
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Card(
                      elevation: 10,
                      child: SizedBox(
                        height: 220,
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          children: [
                            const SizedBox(
                              width: 200,
                              height: 60,
                            ),
                            const Text("Name",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 25)),
                            const Text("Name@gmail"),
                            const Text("Rating"),
                            const SizedBox(
                              height: 10,
                            ),
                            ElevatedButton(
                                style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all(kGreen)),
                                onPressed: () {
                                  Navigator.of(context).push(
                                      MaterialPageRoute(builder: ((context) {
                                    return const ClientAddDetails();
                                  })));
                                },
                                child: const Text("Edit Profile")),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: InkWell(
                                child: const Text(
                                  "Add more Details",
                                  style: TextStyle(color: kGreen),
                                ),
                                onTap: () {
                                  Navigator.of(context).push(
                                      MaterialPageRoute(builder: ((context) {
                                    return const ClientAddDetails();
                                  })));
                                },
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  const Align(
                    alignment: Alignment.topCenter,
                    child: CircleAvatar(
                      radius: 40,
                      backgroundImage: NetworkImage(
                          "http://wallpapercave.com/wp/wp4717135.jpg"),
                      backgroundColor: Colors.amber,
                    ),
                  ),
                ],
              ),
            ),
            Column(
              children: [
                Card(
                  child: Container(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            "Heading",
                            style: TextStyle(fontSize: 25),
                          ),
                          Text(
                              "elided 4 frames from class _RawReceivePortImpl, class _Timer, and dart:async-patchelided 4 frames from class _RawReceivePortImpl, class _Timer, and dart:async-patch"),
                        ],
                      )),
                ),
              ],
            ),
            ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: 10,
                itemBuilder: (context, index) {
                  return const Card(
                    child: ListTile(
                      trailing: Text("02-04-2022"),
                      leading: Text("job title"),
                      subtitle: Text(
                          "ehfgdhfbydsgfyusdgyufgdsuygfuysdgygdyufgdshfjsdgfjsdghvcdghcfghdfcgfgh"),
                    ),
                  );
                })
          ],
        ),
      ),
    );
  }
}