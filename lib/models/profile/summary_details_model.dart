// To parse this JSON data, do
//
//     final summaryDetails = summaryDetailsFromJson(jsonString);

import 'dart:convert';

SummaryDetails summaryDetailsFromJson(String str) =>
    SummaryDetails.fromJson(json.decode(str));

String summaryDetailsToJson(SummaryDetails data) => json.encode(data.toJson());

class SummaryDetails {
  const SummaryDetails({
    this.introduction = "",
  });

  final String introduction;

  factory SummaryDetails.fromJson(Map<String, dynamic> json) => SummaryDetails(
        introduction: json["introduction"] == null ? "" : json["introduction"],
      );

  Map<String, dynamic> toJson() => {
        "introduction": introduction == null ? null : introduction,
      };
}
