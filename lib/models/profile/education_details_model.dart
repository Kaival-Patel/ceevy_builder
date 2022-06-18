// To parse this JSON data, do
//
//     final educationDetails = educationDetailsFromJson(jsonString);

import 'dart:convert';

EducationDetails educationDetailsFromJson(String str) =>
    EducationDetails.fromJson(json.decode(str));

String educationDetailsToJson(EducationDetails data) =>
    json.encode(data.toJson());

class EducationDetails {
  EducationDetails({
    this.time = '',
    this.title = '',
    this.place = '',
    this.sortedPos = 0,
  });

  String time;
  String title;
  String place;
  int sortedPos;
  factory EducationDetails.fromJson(Map<String, dynamic> json) =>
      EducationDetails(
        time: json["time"] == null ? '' : json["time"],
        title: json["title"] == null ? '' : json["title"],
        place: json["place"] == null ? '' : json["place"],
        sortedPos: json["sortedPos"] == null ? 0 : json["sortedPos"],
      );

  Map<String, dynamic> toJson() => {
        "time": time == null ? null : time,
        "title": title == null ? null : title,
        "place": place == null ? null : place,
        "sortedPos": sortedPos == null ? null : sortedPos,
      };
}
