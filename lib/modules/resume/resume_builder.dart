import 'package:flutter/material.dart' as m;
import 'package:flutter_svg/flutter_svg.dart';
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
import 'package:resume_builder/styles/app-assets.dart';
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
                    onPressed: () {
                      Get.bottomSheet(_profileSwitcher(),
                          isScrollControlled: true);
                    },
                    icon: m.ClipOval(
                        child: c.selectedProfile().isAssetPath
                            ? m.Image.asset(c.selectedProfile().pictureAsset,
                                height: 30, width: 30, fit: m.BoxFit.cover)
                            : m.Image.file(
                                File(
                                  c.selectedProfile().pictureAsset,
                                ),
                                height: 30,
                                width: 30,
                                fit: m.BoxFit.cover,
                              )));
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
    try {
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
    } catch (err) {
      Logger().e(err);
      snack(
        msg: 'Failed to Download Resume',
        type: SnackType.Error,
      );
    }
  }

  _profileSwitcher() {
    return m.Material(
      color: m.Colors.transparent,
      child: m.Container(
        margin: m.EdgeInsets.all(5),
        decoration: m.BoxDecoration(
            borderRadius: m.BorderRadius.circular(15),
            color: Get.theme.scaffoldBackgroundColor),
        child: m.Padding(
          padding: const m.EdgeInsets.symmetric(horizontal: 15.0),
          child: m.Column(
              crossAxisAlignment: m.CrossAxisAlignment.start,
              mainAxisSize: m.MainAxisSize.min,
              children: [
                m.SizedBox(
                  height: 5,
                ),
                m.Center(
                  child: m.ClipRRect(
                    borderRadius: m.BorderRadius.circular(10),
                    child: m.Container(
                        width: 45, height: 4, color: Get.theme.hoverColor),
                  ),
                ),
                m.SizedBox(
                  height: 10,
                ),
                m.Center(
                  child: m.Text(
                    'Select Profile',
                    style: Get.textTheme.headline6,
                  ),
                ),
                m.SizedBox(
                  height: 5,
                ),
                m.Divider(),
                m.ListView.builder(
                  itemBuilder: (context, index) => ProfileCard(
                      profile: c.c.resumeProfileMap.values.elementAt(index)),
                  itemCount: c.c.resumeProfileMap.values.length,
                  shrinkWrap: true,
                )
              ]),
        ),
      ),
    );
  }
}

class ProfileCard extends m.StatelessWidget {
  ResumeProfile profile;
  ProfileCard({required this.profile, m.Key? key}) : super(key: key);
  var c = Get.find<ResumeBuilderController>();
  @override
  m.Widget build(m.BuildContext context) {
    return m.GestureDetector(
      onTap: () async {
        c.selectedProfile(profile);
        await 1.delay();
        if (Get.isBottomSheetOpen ?? false) {
          Get.back();
        }
      },
      child: m.Container(
        margin: m.EdgeInsets.all(10),
        padding: m.EdgeInsets.all(10),
        decoration: m.BoxDecoration(
            color: context.theme.cardColor,
            boxShadow: [
              m.BoxShadow(
                color: m.Colors.grey.withOpacity(0.5),
                spreadRadius: 1,
                blurRadius: 10,
              ),
            ],
            borderRadius: m.BorderRadius.circular(10)),
        child: m.Row(crossAxisAlignment: m.CrossAxisAlignment.start, children: [
          m.Container(
            height: 50,
            width: 50,
            decoration: m.BoxDecoration(
                shape: m.BoxShape.circle,
                border: m.Border.all(
                    color: context.theme.disabledColor, width: 0.5)),
            child: m.ClipOval(
              child: profile.isAssetPath
                  ? m.Image.asset(
                      height: 50,
                      width: 50,
                      profile.pictureAsset,
                      fit: m.BoxFit.cover,
                    )
                  : m.Image.file(
                      File(
                        profile.pictureAsset,
                      ),
                      height: 50,
                      width: 50,
                      fit: m.BoxFit.cover),
            ),
          ),
          m.SizedBox(
            width: 10,
          ),
          m.Expanded(
            child: m.Column(
                crossAxisAlignment: m.CrossAxisAlignment.start,
                mainAxisSize: m.MainAxisSize.min,
                children: [
                  m.Text(
                    profile.label,
                    style: context.textTheme.headline6,
                    maxLines: 1,
                    overflow: m.TextOverflow.ellipsis,
                  ),
                  m.SizedBox(
                    height: 5,
                  ),
                  m.Row(
                    mainAxisSize: m.MainAxisSize.min,
                    children: [
                      SvgPicture.asset(
                        AppAssets.reloadIcon,
                        height: 15,
                        width: 15,
                        color: context.theme.disabledColor,
                      ),
                      m.SizedBox(
                        width: 5,
                      ),
                      m.Text(
                        profile.lastUpdatedAtString,
                        style: m.TextStyle(
                          fontSize: 14,
                          color: context.theme.disabledColor,
                        ),
                      ),
                    ],
                  )
                ]),
          ),
          Obx(
            () {
              return m.Visibility(
                visible: c.selectedProfile().id == profile.id,
                child: m.Icon(
                  m.Icons.verified,
                  color: context.theme.accentColor,
                ),
              );
            },
          )
        ]),
      ),
    );
  }
}
