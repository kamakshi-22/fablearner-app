import 'dart:async';
import 'package:fablearner_app/models/finish_lesson_model.dart';
import 'package:fablearner_app/utils/utils.dart';
import 'package:http/http.dart' as http;

class MarkFinishApi{
  Future<FinishLessonModel> finishLesson(
      int lessonId, String authToken) async {
    try {
      final response = await http.post(
        Uri.parse(lessonFinishedUrl + lessonId.toString()),
        headers: {'Authorization': 'Bearer $authToken'},
      );
      if (response.statusCode == 200) {
        final jsonString = response.body;
        final finishLessonModel = finishLessonModelFromJson(jsonString);
        return finishLessonModel;
      } else {
        throw Exception(
            'Request failed with status: ${response.statusCode}${response.body}');
      }
    } catch (e) {
      rethrow;
    }
  }
}