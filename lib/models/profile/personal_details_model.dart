// To parse this JSON data, do
//
//     final personalDetails = personalDetailsFromJson(jsonString);

import 'dart:convert';

PersonalDetails personalDetailsFromJson(String str) =>
    PersonalDetails.fromJson(json.decode(str));

String personalDetailsToJson(PersonalDetails data) =>
    json.encode(data.toJson());

class PersonalDetails {
  const PersonalDetails({
    this.name = 'John Doe',
    this.picture = '',
    this.contact = '+1 125 632 1455',
    this.email = 'johndoe@gmail.com',
    this.address = '',
    this.positionTitle = '',
  });

  final String name;
  final String picture;
  final String contact;
  final String email;
  final String address;
  final String positionTitle;

  factory PersonalDetails.fromJson(Map<String, dynamic> json) =>
      PersonalDetails(
        name: json["name"] == null ? PersonalDetails().name : json["name"],
        picture: json["picture"] == null
            ? PersonalDetails().picture
            : json["picture"],
        contact: json["contact"] == null
            ? PersonalDetails().contact
            : json["contact"],
        email: json["email"] == null ? PersonalDetails().email : json["email"],
        address: json["address"] == null
            ? PersonalDetails().address
            : json["address"],
        positionTitle: json["positionTitle"] == null
            ? PersonalDetails().positionTitle
            : json["positionTitle"],
      );

  Map<String, dynamic> toJson() => {
        "name": name == null ? null : name,
        "picture": picture == null ? null : picture,
        "contact": contact == null ? null : contact,
        "email": email == null ? null : email,
        "address": address == null ? null : address,
        "positionTitle": positionTitle == null ? null : positionTitle,
      };
}
