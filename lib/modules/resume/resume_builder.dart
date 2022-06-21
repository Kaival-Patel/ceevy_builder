import 'package:flutter/material.dart' as m;
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:path_provider/path_provider.dart';
import 'package:resume_builder/models/profile/resume_profile_model.dart';
import 'package:resume_builder/models/resume/base_resume_class.dart';
import 'package:resume_builder/models/resume/resume_model.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:resume_builder/modules/profile/resume_profile_controller.dart';
import 'dart:io';
import 'package:resume_builder/modules/resume/simple/aztec/aztec.dart';
import 'package:resume_builder/modules/resume/simple/aztec/aztec_pdf.dart';
import 'package:resume_builder/styles/app-colors.dart';

class ResumeBuilder extends m.StatelessWidget {
  Resume resumeModel;
  ResumeBuilder({required this.resumeModel, m.Key? key}) : super(key: key);
  var c = Get.put(ResumeProfilesController());
  @override
  m.Widget build(m.BuildContext context) {
    return m.Scaffold(
        appBar: m.AppBar(
          title: m.Text(resumeModel.resumeTitle),
          actions: [
            m.IconButton(
                onPressed: () {
                  downloadResume();
                },
                icon: m.Icon(m.Icons.download))
          ],
        ),
        body: resumeModel.bodyWidget);
  }

  downloadResume() async {
    final pdf = Document(title: '${resumeModel.resumeTitle}');
    pdf.addPage(AztecPdf.getPage(resumeProfile: ResumeProfile()));
    final file = File("/storage/emulated/0/example.pdf");
    await file.writeAsBytes(await pdf.save());
    Logger().d(file.path);
  }
}
