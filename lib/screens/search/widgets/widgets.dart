import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_application_1/constants/colors.dart';

class TopJobcontainer extends StatelessWidget {
  const TopJobcontainer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        decoration: BoxDecoration(
            color: kcontainercolor, borderRadius: BorderRadius.circular(10)),
        height: 150,
        width: 120,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Row(
                children: const [
                  CircleAvatar(
                    backgroundImage: NetworkImage(
                        "https://cdn.britannica.com/51/190751-050-147B93F7/soccer-ball-goal.jpg?q=60"),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text("Name")
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class TopFlancercontainer extends StatelessWidget {
  const TopFlancercontainer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
        height: 170,
        width: 300,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: const [
                  CircleAvatar(
                    backgroundImage: NetworkImage(
                        "https://cdn.britannica.com/51/190751-050-147B93F7/soccer-ball-goal.jpg?q=60"),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text("Name")
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class SearchResultJobTile extends StatelessWidget {
  const SearchResultJobTile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: const [
                      SizedBox(
                        width: 250,
                        child: Text(
                          "I wasddddddddddddddddddddddddddnt to transfer Goods from a to b",
                          style: TextStyle(
                              color: kGreen,
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  IconButton(
                    icon: const Icon(Icons.save),
                    onPressed: () {},
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: const [
                  Text("posted 24m ago", style: TextStyle(color: Colors.grey))
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              ListTile(
                leading: Column(
                  children: const [
                    Text(
                      "\$20",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "Budget",
                      style: TextStyle(color: Colors.grey),
                    )
                  ],
                ),
                trailing: Column(
                  children: const [
                    Text(
                      "10-05-2022",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "Date",
                      style: TextStyle(color: Colors.grey),
                    )
                  ],
                ),
              ),
              Column(
                children: const [
                  Text(
                      style: TextStyle(fontSize: 15),
                      "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for 'lorem ipsum' will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like).")
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: const [
                  Text("tag", style: TextStyle(color: Colors.grey)),
                  Text("tag2", style: TextStyle(color: Colors.grey)),
                  Text("tag3", style: TextStyle(color: Colors.grey))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
