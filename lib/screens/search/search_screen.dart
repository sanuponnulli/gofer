import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_application_1/constants/colors.dart';
import 'package:flutter_application_1/screens/jobtemplate_screen/jobtemplate.dart';
import 'package:flutter_application_1/screens/profile/client_profile.dart';

import 'widgets/widgets.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 40,
                ),
                const Text(
                  "Top Clients",
                  style: TextStyle(fontSize: 25),
                ),
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: LimitedBox(
                      maxHeight: 200,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: List.generate(
                            10,
                            (index) => const Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 5),
                                  child: TopJobcontainer(),
                                )),
                      ),
                    )),
                const Text(
                  "Top Freelancers",
                  style: TextStyle(fontSize: 25),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: LimitedBox(
                    maxHeight: 200,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: List.generate(
                          10,
                          (index) => const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 5),
                                child: TopFlancercontainer(),
                              )),
                    ),
                  ),
                ),
                ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: joblist.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: ((context) => JobTemplate(
                                  title: joblist[index].title,
                                  description: joblist[index].description,
                                  joblocation: joblist[index].joblocation,
                                  budget: joblist[index].budget))));
                        },
                        child: SearchResultJobTile(
                          budget: joblist[index].budget.toDouble(),
                          description: joblist[index].description,
                          joblocation: joblist[index].joblocation,
                          title: joblist[index].title,
                        ),
                      );
                    })
              ],
            ),
          ),
          const CupertinoSearchTextField(
            placeholderStyle: TextStyle(color: Colors.white),
            backgroundColor: Colors.grey,
            suffixIcon: Icon(CupertinoIcons.xmark_circle_fill),
            suffixMode: OverlayVisibilityMode.editing,
          ),
        ],
      ),
    );
  }
}
