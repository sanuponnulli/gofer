import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/colors.dart';
import 'package:flutter_application_1/dataclasses/job.dart';
import 'package:flutter_application_1/screens/jobtemplate_screen/jobtemplate.dart';
import 'package:flutter_application_1/services/imagepicker.dart';
import 'package:flutter_application_1/services/storageservices.dart';
import 'package:flutter_application_1/models/user.dart' as model;

import 'package:image_picker/image_picker.dart';

import 'client_add_details.dart';

final List<Job> joblist = List.generate(
    10,
    (index) => Job("title$index", "description$index", "joblocation$index",
        index, DateTime.now()));

class FreelancerProfile extends StatelessWidget {
  const FreelancerProfile({Key? key, required this.uid}) : super(key: key);
  final String uid;

  @override
  Widget build(BuildContext context) {
    void selectImage() async {
      Uint8List img = await pickImage(ImageSource.gallery);

      try {
        Storagemethods storagemethods = Storagemethods();
        String url = await storagemethods.uploadimage(img);
        FirebaseFirestore.instance
            .collection("Freelancer")
            .doc(uid)
            .update({"file": url});
      } catch (e) {
        print("error at storing image${e.toString()}");
      }
    }

    return Scaffold(
      // backgroundColor: const Color.fromARGB(255, 231, 227, 227),
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          "Freelancer",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        physics: const ScrollPhysics(),
        child: StreamBuilder<Object>(
            stream: FirebaseFirestore.instance
                .collection("Freelancer")
                .doc(uid)
                .snapshots(),
            builder: (context, snapshot) {
              late model.User data1;
              // = model.User(
              //     email: "", password: "", usertype: "", name1: "", name2: "");
              if (snapshot.hasData) {
                data1 = model.User.fromsnap(snapshot.data as DocumentSnapshot);
                print(data1.phonenumber);
              }
              return !snapshot.hasData
                  ? Center(
                      child: const CircularProgressIndicator(
                      color: kGreen,
                    ))
                  : Column(
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
                                        Text(data1.name1,
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 25)),
                                        //const Text("Name@gmail"),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
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
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            ElevatedButton(
                                                style: ButtonStyle(
                                                    backgroundColor:
                                                        MaterialStateProperty
                                                            .all(kGreen)),
                                                onPressed: () {
                                                  Navigator.of(context).push(
                                                      MaterialPageRoute(
                                                          builder: ((context) {
                                                    return const ClientAddDetails(
                                                      usertype: 'Client',
                                                    );
                                                  })));
                                                },
                                                child:
                                                    const Text("Edit Profile")),
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
                                                  MaterialPageRoute(
                                                      builder: ((context) {
                                                return const ClientAddDetails(
                                                  usertype: 'Freelancer',
                                                );
                                              })));
                                            },
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.topCenter,
                                child: Stack(
                                  children: [
                                    data1.file == ""
                                        ? const CircleAvatar(
                                            radius: 40,
                                            backgroundImage: NetworkImage(
                                                "http://wallpapercave.com/wp/wp4717135.jpg"),
                                            backgroundColor: Colors.amber,
                                          )
                                        : CircleAvatar(
                                            radius: 40,
                                            backgroundImage:
                                                NetworkImage(data1.file),
                                            backgroundColor: Colors.amber,
                                          ),
                                    Positioned(
                                      bottom: 0,
                                      right: 0,
                                      child: InkWell(
                                        onTap: () {
                                          selectImage();
                                        },
                                        child: const Icon(
                                          Icons.camera_front_outlined,
                                          color: Colors.white,
                                        ),
                                      ),
                                    )
                                  ],
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
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            "Email Id",
                                            style: TextStyle(fontSize: 20),
                                          ),
                                          Text(data1.email)
                                        ],
                                      )),
                                ),
                              ],
                            ),
                            Card(
                              elevation: 10,
                              child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  padding: const EdgeInsets.all(10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        "About",
                                        style: TextStyle(fontSize: 20),
                                      ),
                                      Text(data1.about),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        "Contact Deatails",
                                        style: TextStyle(fontSize: 20),
                                      ),
                                      Text(data1.phonenumber)
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        data1.companyname,
                                        style: TextStyle(fontSize: 20),
                                      ),
                                      Text(data1.companydetails)
                                    ],
                                  )),
                            ),
                          ],
                        ),
                        ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: data1.jobs.length,
                            itemBuilder: (context, index) {
                              final List jid = data1.jobs;
                              return StreamBuilder<Object>(
                                  stream: FirebaseFirestore.instance
                                      .collection("jobs")
                                      .doc(jid[index])
                                      .snapshots(),
                                  builder: (context, snapshot) {
                                    late Map<String, dynamic> dd;
                                    if (snapshot.hasData) {
                                      DocumentSnapshot daat =
                                          snapshot.data as DocumentSnapshot;
                                      dd = daat.data() as Map<String, dynamic>;
                                    }
                                    // print(dd);
                                    return !snapshot.hasData
                                        ? Center(
                                            child: CircularProgressIndicator(
                                                color: Colors.amber),
                                          )
                                        : Card(
                                            elevation: 5,
                                            child: ListTile(
                                              onTap: () {
                                                Navigator.of(context).push(
                                                    MaterialPageRoute(
                                                        builder: ((context) =>
                                                            JobTemplate(
                                                              title:
                                                                  dd["title"],
                                                              description: dd[
                                                                  "description"],
                                                              joblocation: dd[
                                                                  "location"],
                                                              budget:
                                                                  dd["budget"],
                                                              jobid:
                                                                  dd["jobid"],
                                                              date: dd[
                                                                      "deadline"]
                                                                  .toDate()
                                                                  .toString(),
                                                              user: dd["user"],
                                                            ))));
                                              },
                                              trailing: Text(DateTime.parse(
                                                      dd["deadline"]
                                                          .toDate()
                                                          .toString())
                                                  .toString()
                                                  .split(" ")[0]),
                                              leading: Text(dd["title"]),
                                              subtitle: Text(dd["description"]),
                                            ),
                                          );
                                  });
                            })
                      ],
                    );
            }),
      ),
    );
  }
}
