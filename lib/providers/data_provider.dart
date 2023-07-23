import 'package:fablearner_app/models/courses_model.dart';
import 'package:fablearner_app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DataProvider with ChangeNotifier {
  List<CoursesModel> coursesModel = [];

  Future<List<CoursesModel>> fetchAppData(String authToken) async {
    try {
      final response = await http.get(
        Uri.parse(coursesEnrolledUrl),
        headers: {'Authorization': 'Bearer $authToken'},
      );
      if (response.statusCode == 200) {
        final jsonString = response.body;
        coursesModel = coursesModelFromJson(jsonString);
        return coursesModel;
      } else {
        // Handle error response
        throw Exception('Request failed with status: ${response.statusCode}');
      }
    } catch (e) {
      // Handle exceptions
      throw Exception('Error: $e');
    }
  }
}
