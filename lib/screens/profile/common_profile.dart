import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/colors.dart';
import 'package:flutter_application_1/dataclasses/job.dart';
import 'package:flutter_application_1/screens/jobtemplate_screen/jobtemplate.dart';

import 'client_add_details.dart';

final List<Job> joblist = List.generate(
    10,
    (index) => Job("title$index", "description$index", "joblocation$index",
        index.toDouble()));

class CommonProfile extends StatelessWidget {
  const CommonProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          "Freelancer",
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
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Text("Rating"),
                                Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                ),
                                Text("4")
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ElevatedButton(
                                    style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(kGreen)),
                                    onPressed: () {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: ((context) {
                                        return const ClientAddDetails();
                                      })));
                                    },
                                    child: const Text("Message")),
                                const SizedBox(
                                  width: 10,
                                ),
                                IconButton(
                                    onPressed: () {},
                                    icon: const Icon(
                                      Icons.call,
                                      color: kGreen,
                                    )),
                                const SizedBox(
                                  width: 10,
                                ),
                                IconButton(
                                    onPressed: () {},
                                    icon: const Icon(
                                      Icons.flag,
                                      color: Colors.red,
                                    ))
                                // ElevatedButton(
                                //     style: ButtonStyle(
                                //         backgroundColor:
                                //             MaterialStateProperty.all(kGreen)),
                                //     onPressed: () {
                                //       Navigator.of(context).push(
                                //           MaterialPageRoute(
                                //               builder: ((context) {
                                //         return const ClientAddDetails();
                                //       })));
                                //     },
                                //     child: const Text("Edit Profile")),
                              ],
                            ),
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
                            "About",
                            style: TextStyle(fontSize: 25),
                          ),
                          Text(
                              "elided 4 frames from class _RawReceivePortImpl, class _Timer, and dart:async-patchelided 4 frames from class _RawReceivePortImpl, class _Timer, and dart:async-patch"),
                        ],
                      )),
                ),
              ],
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text("Work history", style: TextStyle(fontSize: 25)),
              ),
            ),
            ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: joblist.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: ((context) => JobTemplate(
                                title: joblist[index].title,
                                description: joblist[index].description,
                                joblocation: joblist[index].joblocation,
                                budget: joblist[index].budget))));
                      },
                      trailing: const Text("02-04-2022"),
                      leading: Text(joblist[index].title),
                      subtitle: Text(joblist[index].description),
                    ),
                  );
                })
          ],
        ),
      ),
    );
  }
}

// import 'package:flutter/src/foundation/key.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter_application_1/screens/profile/client_profile.dart';

// class MyWidget extends StatelessWidget {
//   const MyWidget({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return const Clientprofile();
//   }
// }
