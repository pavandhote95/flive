// To parse this JSON data, do
//
//     final getLoginModel = getLoginModelFromJson(jsonString);

import 'dart:convert';

GetLoginModel getLoginModelFromJson(String str) => GetLoginModel.fromJson(json.decode(str));

String getLoginModelToJson(GetLoginModel data) => json.encode(data.toJson());

class GetLoginModel {
  bool error;
  String message;
  List<LoginData> data;

  GetLoginModel({
    required this.error,
    required this.message,
    required this.data,
  });

  factory GetLoginModel.fromJson(Map<String, dynamic> json) => GetLoginModel(
    error: json["error"],
    message: json["message"],
    data: List<LoginData>.from(json["data"].map((x) => LoginData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "error": error,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class LoginData {
  int id;
  String name;
  dynamic mobile;
  String email;
  String profileImage;
  String address;
  String pinCode;
  dynamic emailVerifiedAt;
  dynamic twoFactorConfirmedAt;
  dynamic currentTeamId;
  dynamic profilePhotoPath;
  DateTime createdAt;
  DateTime updatedAt;
  String profilePhotoUrl;

  LoginData({
    required this.id,
    required this.name,
    required this.mobile,
    required this.email,
    required this.profileImage,
    required this.address,
    required this.pinCode,
    required this.emailVerifiedAt,
    required this.twoFactorConfirmedAt,
    required this.currentTeamId,
    required this.profilePhotoPath,
    required this.createdAt,
    required this.updatedAt,
    required this.profilePhotoUrl,
  });

  factory LoginData.fromJson(Map<String, dynamic> json) => LoginData(
    id: json["id"],
    name: json["name"],
    mobile: json["mobile"],
    email: json["email"],
    profileImage: json["profile_image"],
    address: json["address"],
    pinCode: json["pin_code"],
    emailVerifiedAt: json["email_verified_at"],
    twoFactorConfirmedAt: json["two_factor_confirmed_at"],
    currentTeamId: json["current_team_id"],
    profilePhotoPath: json["profile_photo_path"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    profilePhotoUrl: json["profile_photo_url"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "mobile": mobile,
    "email": email,
    "profile_image": profileImage,
    "address": address,
    "pin_code": pinCode,
    "email_verified_at": emailVerifiedAt,
    "two_factor_confirmed_at": twoFactorConfirmedAt,
    "current_team_id": currentTeamId,
    "profile_photo_path": profilePhotoPath,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "profile_photo_url": profilePhotoUrl,
  };
}
