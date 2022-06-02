// To parse this JSON data, do
//
//     final category = categoryFromJson(jsonString);

import 'dart:convert';

CVCategory categoryFromJson(String str) =>
    CVCategory.fromJson(json.decode(str));

String categoryToJson(CVCategory data) => json.encode(data.toJson());

class CVCategory {
  CVCategory({
    this.name = "",
    this.asset = "",
    this.status = 0,
  });

  bool get isValid => status == 1;

  String name;
  String asset;
  int status;

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
