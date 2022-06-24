import 'package:flutter/material.dart';
import 'package:resume_builder/models/profile/resume_profile_model.dart';
import 'package:resume_builder/models/resume/resume_model.dart';
import 'package:get/get.dart';

class Aztec extends StatefulWidget {
  ResumeProfile resumeProfile;
  Aztec({required this.resumeProfile, Key? key}) : super(key: key);

  @override
  State<Aztec> createState() => _AztecState();
}

class _AztecState extends State<Aztec> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.resumeProfile.workDetails
        .sort((a, b) => a.sortedPos.compareTo(b.sortedPos));
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(
          "${widget.resumeProfile.personalDetails.name.toUpperCase()}",
          style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 5,
        ),
        Text(
          "${widget.resumeProfile.personalDetails.address}",
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
                  "${widget.resumeProfile.sumamryDetails.introduction}",
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
                flex: 1,
                child: Text(
                  "SKILLS",
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                )),
            SizedBox(
              width: 10,
            ),
            Expanded(
              flex: 2,
              child: Container(
                width: context.width,
                child: Wrap(
                  crossAxisAlignment: WrapCrossAlignment.start,
                  alignment: WrapAlignment.start,
                  spacing: 5,
                  runSpacing: 1,
                  children: widget.resumeProfile.skillDetails
                      .map((e) => Text(
                            "-" + e.title,
                            style: TextStyle(fontSize: 11),
                          ))
                      .toList(),
                ),
              ),
            )
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
                flex: 1,
                child: Text(
                  "WORK HISTORY",
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                )),
            SizedBox(
              width: 10,
            ),
            Expanded(
              flex: 2,
              child: Container(
                  width: context.width,
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.only(bottom: 5.0),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.resumeProfile.workDetails[index].time,
                              style: TextStyle(
                                  fontSize: 11,
                                  color: context.theme.disabledColor),
                            ),
                            Row(
                              children: [
                                Text(
                                  widget.resumeProfile.workDetails[index].title,
                                  style: TextStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  " | " +
                                      widget.resumeProfile.workDetails[index]
                                          .place,
                                  style: TextStyle(
                                    fontSize: 11,
                                  ),
                                ),
                              ],
                            ),
                            for (int i = 0;
                                i <
                                    widget.resumeProfile.workDetails[index]
                                        .experience.length;
                                i++)
                              Text(
                                "- " +
                                    "${widget.resumeProfile.workDetails[index].experience[i]}",
                                style: TextStyle(
                                  fontSize: 11,
                                ),
                              ),
                          ]),
                    ),
                    itemCount: widget.resumeProfile.workDetails.length,
                  )),
            )
          ],
        ),
        SizedBox(
          height: 5,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
                flex: 1,
                child: Text(
                  "EDUCATION",
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                )),
            SizedBox(
              width: 10,
            ),
            Expanded(
              flex: 2,
              child: Container(
                  width: context.width,
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.only(bottom: 5.0),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.resumeProfile.education[index].time,
                              style: TextStyle(
                                  fontSize: 11,
                                  color: context.theme.disabledColor),
                            ),
                            Row(
                              children: [
                                Text(
                                  widget.resumeProfile.education[index].title,
                                  style: TextStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  " | " +
                                      widget
                                          .resumeProfile.education[index].place,
                                  style: TextStyle(
                                    fontSize: 11,
                                  ),
                                ),
                              ],
                            ),
                          ]),
                    ),
                    itemCount: widget.resumeProfile.education.length,
                  )),
            )
          ],
        ),
      ]),
    );
  }
}
