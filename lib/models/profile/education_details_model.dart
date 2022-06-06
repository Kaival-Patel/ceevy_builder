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
    this.experience = const [],
  });

  String time;
  String title;
  String place;
  List<dynamic> experience;

  factory EducationDetails.fromJson(Map<String, dynamic> json) =>
      EducationDetails(
        time: json["time"] == null ? '' : json["time"],
        title: json["title"] == null ? '' : json["title"],
        place: json["place"] == null ? '' : json["place"],
        experience: json["experience"] == null
            ? []
            : List<dynamic>.from(json["experience"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "time": time == null ? null : time,
        "title": title == null ? null : title,
        "place": place == null ? null : place,
        "experience": experience == null
            ? null
            : List<dynamic>.from(experience.map((x) => x)),
      };
}
