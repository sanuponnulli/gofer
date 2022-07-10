import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_application_1/constants/constants.dart';

import '../../constants/colors.dart';

class AddJob extends StatefulWidget {
  const AddJob({Key? key}) : super(key: key);

  @override
  State<AddJob> createState() => _AddJobState();
}

class _AddJobState extends State<AddJob> {
  DateTime? _selecteddate;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: const Text("Add Job",
                  style: TextStyle(
                    fontSize: 20,
                  )),
            ),
            Row(
              children: [
                Flexible(
                  child: TextFormField(
                      decoration: const InputDecoration(
                          hintText: "Job title",
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: kGreen, width: 2)),
                          border: OutlineInputBorder())),
                ),
                TextButton.icon(
                    onPressed: () async {
                      final _selecteddatetemp = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate:
                              DateTime.now().subtract(const Duration(days: 30)),
                          lastDate: DateTime.now());
                      if (_selecteddatetemp == null) {
                        return;
                      }
                      print(_selecteddatetemp.toString());
                      setState(() {
                        _selecteddate = _selecteddatetemp;
                      });
                    },
                    icon: const Icon(
                      Icons.calendar_today,
                      color: kGreen,
                    ),
                    label: Text(
                      _selecteddate == null
                          ? "select deadline"
                          : _selecteddate.toString().trim().split(" ")[0],
                      style: const TextStyle(color: kGreen),
                    ))
                // else
                //   Text(_selecteddate.toString()),
                ,
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            TextFormField(
                maxLines: 5,
                decoration: const InputDecoration(
                    hintText: "Job Description",
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: kGreen, width: 2)),
                    border: OutlineInputBorder())),
            const SizedBox(
              height: 30,
            ),
            Row(
              children: [
                Flexible(
                  flex: 1,
                  child: TextFormField(
                      decoration: const InputDecoration(
                          hintText: "Job Location",
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: kGreen, width: 2)),
                          border: OutlineInputBorder())),
                ),
                const SizedBox(
                  width: 150,
                )
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              children: [
                Flexible(
                  child: TextFormField(
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                          hintText: "Budget",
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: kGreen, width: 2)),
                          border: OutlineInputBorder())),
                ),
                const SizedBox(
                  width: 200,
                )
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            // TextFormField(
            //     decoration: InputDecoration(
            //         hintText: "Job title",
            //         focusedBorder: OutlineInputBorder(
            //             borderSide: BorderSide(color: kGreen, width: 2)),
            //         border: const OutlineInputBorder())),
            // SizedBox(
            //   height: 30,
            // ),
            // TextFormField(
            //     decoration: InputDecoration(
            //         hintText: "Job title",
            //         focusedBorder: OutlineInputBorder(
            //             borderSide: BorderSide(color: kGreen, width: 2)),
            //         border: const OutlineInputBorder())),
            const SizedBox(
              height: 30,
            ),
            ElevatedButton(
              onPressed: () {},
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(kGreen)),
              child: const Text("   Post Job    "),
            )
          ],
        ),
      ),
    );
  }
}
