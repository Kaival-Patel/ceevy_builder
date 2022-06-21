// To parse this JSON data, do
//
//     final workHistoryDetails = workHistoryDetailsFromJson(jsonString);

import 'dart:convert';

WorkHistoryDetails workHistoryDetailsFromJson(String str) =>
    WorkHistoryDetails.fromJson(json.decode(str));

String workHistoryDetailsToJson(WorkHistoryDetails data) =>
    json.encode(data.toJson());

class WorkHistoryDetails {
  WorkHistoryDetails({
    this.time = '',
    this.title = '',
    this.place = '',
    this.sortedPos = 0,
    this.experience = const [],
  });

  String time;
  String title;
  String place;
  List<dynamic> experience;
  int sortedPos;

  factory WorkHistoryDetails.fromJson(Map<String, dynamic> json) =>
      WorkHistoryDetails(
        time: json["time"] == null ? WorkHistoryDetails().time : json["time"],
        sortedPos: json["sortedPos"] == null
            ? WorkHistoryDetails().sortedPos
            : json["sortedPos"],
        title:
            json["title"] == null ? WorkHistoryDetails().title : json["title"],
        place:
            json["place"] == null ? WorkHistoryDetails().place : json["place"],
        experience: json["experience"] == null
            ? []
            : List<dynamic>.from(json["experience"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "time": time == null ? null : time,
        "title": title == null ? null : title,
        "place": place == null ? null : place,
        "sortedPos": sortedPos,
        "experience": experience == null
            ? null
            : List<dynamic>.from(experience.map((x) => x)),
      };
}
