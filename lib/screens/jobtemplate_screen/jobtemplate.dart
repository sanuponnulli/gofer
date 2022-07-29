import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_application_1/constants/colors.dart';

class JobTemplate extends StatelessWidget {
  const JobTemplate({
    Key? key,
    required this.title,
    required this.description,
    required this.joblocation,
    required this.budget,
  }) : super(key: key);
  final String title;
  final String description;
  final String joblocation;
  final double budget;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: ListView(
            padding: EdgeInsets.zero,
            scrollDirection: Axis.vertical,
            children: [
              SizedBox(
                width: 100,
                height: 100,
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    const CircleAvatar(
                      radius: 40,
                      backgroundColor: Colors.amber,
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: const [
                        Text(
                          'Client NAme ',
                          style: TextStyle(fontSize: 25),
                        ),
                        Text(
                          'Client ph:5454554',
                          style: TextStyle(fontSize: 18),
                        ),
                        Text(
                          'posted at 10 06 2022',
                          style: TextStyle(fontSize: 13),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Text(
                title,
                style:
                    const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              Card(
                child: Container(
                  width: MediaQuery.of(context).size.width * 95,
                  height: 270,
                  color: const Color(0xFFF5F5F5),
                  child: Text(
                    "${description}atsdsagvhfdgaywgywgdfghgfhsgfhgefjrhgukhgdfhhfdjkhkfhdhgujhfdjhgjhdgjhdhfguhdfugegyurhjehguuyrguwhguherjoijgihreugrighurhguihrguhrguhrughru",
                    style: const TextStyle(fontSize: 15),
                  ),
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text(
                        'Budget',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        budget.toString(),
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                  Align(
                    alignment: AlignmentDirectional(0, 0),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text(
                          'Location',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          joblocation,
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                width: 100,
                height: 100,
              ),
              ElevatedButton(onPressed: () {}, child: Text("Delete")),
              ElevatedButton(onPressed: () {}, child: Text("put proposal")),
            ],
          ),
        ),
      ),
    );
  }
}
