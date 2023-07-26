import 'dart:async';
import 'package:fablearner_app/models/lesson_model.dart';
import 'package:fablearner_app/utils/utils.dart';
import 'package:http/http.dart' as http;

class LessonApi{

  Future<LessonModel> fetchLessonData(int lessonId, String authToken) async {
    try {
      final response = await http.get(
        Uri.parse(lessonDetailsUrl + lessonId.toString()),
        headers: {'Authorization': 'Bearer $authToken'},
      );
      if (response.statusCode == 200) {
        final jsonString = response.body;
        final lessonModel = lessonModelFromJson(jsonString);
        printIfDebug(lessonModel.name);
        return lessonModel;
      } else {
        throw Exception(
            'Request failed with status: ${response.statusCode}${response.body}');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}