import 'package:flutter/material.dart';
import 'package:resume_builder/models/resume/resume_model.dart';
import 'package:get/get.dart';

class Aztec extends StatelessWidget {
  Aztec({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(
          "RON HERRING",
          style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 5,
        ),
        Text(
          "4311, EDINGTON DRIVE, SMYRNA, GA 002339 (123) 456-7890",
          style: TextStyle(fontSize: 12, color: Colors.grey),
        ),
        Divider(
          thickness: 2,
          color: context.theme.accentColor,
        ),
        SizedBox(
          height: 5,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
                flex: 2,
                child: Text(
                  "PROFESSIONAL SUMMARY",
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                )),
            SizedBox(
              width: 10,
            ),
            Expanded(
                flex: 4,
                child: Text(
                  "Successful history developing Independent Contractor Intelligence to improve the business operation planning and implementation.Knowledgeable about business best  ractices,regulatory standards and optimal control systems.",
                  style: TextStyle(fontSize: 11),
                )),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
                flex: 2,
                child: Text(
                  "SKILLS",
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                )),
            SizedBox(
              width: 10,
            ),
            Expanded(
                flex: 4,
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "• Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
                            style: TextStyle(fontSize: 11),
                          ),
                          Text(
                            "• It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged.",
                            style: TextStyle(fontSize: 11),
                          ),
                          Text(
                            "• Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam",
                            style: TextStyle(fontSize: 11),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      flex: 1,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "• Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
                            style: TextStyle(fontSize: 11),
                          ),
                          Text(
                            "• It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged.",
                            style: TextStyle(fontSize: 11),
                          ),
                          Text(
                            "• Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam",
                            style: TextStyle(fontSize: 11),
                          ),
                        ],
                      ),
                    ),
                  ],
                )),
          ],
        ),
      ]),
    );
  }
}
