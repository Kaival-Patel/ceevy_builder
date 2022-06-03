import 'package:flutter/material.dart';
import 'package:resume_builder/models/category/category_model.dart';
import 'package:resume_builder/models/resume/resume_model.dart';
import 'package:resume_builder/modules/browse/browse.dart';
import 'package:get/get.dart';

class ResumeList extends StatelessWidget {
  CVCategory category;
  ResumeList({required this.category, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(category.name),
      ),
      body: SingleChildScrollView(
          child: Padding(
        padding: EdgeInsets.all(8),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            'Select CV\'s to build your own',
            style: TextStyle(color: context.theme.disabledColor),
          ),
          SizedBox(
            height: 10,
          ),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children:
                category.resumeList.map((e) => ResumeCard(resume: e)).toList(),
          )
        ]),
      )),
    );
  }
}

class ResumeCard extends StatelessWidget {
  ResumeModel resume;
  ResumeCard({required this.resume, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      borderRadius: BorderRadius.circular(10),
      child: Container(
        height: 170,
        width: 120,
        decoration: BoxDecoration(
            color: Colors.grey[200],
            boxShadow: [
              BoxShadow(
                  blurRadius: 7,
                  spreadRadius: 0.5,
                  color: context.theme.disabledColor.withOpacity(0.1))
            ],
            borderRadius: BorderRadius.circular(10)),
        child: Stack(children: [
          Align(
            alignment: Alignment.center,
            child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  resume.thumbnailAsset,
                  height: 140,
                  width: 80,
                  fit: BoxFit.cover,
                )),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 40,
              child: Center(
                  child: Text(
                resume.title,
                style: TextStyle(fontWeight: FontWeight.bold),
              )),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10))),
            ),
          )
        ]),
      ),
    );
  }
}
