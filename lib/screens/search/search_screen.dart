import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_application_1/constants/colors.dart';

import 'widgets/widgets.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CupertinoSearchTextField(
              suffixIcon: Icon(CupertinoIcons.xmark_circle_fill),
              suffixMode: OverlayVisibilityMode.editing,
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
            const SearchResultJobTile()
          ],
        ),
      ),
    );
  }
}
