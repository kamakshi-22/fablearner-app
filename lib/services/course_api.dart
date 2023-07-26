import 'dart:async';
import 'package:fablearner_app/models/courses_model.dart';
import 'package:fablearner_app/utils/utils.dart';
import 'package:http/http.dart' as http;

class CourseApi{

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

}