import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/colors.dart';

class MyStats extends StatelessWidget {
  const MyStats({Key? key, required this.id, required this.usertype})
      : super(key: key);

  final String id;
  final String usertype;
  @override
  Widget build(BuildContext context) {
    ValueNotifier<int> balancenotifier = ValueNotifier(0);
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            "My Stats",
            style: TextStyle(color: kGreen),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                decoration: const BoxDecoration(
                    color: kGreen,
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                width: size.width * .96,
                height: 200,
                child: Padding(
                  padding: const EdgeInsets.all(18),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Total Balance",
                        style: TextStyle(color: Colors.white),
                      ),
                      StreamBuilder<DocumentSnapshot>(
                          stream: FirebaseFirestore.instance
                              .collection("wallet")
                              .doc(id)
                              .snapshots(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              final wallet =
                                  snapshot.data!.data() as Map<String, dynamic>;
                              balancenotifier.value = wallet["balance"];
                              balancenotifier.notifyListeners();

                              return Text("Rs.${wallet["balance"].toString()}",
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 30,
                                  ));
                            } else {
                              return const Text("0",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 30,
                                  ));
                            }
                          }),
                      const SizedBox(
                        height: 50,
                      ),
                      Row(
                        children: [
                          usertype == "Client"
                              ? MaterialButton(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      side: const BorderSide(
                                          color: Colors.white)),
                                  color: Colors.white,
                                  onPressed: () async {
                                    TextEditingController balane =
                                        TextEditingController();
                                    AlertDialog alert = AlertDialog(
                                      title: const Text("Add money"),
                                      content: TextField(
                                        controller: balane,
                                        decoration: const InputDecoration(
                                          focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: kGreen, width: 2)),
                                          border: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: kGreen, width: 5)),
                                          hintText: "Type Amount",
                                        ),
                                        keyboardType: TextInputType.number,
                                      ),
                                      actions: [
                                        ValueListenableBuilder(
                                            valueListenable: balane,
                                            builder: (context, value, _) {
                                              return ElevatedButton(
                                                  onPressed: () async {
                                                    DateTime now =
                                                        DateTime.now();
                                                    FirebaseFirestore.instance
                                                        .collection("wallet")
                                                        .doc(id)
                                                        .update({
                                                      "balance": balancenotifier
                                                              .value +
                                                          int.parse(
                                                              balane.text),
                                                      "transaction": FieldValue
                                                          .arrayUnion([
                                                        {
                                                          "amount": balane.text,
                                                          "date": DateTime(
                                                              now.year,
                                                              now.month,
                                                              now.day,
                                                              now.hour,
                                                              now.minute),
                                                          "type": true
                                                        }
                                                      ])
                                                    }).then((value) =>
                                                            Navigator.pop(
                                                                context));
                                                  },
                                                  style: ButtonStyle(
                                                      backgroundColor:
                                                          MaterialStateProperty
                                                              .all<Color>(
                                                                  kGreen)),
                                                  child: const Text("Add"));
                                            }),
                                      ],
                                    );

                                    // show the dialog
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return alert;
                                      },
                                    );
                                  },
                                  child: const Text(
                                    "Deposit",
                                    style: TextStyle(color: kGreen),
                                  ),
                                )
                              : SizedBox(),
                          const SizedBox(
                            width: 20,
                          ),
                          MaterialButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                side: const BorderSide(color: Colors.red)),
                            color: Colors.red,
                            onPressed: () async {
                              TextEditingController balane =
                                  TextEditingController();
                              AlertDialog alert = AlertDialog(
                                title: const Text("Withdraw money"),
                                content: TextField(
                                  controller: balane,
                                  decoration: const InputDecoration(
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: kGreen, width: 2)),
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: kGreen, width: 5)),
                                    hintText: "Type Amount",
                                  ),
                                  keyboardType: TextInputType.number,
                                ),
                                actions: [
                                  ValueListenableBuilder(
                                      valueListenable: balane,
                                      builder: (context, value, _) {
                                        return ElevatedButton(
                                            onPressed: () async {
                                              DateTime now = DateTime.now();
                                              if (balancenotifier.value >
                                                  int.parse(balane.text)) {
                                                FirebaseFirestore.instance
                                                    .collection("wallet")
                                                    .doc(id)
                                                    .update({
                                                  "balance": balancenotifier
                                                          .value -
                                                      int.parse(balane.text),
                                                  "transaction":
                                                      FieldValue.arrayUnion([
                                                    {
                                                      "amount": balane.text,
                                                      "date": DateTime(
                                                          now.year,
                                                          now.month,
                                                          now.day,
                                                          now.hour,
                                                          now.minute),
                                                      "type": false
                                                    }
                                                  ])
                                                }).then((value) =>
                                                        Navigator.pop(context));
                                              } else {
                                                Navigator.pop(context);
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(const SnackBar(
                                                        backgroundColor:
                                                            Colors.red,
                                                        content: Text(
                                                            "Enter a valid amount")));
                                              }
                                            },
                                            style: ButtonStyle(
                                                backgroundColor:
                                                    MaterialStateProperty.all<
                                                        Color>(Colors.red)),
                                            child: const Text("withdraw"));
                                      }),
                                ],
                              );

                              // show the dialog
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return alert;
                                },
                              );
                            },
                            child: const Text(
                              "Withdraw",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 50),
            const Text(
              "History",
              style: TextStyle(
                  color: kGreen, fontSize: 22, fontWeight: FontWeight.bold),
            ),
            Row(
              children: const [],
            ),
            Expanded(
              child: History(
                id: id,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class History extends StatelessWidget {
  const History({
    Key? key,
    required this.id,
  }) : super(key: key);
  final String id;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
        stream:
            FirebaseFirestore.instance.collection("wallet").doc(id).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final snap = snapshot.data!.data() as Map;
            final transactions = snap["transaction"] ?? [] as List;

            //transactions.sort((a, b) => (b['date']).compareTo(a['date']));
            print(transactions);
            return ListView.separated(
                itemBuilder: (ctx, index) {
                  return ListTile(
                    tileColor:
                        transactions[index]["type"] ? kGreen : Colors.red,
                    // tileColor: kGreen,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                      side: BorderSide(
                        color:
                            transactions[index]["type"] ? kGreen : Colors.red,
                      ),
                    ),
                    hoverColor: kGreen,
                    leading: Text("Rs.${transactions[index]["amount"]}",
                        style:
                            const TextStyle(fontSize: 20, color: Colors.white)),
                    trailing: Text(
                      DateTime.parse(
                              transactions[index]["date"].toDate().toString())
                          .toString()
                          .split(" ")[0]
                          .toString(),
                      style: const TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  );
                },
                separatorBuilder: (ctx, index) {
                  return const Divider();
                },
                itemCount: transactions.length);
          } else {
            return const Center(
              child: Text("Ooops! no data available"),
            );
          }
        });
  }
}
