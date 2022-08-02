import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/colors.dart';

class ClientProposals extends StatelessWidget {
  const ClientProposals({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        initialIndex: 1,
        length: 2,
        child: Scaffold(
          appBar: const TabBar(
            labelColor: Colors.black,
            indicatorColor: kGreen,
            tabs: <Widget>[
              Tab(
                text: "Offers",
                icon: Icon(Icons.pages_outlined),
              ),
              Tab(
                text: "Accepted proposals",
                icon: Icon(Icons.local_offer),
              ),
            ],
          ),
          body: TabBarView(
            children: [
              ListView.separated(
                  itemBuilder: (context, index) {
                    return ListTile(
                      subtitle: const Text("Freelancer profile name"),
                      title: SizedBox(
                        height: 200,
                        child: ListView(
                          children: const [
                            Text("Description"),
                            Text(
                                "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum")
                          ],
                        ),
                      ),
                      trailing: IconButton(
                        color: kGreen,
                        icon: const Icon(Icons.check),
                        onPressed: () {},
                      ),
                      leading: Column(children: const [
                        Text(
                          "Bid Price",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text("Rs 500"),
                      ]),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const Divider();
                  },
                  itemCount: 20),
              ListView.separated(
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: const Text("freelancer name"),
                      leading: const Text("Job title"),
                      trailing: ElevatedButton.icon(
                          onPressed: () {},
                          icon: const Icon(Icons.check),
                          label: const Text("job complete PAY")),
                      //     trailing: IconButton(
                      //   onPressed: () {},
                      //   icon: Icon(Icons.check),
                      // )
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const Divider();
                  },
                  itemCount: 20)
            ],
          ),
        ));
  }
}
