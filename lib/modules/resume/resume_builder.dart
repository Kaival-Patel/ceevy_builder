import 'package:flutter/material.dart';
import 'package:resume_builder/models/resume/resume_model.dart';

class ResumeBuilder extends StatelessWidget {
  ResumeModel resumeModel;
  ResumeBuilder({required this.resumeModel, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(resumeModel.title),
        ),
        body: resumeModel.resumeWidget ?? Container());
  }
}
