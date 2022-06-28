import 'package:flutter/material.dart' as m;
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:printing/printing.dart';
import 'package:resume_builder/models/profile/resume_profile_model.dart';
import 'package:resume_builder/models/resume/base_resume_class.dart';
import 'package:resume_builder/models/resume/resume_model.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:resume_builder/modules/profile/resume_profile_controller.dart';
import 'package:resume_builder/modules/resume/resume_builder_controller.dart';
import 'dart:io';
import 'package:resume_builder/modules/resume/simple/aztec/aztec.dart';
import 'package:resume_builder/modules/resume/simple/aztec/aztec_pdf.dart';
import 'package:resume_builder/styles/app-colors.dart';
import 'package:resume_builder/utils/widgets/snackbar.dart';

class ResumeBuilder extends m.StatelessWidget {
  Resume resumeModel;
  ResumeBuilder({required this.resumeModel, m.Key? key}) : super(key: key);
  var c = Get.put(ResumeBuilderController());
  @override
  m.Widget build(m.BuildContext context) {
    return m.Scaffold(
        appBar: m.AppBar(
          title: m.Text(resumeModel.resumeTitle),
          actions: [
            Obx(() {
              if (c.selectedProfile().isValid) {
                return m.IconButton(
                    tooltip: 'Switch Resume Profiles',
                    onPressed: () {},
                    icon: m.ClipOval(
                        child: c.selectedProfile().isAssetPath
                            ? m.Image.asset(c.selectedProfile().pictureAsset)
                            : m.Image.file(
                                File(c.selectedProfile().pictureAsset))));
              }
              return m.Container();
            }),
          ],
        ),
        body: m.Column(children: [
          m.Expanded(
              child: m.SingleChildScrollView(
            child: Obx(() => resumeModel.bodyWidget(c.selectedProfile())),
          )),
          m.SizedBox(
            height: 5,
          ),
          m.Padding(
            padding: m.EdgeInsets.symmetric(horizontal: 10),
            child: m.ElevatedButton(
                onPressed: () {
                  downloadResume();
                },
                child: m.Text("Download Resume")),
          ),
          m.SizedBox(
            height: 5,
          )
        ]));
  }

  downloadResume() async {
    var permit = Permission.storage;
    var req = await permit.request();
    switch (req) {
      case PermissionStatus.denied:
        snack(msg: 'Storage access denied', type: SnackType.Error);
        await 2.delay();
        await openAppSettings();
        break;
      case PermissionStatus.granted:
        _saveResume();
        break;
      case PermissionStatus.restricted:
        snack(msg: 'Storage access restricted', type: SnackType.Error);
        await 2.delay();
        await openAppSettings();
        break;
      case PermissionStatus.limited:
        snack(msg: 'Storage access limited', type: SnackType.Error);
        await 2.delay();
        await openAppSettings();
        break;
      case PermissionStatus.permanentlyDenied:
        snack(msg: 'Storage access denied', type: SnackType.Error);
        await 2.delay();
        await openAppSettings();
        break;
    }
  }

  _saveResume() async {
    final ttf = await fontFromAssetBundle('assets/fonts/Gilroy-Regular.ttf');
    final pdf = Document(title: '${resumeModel.resumeTitle}');
    pdf.addPage(resumeModel.pdfDocument(c.selectedProfile(), font: ttf));
    final file = File("/storage/emulated/0/example.pdf");
    await file.writeAsBytes(await pdf.save());
    snackWithButton(
        msg: 'Resume Downloaded',
        type: SnackType.Success,
        textButton: m.TextButton(
            onPressed: () async {
              await OpenFile.open(file.path);
            },
            child: m.Text(
              "Open",
              style: m.TextStyle(color: m.Colors.white),
            )));
    Logger().d(file.path);
  }
}
