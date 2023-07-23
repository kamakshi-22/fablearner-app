// To parse this JSON data, do
//
//     final finishLessonModel = finishLessonModelFromJson(jsonString);

import 'dart:convert';

FinishLessonModel finishLessonModelFromJson(String str) =>
    FinishLessonModel.fromJson(json.decode(str));

String finishLessonModelToJson(FinishLessonModel data) =>
    json.encode(data.toJson());

class FinishLessonModel {
  String status;
  String message;
  Data data;

  FinishLessonModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory FinishLessonModel.fromJson(Map<String, dynamic> json) =>
      FinishLessonModel(
        status: json["status"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data.toJson(),
      };
}

class Data {
  Data();

  factory Data.fromJson(Map<String, dynamic> json) => Data();

  Map<String, dynamic> toJson() => {};
}
