// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
    String token;
    String userId;
    String userLogin;
    String userEmail;
    String userDisplayName;

    UserModel({
        required this.token,
        required this.userId,
        required this.userLogin,
        required this.userEmail,
        required this.userDisplayName,
    });

    factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        token: json["token"],
        userId: json["user_id"],
        userLogin: json["user_login"],
        userEmail: json["user_email"],
        userDisplayName: json["user_display_name"],
    );

    Map<String, dynamic> toJson() => {
        "token": token,
        "user_id": userId,
        "user_login": userLogin,
        "user_email": userEmail,
        "user_display_name": userDisplayName,
    };
}
