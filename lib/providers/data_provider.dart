import 'dart:async';
import 'package:fablearner_app/models/courses_model.dart';
import 'package:fablearner_app/models/finish_lesson_model.dart';
import 'package:fablearner_app/models/lesson_model.dart';
import 'package:fablearner_app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DataProvider with ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<List<CourseModel>> fetchCoursesData(String authToken) async {
    try {
      final response = await http.get(
        Uri.parse(coursesEnrolledUrl),
        headers: {'Authorization': 'Bearer $authToken'},
      );
      if (response.statusCode == 200) {
        final jsonString = response.body;
        final coursesModel = courseModelFromJson(jsonString);
        return coursesModel;
      } else {
        throw Exception('Request failed with status: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

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

  Future<FinishLessonModel> finishLesson(
      String lessonId, String authToken) async {
    try {
      _isLoading = true;
      notifyListeners();
      final response = await http.post(
        Uri.parse(lessonFinishedUrl + lessonId),
        headers: {'Authorization': 'Bearer $authToken'},
      );
      if (response.statusCode == 200) {
        final jsonString = response.body;
        final finishLessonModel = finishLessonModelFromJson(jsonString);
        notifyListeners();
        return finishLessonModel;
      } else {
        throw Exception(
            'Request failed with status: ${response.statusCode}${response.body}');
      }
    } catch (e) {
      rethrow;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
