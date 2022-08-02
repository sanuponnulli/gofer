import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/colors.dart';

class MyStats extends StatelessWidget {
  const MyStats({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                      const Text("\$2455.5",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                          )),
                      const SizedBox(
                        height: 50,
                      ),
                      Row(
                        children: [
                          MaterialButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                side: const BorderSide(color: Colors.white)),
                            color: Colors.white,
                            onPressed: () {},
                            child: const Text(
                              "Deposit",
                              style: TextStyle(color: kGreen),
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          MaterialButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                side: const BorderSide(color: Colors.green)),
                            color: Colors.red,
                            onPressed: () {},
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
            const Expanded(
              child: History(),
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
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        itemBuilder: (ctx, index) {
          return ListTile(
            // tileColor: kGreen,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
              side: const BorderSide(
                color: kGreen,
              ),
            ),
            hoverColor: kGreen,
            leading: const CircleAvatar(
              backgroundColor: Colors.amber,
            ),
          );
        },
        separatorBuilder: (ctx, index) {
          return const Divider();
        },
        itemCount: 10);
  }
}
