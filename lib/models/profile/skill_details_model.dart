// To parse this JSON data, do
//
//     final skillDetails = skillDetailsFromJson(jsonString);

import 'dart:convert';

SkillDetails skillDetailsFromJson(String str) =>
    SkillDetails.fromJson(json.decode(str));

String skillDetailsToJson(SkillDetails data) => json.encode(data.toJson());

class SkillDetails {
  SkillDetails({
    this.title = '',
    this.shortDescription = '',
  });

  String title;
  String shortDescription;

  factory SkillDetails.fromJson(Map<String, dynamic> json) => SkillDetails(
        title: json["title"] == null ? null : json["title"],
        shortDescription: json["short_description"] == null
            ? null
            : json["short_description"],
      );

  Map<String, dynamic> toJson() => {
        "title": title == null ? null : title,
        "short_description": shortDescription == null ? null : shortDescription,
      };
}
