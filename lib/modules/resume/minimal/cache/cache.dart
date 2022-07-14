import 'package:flutter/material.dart';
import 'package:resume_builder/models/profile/resume_profile_model.dart';
import 'package:resume_builder/models/resume/resume_model.dart';
import 'package:get/get.dart';
import 'dart:io';
import 'package:resume_builder/styles/app-assets.dart';

class Cache extends StatefulWidget {
  ResumeProfile resumeProfile;

  Cache({required this.resumeProfile, Key? key}) : super(key: key);

  @override
  State<Cache> createState() => _CacheState();
}

class _CacheState extends State<Cache> {
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
      child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Expanded(
            flex: 1,
            child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 5),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      SizedBox(height: 35),
                      ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child:  widget.resumeProfile.isAssetPath
                              ? Image.asset(widget.resumeProfile.pictureAsset,
                              height: 80, width: 80, fit: BoxFit.cover)
                              : Image.file(File(widget.resumeProfile.pictureAsset),
                              height: 80 , width: 80, fit: BoxFit.cover)),
                      SizedBox(height: 20),
                      Text("EDUCATION", style: dheadStyle),
                      SizedBox(height: 10),
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: widget.resumeProfile.education
                              .map((e) => Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Padding(
                                            padding: EdgeInsets.only(
                                                bottom: 3),
                                            child: Text("${e.title}",
                                                style: dbodyStyle.copyWith(
                                                    fontWeight:
                                                        FontWeight.bold,))),
                                        Padding(
                                            padding: EdgeInsets.only(
                                                bottom: 3),
                                            child: Text("${e.place}",
                                                style: dbodyStyle)),
                                      ]))
                              .toList()),
                      SizedBox(height: 10),
                      Divider(
                          color: Colors.grey[100]!),
                      SizedBox(height: 5),
                      Text("SKILLS", style: dheadStyle),
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children:  widget.resumeProfile.skillDetails
                              .map((e) => Padding(
                                  padding: EdgeInsets.only(bottom: 3),
                                  child: Text("${e.title}",
                                      style: dbodyStyle)))
                              .toList()),
                      SizedBox(height: 10),
                      Divider(
                          color: Colors.grey[100]!),
                      SizedBox(height: 10),
                      Text("CONTACT", style: dheadStyle),
                      SizedBox(height: 5),
                      Text('Address',
                          style: dbodyStyle.copyWith(
                              fontWeight: FontWeight.bold,)),
                      SizedBox(height: 2),
                      Text( widget.resumeProfile.personalDetails.address,
                          style: dbodyStyle,textAlign: TextAlign.right,),
                      SizedBox(height: 5),
                      Text('Phone',
                          style: dbodyStyle.copyWith(
                              fontWeight: FontWeight.bold,)),
                      SizedBox(height: 2),
                      Text( widget.resumeProfile.personalDetails.contact,
                          style: dbodyStyle),
                      SizedBox(height: 5),
                      Text('Email',
                          style: dbodyStyle.copyWith(
                              fontWeight: FontWeight.bold,)),
                      SizedBox(height: 2),
                      Text( widget.resumeProfile.personalDetails.email,
                          style: dbodyStyle),
                      SizedBox(height: 10),
                    ]))),
        VerticalDivider(color: Colors.white30),
        Expanded(
            flex: 2,
            child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 35),
                      Text("${ widget.resumeProfile.personalDetails.name}",
                          style: dheadStyle.copyWith(
                              fontWeight: FontWeight.bold, fontSize: 19)),
                      Text("${ widget.resumeProfile.personalDetails.positionTitle}",
                          style: dbodyStyle.copyWith(
                              fontWeight: FontWeight.bold,)),
                      SizedBox(height: 5),
                      Text("${ widget.resumeProfile.sumamryDetails.introduction}",
                          style: dbodyStyle),
                      SizedBox(height: 5),
                      if ( widget.resumeProfile.workDetails.isNotEmpty) ...[
                        SizedBox(height: 10),
                        Text("MY EXPERIENCE", style: dheadStyle),
                        SizedBox(height: 5),
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              for (int i = 0;
                                  i <  widget.resumeProfile.workDetails.length;
                                  i++)
                                Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                          widget.resumeProfile
                                              .workDetails[i].title,
                                          style: dmedStyle),
                                      Text(
                                          widget.resumeProfile.workDetails[i].time,
                                          style: dbodyStyle),
                                      Text(
                                          widget.resumeProfile
                                              .workDetails[i].place,
                                          style: dbodyStyle),
                                      SizedBox(height: 5),
                                      for (int j = 0;
                                          j <
                                              widget.resumeProfile.workDetails[i]
                                                  .experience.length;
                                          j++)
                                        Text(
                                            "- " +
                                                widget.resumeProfile.workDetails[i]
                                                    .experience[j],
                                            style: dbodyStyle),
                                      SizedBox(height: 10)
                                    ]),
                              SizedBox(height: 10),
                            ])
                      ],
                    ]))),
      ]),
    );
  }
}
