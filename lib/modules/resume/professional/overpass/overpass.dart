import 'package:flutter/material.dart';
import 'package:resume_builder/models/profile/resume_profile_model.dart';
import 'package:resume_builder/models/resume/resume_model.dart';
import 'package:get/get.dart';
import 'dart:io';
import 'package:resume_builder/styles/app-assets.dart';

class Overpass extends StatefulWidget {
  ResumeProfile resumeProfile;

  Overpass({required this.resumeProfile, Key? key}) : super(key: key);

  @override
  State<Overpass> createState() => _OverpassState();
}

class _OverpassState extends State<Overpass> {
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

  var subHeadStyle =
  TextStyle(fontSize: 9, fontWeight: FontWeight.bold, letterSpacing: 1.2);
  var subBodyStyle = TextStyle(fontSize: 7);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: context.height,
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(
                AppAssets.mirageResumeBg,
              ),
              alignment: Alignment.topCenter,
              fit: BoxFit.fill)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 5,
              ),
              Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                SizedBox(
                  width: 10,
                ),
                ClipOval(
                    child: widget.resumeProfile.isAssetPath
                        ? Image.asset(widget.resumeProfile.pictureAsset,
                        height: 50, width: 50, fit: BoxFit.cover)
                        : Image.file(File(widget.resumeProfile.pictureAsset),
                        height: 50, width: 50, fit: BoxFit.cover)),
                Spacer(),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "${widget.resumeProfile.personalDetails.name.toUpperCase()}",
                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    Center(
                      child: Text(
                        "${widget.resumeProfile.personalDetails.positionTitle.toUpperCase()}",
                        style: TextStyle(fontSize: 8, letterSpacing: 1.2),
                      ),
                    )
                  ],
                ),
                Spacer(),
              ]),
              SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  SizedBox(
                    width: 5,
                  ),
                  Expanded(
                    flex: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('CONTACT', style: subHeadStyle),
                        SizedBox(
                          height: 7,
                        ),
                        Text(
                          widget.resumeProfile.personalDetails.contact,
                          style: subBodyStyle,
                        ),
                        Text(widget.resumeProfile.personalDetails.email,
                            style: subBodyStyle),
                        Text(widget.resumeProfile.personalDetails.address,
                            style: subBodyStyle),
                        SizedBox(
                          height: 12,
                        ),
                        Text('EDUCATION', style: subHeadStyle),
                        SizedBox(
                          height: 7,
                        ),
                        for (int i = 0;
                        i < widget.resumeProfile.education.length;
                        i++)
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.resumeProfile.education[i].title,
                                style: subBodyStyle,
                              ),
                              Text(widget.resumeProfile.education[i].place,
                                  style: subBodyStyle),
                              Text(widget.resumeProfile.education[i].time,
                                  style: subBodyStyle),
                              SizedBox(
                                height: 5,
                              ),
                            ],
                          ),
                        SizedBox(
                          height: 12,
                        ),
                        Text('SKILLS', style: subHeadStyle),
                        SizedBox(
                          height: 7,
                        ),
                        for (int j = 0;
                        j < widget.resumeProfile.skillDetails.length;
                        j++)
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "• " + widget.resumeProfile.skillDetails[j].title,
                                style: subBodyStyle,
                              ),
                              SizedBox(
                                height: 5,
                              ),
                            ],
                          ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 30,
                  ),
                  Expanded(
                    flex: 3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('PROFILE', style: subHeadStyle),
                        SizedBox(
                          height: 7,
                        ),
                        Text(
                          widget.resumeProfile.sumamryDetails.introduction,
                          style: subBodyStyle,
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        Text('PROFESSIONAL EXPERIENCE', style: subHeadStyle),
                        SizedBox(
                          height: 7,
                        ),
                        for (int i = 0;
                        i < widget.resumeProfile.workDetails.length;
                        i++)
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.resumeProfile.workDetails[i].title,
                                style: subBodyStyle,
                              ),
                              Text(
                                  widget.resumeProfile.workDetails[i].place +
                                      " | " +
                                      widget.resumeProfile.workDetails[i].time,
                                  style: subBodyStyle),
                              SizedBox(height: 5,),
                              for(int k=0;k<widget.resumeProfile.workDetails[i].experience.length;k++)
                                Text("• " +widget.resumeProfile.workDetails[i].experience[k],
                                    style: subBodyStyle),
                              SizedBox(
                                height: 5,
                              ),
                            ],
                          ),
                        SizedBox(
                          height: 12,
                        ),
                      ],
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
