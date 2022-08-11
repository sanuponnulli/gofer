import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/colors.dart';
import 'package:flutter_application_1/dataclasses/job.dart';
import 'package:flutter_application_1/screens/jobtemplate_screen/jobtemplate.dart';

import 'client_add_details.dart';

final List<Job> joblist = List.generate(
    10,
    (index) => Job("title$index", "description$index", "joblocation$index",
        index.toDouble()));

class FreelancerProfile extends StatelessWidget {
  const FreelancerProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: const Color.fromARGB(255, 231, 227, 227),
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
                            //const Text("Name@gmail"),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Text("Rating"),
                                Icon(Icons.star),
                                Text("4")
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const SizedBox(
                                  width: 10,
                                ),
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
                                    child: const Text("Edit Profile")),
                              ],
                            ),
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
                Column(
                  children: [
                    Card(
                      elevation: 10,
                      child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text(
                                "Email Id",
                                style: TextStyle(fontSize: 20),
                              ),
                              Text("name@gmail.com")
                            ],
                          )),
                    ),
                  ],
                ),
                Card(
                  elevation: 10,
                  child: Container(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            "Heading",
                            style: TextStyle(fontSize: 20),
                          ),
                          Text(
                              "The part of the design process that is independent of any specific hardware or software platform is referred to as logical design. During logical design, all functional features of the system chosen for development in analysis phase are described independently of any computer platform. Logical design concentrates on the business aspects of the system and tends to be oriented to a high level of specificity. During logical design of the proposed system, all the "),
                        ],
                      )),
                ),
              ],
            ),
            Column(
              children: [
                Card(
                  elevation: 10,
                  child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            "Contact Deatails",
                            style: TextStyle(fontSize: 20),
                          ),
                          Text("6258945288")
                        ],
                      )),
                ),
              ],
            ),
            Column(
              children: [
                Card(
                  elevation: 10,
                  child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            "Company Deatails",
                            style: TextStyle(fontSize: 20),
                          ),
                          Text("Company name"),
                          Text(
                              "The part of the design process that is independent of any specific hardware or software platform is referred to as logical design. During logical design, all functional features of the system chosen for development in analysis phase are described independently of any computer platform. Logical design concentrates on the business aspects of the system and tends to be oriented to a high level of specificity. During logical design of the proposed system, all the ")
                        ],
                      )),
                ),
              ],
            ),
            ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: joblist.length,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 5,
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
