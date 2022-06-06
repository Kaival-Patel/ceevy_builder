// To parse this JSON data, do
//
//     final category = categoryFromJson(jsonString);

import 'dart:convert';

import 'package:resume_builder/models/resume/base_resume_class.dart';
import 'package:resume_builder/models/resume/resume_model.dart';
import 'package:uuid/uuid.dart';

CVCategory categoryFromJson(String str) =>
    CVCategory.fromJson(json.decode(str));

String categoryToJson(CVCategory data) => json.encode(data.toJson());

class CVCategory {
  CVCategory(
      {this.name = "",
      this.id = '',
      this.asset = "",
      this.status = 0,
      this.resumeList = const []}) {
    if (this.id.isEmpty) {
      this.id = Uuid().v4();
    }
  }

  bool get isValid => status == 1;

  String name;
  String asset;
  int status;
  List<Resume> resumeList;
  String id;

  factory CVCategory.fromJson(Map<String, dynamic> json) => CVCategory(
        name: json["name"] == null ? '' : json["name"],
        asset: json["asset"] == null ? '' : json["asset"],
        status: json["status"] == null ? 0 : json["status"],
      );

  Map<String, dynamic> toJson() => {
        "name": name == null ? null : name,
        "asset": asset == null ? null : asset,
        "status": status == null ? null : status,
      };
}
