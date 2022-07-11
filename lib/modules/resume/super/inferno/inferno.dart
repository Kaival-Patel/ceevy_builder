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
    color: Colors.white,);
  TextStyle lmedStyle = TextStyle(
    fontSize: 11,
    color: Colors.white,
    fontWeight: FontWeight.w300,);
  TextStyle lheadStyle = TextStyle(
      fontSize: 13,
      color: Colors.white,
      fontWeight: FontWeight.bold);
  TextStyle dheadStyle = TextStyle(
      fontSize: 13,
      color:Color(0xFF434343),
      fontWeight: FontWeight.bold);
  TextStyle dmedStyle = TextStyle(
    fontSize: 11,
    color: Color(0xFF434343),
    fontWeight: FontWeight.w300,);
  TextStyle dbodyStyle = TextStyle(
    fontSize: 9,
    color: Color(0xFF434343),
  );
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                flex: 3,
                child: Container(
                  height: context.height,
                  color: Color(0xFF434343),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 14.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        Center(
                          child: widget.resumeProfile.isAssetPath
                              ? ClipOval(
                              child: Image.asset(
                                widget.resumeProfile.pictureAsset,
                                height: 60,
                                width: 60,
                                fit: BoxFit.cover,
                              ))
                              : ClipOval(
                            child: Image.file(
                                File(widget.resumeProfile.pictureAsset),
                                height: 60,
                                width: 60,
                                fit: BoxFit.cover),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                            'ABOUT ME',
                            style: lmedStyle
                        ),
                        SizedBox(height: 4,),
                        Text(
                            widget.resumeProfile.sumamryDetails.introduction,
                            style: lbodyStyle
                        ),
                        SizedBox(height: 6,),
                        Divider(color: Colors.grey,),
                        SizedBox(height: 6,),
                        Text("CONTACTS", style: lheadStyle),
                        SizedBox(height: 10),
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Phone", style: lmedStyle),
                              Text(widget.resumeProfile.personalDetails.contact,
                                  style: lbodyStyle),
                              SizedBox(height: 3),
                              Text("Email", style: lmedStyle),
                              Text(widget.resumeProfile.personalDetails.email,
                                  style: lbodyStyle),
                              SizedBox(height: 3),
                              Text("Address", style: lmedStyle),
                              Text(widget.resumeProfile.personalDetails.address,
                                  style: lbodyStyle),
                              SizedBox(height: 3),
                            ]),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 5,
                child: Container(
                  height:context.height,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 10),
                          Text("${widget.resumeProfile.personalDetails.name}",
                              style: dheadStyle.copyWith(
                                  fontWeight: FontWeight.bold, fontSize: 22)),
                          SizedBox(height: 3),
                          Text("${widget.resumeProfile.personalDetails.positionTitle}",
                              style: dbodyStyle),
                          SizedBox(height: 10),
                          if (widget.resumeProfile.workDetails.isNotEmpty) ...[
                            Divider(color: Colors.grey),
                            SizedBox(height: 10),
                            Text("WORK EXPERIENCE", style: dheadStyle),
                            SizedBox(height: 5),
                            Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  for (int i = 0;
                                  i < widget.resumeProfile.workDetails.length;
                                  i++)
                                    Row(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          Expanded(
                                            child: Column(
                                                crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                      widget.resumeProfile
                                                          .workDetails[i].place,
                                                      style: dmedStyle),
                                                  Text(
                                                      widget.resumeProfile
                                                          .workDetails[i].time,
                                                      style: dbodyStyle),
                                                ]),
                                          ),
                                          SizedBox(width: 10),
                                          Expanded(
                                            child: Column(
                                                crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                                children: [

                                                  Text(
                                                      widget.resumeProfile
                                                          .workDetails[i].title,
                                                      style: dmedStyle.copyWith(fontWeight: FontWeight.bold)),
                                                  for (int j = 0;
                                                  j <
                                                      widget.resumeProfile
                                                          .workDetails[i]
                                                          .experience
                                                          .length;
                                                  j++)
                                                    Text(
                                                        widget.resumeProfile.workDetails[i]
                                                            .experience[j],
                                                        style: dbodyStyle),
                                                  SizedBox(height: 15),
                                                ]),
                                          )
                                        ]),

                                ])
                          ],
                          if (widget.resumeProfile.education.isNotEmpty) ...[
                            Divider(color: Colors.grey),
                            SizedBox(height: 10),
                            Text("EDUCATION", style: dheadStyle),
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
                                            child: Column(
                                                crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                      widget.resumeProfile
                                                          .education[i].place,
                                                      style: dmedStyle),
                                                  Text(
                                                      widget.resumeProfile
                                                          .education[i].time,
                                                      style: dbodyStyle),
                                                ]),
                                          ),
                                          SizedBox(width: 10),
                                          Expanded(
                                            child: Column(
                                                crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                      widget.resumeProfile
                                                          .education[i].title,
                                                      style: dmedStyle),
                                                ]),
                                          )
                                        ])
                                ])
                          ]
                        ]),
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
