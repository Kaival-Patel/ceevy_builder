import 'package:flutter/material.dart';
import 'package:resume_builder/models/profile/resume_profile_model.dart';
import 'package:resume_builder/models/resume/resume_model.dart';
import 'package:get/get.dart';
import 'dart:io';
import 'package:resume_builder/styles/app-assets.dart';

class Inferno extends StatefulWidget {
  ResumeProfile resumeProfile;

  Inferno({required this.resumeProfile, Key? key}) : super(key: key);

  @override
  State<Inferno> createState() => _InfernoState();
}

class _InfernoState extends State<Inferno> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.resumeProfile.workDetails.isNotEmpty) {
      widget.resumeProfile.workDetails
          .sort((a, b) => a.sortedPos.compareTo(b.sortedPos));
    }
    if (widget.resumeProfile.education.isNotEmpty) {
      widget.resumeProfile.education
          .sort((a, b) => a.sortedPos.compareTo(b.sortedPos));
    }
  }

  TextStyle lbodyStyle = TextStyle(
    fontSize: 9,
    color: Colors.white,
  );
  TextStyle lmedStyle = TextStyle(
    fontSize: 11,
    color: Colors.white,
    fontWeight: FontWeight.w300,
  );
  TextStyle lheadStyle =
      TextStyle(fontSize: 13, color: Colors.white, fontWeight: FontWeight.bold);
  TextStyle dheadStyle = TextStyle(
      fontSize: 13, color: Color(0xFF434343), fontWeight: FontWeight.bold);
  TextStyle dmedStyle = TextStyle(
    fontSize: 11,
    color: Color(0xFF434343),
    fontWeight: FontWeight.w300,
  );
  TextStyle dbodyStyle = TextStyle(
    fontSize: 9,
    color: Color(0xFF434343),
  );

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Expanded(
                flex: 1,
                child: Container(
                    height: context.height,
                    color: Color(0xFF346494),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(height: 20),
                                    Text(
                                        widget
                                            .resumeProfile.personalDetails.name,
                                        style: lheadStyle),
                                    Text(
                                        widget.resumeProfile.personalDetails
                                            .positionTitle,
                                        style: lmedStyle.copyWith(
                                            color: Colors.grey[200]!)),
                                  ])),
                          SizedBox(height: 20),
                          Container(
                              height: 20,
                              width: double.infinity,
                              color: Color(0xFF043a71),
                              child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 3),
                                  child:
                                      Text("Personal Info", style: lmedStyle))),
                          SizedBox(height: 5),
                          Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              child: Text('Address',
                                  style: lbodyStyle.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ))),
                          SizedBox(height: 2),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: Text(
                                widget.resumeProfile.personalDetails.address,
                                style: lbodyStyle),
                          ),
                          SizedBox(height: 5),
                          Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              child: Text('Phone',
                                  style: lbodyStyle.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ))),
                          SizedBox(height: 2),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: Text(
                                widget.resumeProfile.personalDetails.contact,
                                style: lbodyStyle),
                          ),
                          SizedBox(height: 5),
                          Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              child: Text('Email',
                                  style: lbodyStyle.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ))),
                          SizedBox(height: 2),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: Text(
                                widget.resumeProfile.personalDetails.email,
                                style: lbodyStyle),
                          ),
                          SizedBox(height: 10),
                          Container(
                              height: 20,
                              width: double.infinity,
                              color: Color(0xFF043a71),
                              child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 3),
                                  child: Text("Skills", style: lmedStyle))),
                          SizedBox(height: 5),
                          Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: widget.resumeProfile.skillDetails
                                      .map((e) => Padding(
                                          padding: EdgeInsets.only(bottom: 3),
                                          child: Text("• ${e.title}",
                                              style: lbodyStyle)))
                                      .toList())),
                        ]))),
            Expanded(
                flex: 3,
                child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 25),
                          Text(
                              "${widget.resumeProfile.sumamryDetails.introduction}",
                              style: dbodyStyle),
                          SizedBox(height: 5),
                          if (widget.resumeProfile.workDetails.isNotEmpty) ...[
                            Divider(color: Colors.grey),
                            Text("Work Experience", style: dmedStyle),
                            Divider(color: Colors.grey),
                            SizedBox(height: 5),
                            Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  for (int i = 0;
                                      i <
                                          widget
                                              .resumeProfile.workDetails.length;
                                      i++)
                                    Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Expanded(
                                            child: Text(
                                                widget.resumeProfile
                                                    .workDetails[i].time,
                                                style: dbodyStyle),
                                          ),
                                          SizedBox(width: 30),
                                          Expanded(
                                              flex: 2,
                                              child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                        widget
                                                            .resumeProfile
                                                            .workDetails[i]
                                                            .title,
                                                        style: dmedStyle),
                                                    Text(
                                                        widget
                                                            .resumeProfile
                                                            .workDetails[i]
                                                            .place,
                                                        style: dbodyStyle),
                                                    SizedBox(height: 2),
                                                    for (int j = 0;
                                                        j <
                                                            widget
                                                                .resumeProfile
                                                                .workDetails[i]
                                                                .experience
                                                                .length;
                                                        j++)
                                                      Text(
                                                          "- " +
                                                              widget
                                                                  .resumeProfile
                                                                  .workDetails[
                                                                      i]
                                                                  .experience[j],
                                                          style: dbodyStyle),
                                                    SizedBox(height: 10),
                                                  ]))
                                        ]),
                                  SizedBox(height: 10),
                                ])
                          ],
                          if (widget.resumeProfile.education.isNotEmpty) ...[
                            SizedBox(height: 20),
                            Divider(color: Colors.grey),
                            Text("Education", style: dmedStyle),
                            Divider(color: Colors.grey),
                            SizedBox(height: 5),
                            Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  for (int i = 0;
                                      i < widget.resumeProfile.education.length;
                                      i++)
                                    Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Expanded(
                                            child: Text(
                                                widget.resumeProfile
                                                    .education[i].time,
                                                style: dbodyStyle),
                                          ),
                                          SizedBox(width: 30),
                                          Expanded(
                                              flex: 2,
                                              child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                        widget.resumeProfile
                                                            .education[i].title,
                                                        style: dmedStyle),
                                                    Text(
                                                        widget.resumeProfile
                                                            .education[i].place,
                                                        style: dbodyStyle),
                                                  ]))
                                        ]),
                                  SizedBox(height: 30),
                                ])
                          ]
                        ]))),
          ])
        ],
      ),
    );
  }
}
