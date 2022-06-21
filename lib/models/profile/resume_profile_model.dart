// To parse this JSON data, do
//
//     final resumeProfile = resumeProfileFromJson(jsonString);

import 'dart:convert';

import 'package:resume_builder/models/profile/education_details_model.dart';
import 'package:resume_builder/models/profile/personal_details_model.dart';
import 'package:resume_builder/models/profile/skill_details_model.dart';
import 'package:resume_builder/models/profile/summary_details_model.dart';
import 'package:resume_builder/models/profile/work_history_details_model.dart';
import 'package:resume_builder/styles/app-assets.dart';

ResumeProfile resumeProfileFromJson(String str) =>
    ResumeProfile.fromJson(json.decode(str));

String resumeProfileToJson(ResumeProfile data) => json.encode(data.toJson());

class ResumeProfile {
  ResumeProfile({
    this.education = const [],
    this.personalDetails = const PersonalDetails(),
    this.skillDetails = const [],
    this.sumamryDetails = const SummaryDetails(),
    this.workDetails = const [],
    this.pictureAsset = AppAssets.profile_1,
    this.label = '',
    this.id = '',
    this.lastUpdatedAt,
  });

  List<EducationDetails> education;
  PersonalDetails personalDetails;
  List<SkillDetails> skillDetails;
  SummaryDetails sumamryDetails;
  List<WorkHistoryDetails> workDetails;
  String pictureAsset;
  String label;
  String id;
  DateTime? lastUpdatedAt;

  bool get isAssetPath => pictureAsset.contains('assets/');

  String get lastUpdatedAtString {
    var difference = DateTime.now().difference(lastUpdatedAt!);
    if (difference.inDays > 30) {
      return '${(difference.inDays / 30).toStringAsFixed(0)} months ago';
    }
    if (difference.inDays > 0) {
      return '${difference.inDays} days ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} hours ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} minutes ago';
    } else {
      return 'Just now';
    }
  }

  factory ResumeProfile.fromJson(Map<String, dynamic> json) => ResumeProfile(
        education: json["education"] == null
            ? []
            : List<EducationDetails>.from(
                (json["education"].map((x) => EducationDetails.fromJson(x)))),
        personalDetails: json["personal_details"] == null
            ? PersonalDetails()
            : PersonalDetails.fromJson(json["personal_details"]),
        skillDetails: json["skill_details"] == null
            ? []
            : List<SkillDetails>.from(
                (json["skill_details"].map((x) => SkillDetails.fromJson(x)))),
        sumamryDetails: json["sumamry_details"] == null
            ? SummaryDetails()
            : SummaryDetails.fromJson(json["sumamry_details"]),
        workDetails: json["work_details"] == null
            ? []
            : List<WorkHistoryDetails>.from(json["work_details"].map((x) => x)),
        pictureAsset:
            json["picture_asset"] == null ? '' : json["picture_asset"],
        label: json["label"] == null ? null : json["label"],
        id: json["id"] == null ? null : json["id"],
        lastUpdatedAt: json["last_updated_at"] == null
            ? DateTime.now()
            : DateTime.parse(json["last_updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "education": education == null
            ? null
            : List<dynamic>.from(education.map((x) => x.toJson())),
        "personal_details":
            personalDetails == null ? null : personalDetails.toJson(),
        "skill_details": skillDetails == null
            ? null
            : List<dynamic>.from(skillDetails.map((x) => x.toJson())),
        "sumamry_details":
            sumamryDetails == null ? null : sumamryDetails.toJson(),
        "work_details": workDetails == null
            ? null
            : List<dynamic>.from(workDetails.map((x) => x.toJson())),
        "picture_asset": pictureAsset == null ? null : pictureAsset,
        "label": label == null ? null : label,
        "id": id,
        "last_updated_at":
            lastUpdatedAt == null ? null : lastUpdatedAt!.toIso8601String(),
      };
}
