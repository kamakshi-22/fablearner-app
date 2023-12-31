import 'package:fablearner_app/models/courses_model.dart';
import 'package:fablearner_app/services/auth_api.dart';
import 'package:fablearner_app/services/course_api.dart';
import 'package:fablearner_app/utils/utils.dart';
import 'package:flutter/material.dart';

class CoursesProvider with ChangeNotifier {
  List<CourseModel> _coursesModel = [];
  List<CourseModel> get coursesModel => _coursesModel;

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  final CourseApi courseApi = CourseApi();
  final AuthApi authApi = AuthApi();

  Future<void> fetchCourseModel(String authToken) async {
    try {
      final isAuthValid = await authApi.validateAuthToken(authToken);
      if (isAuthValid) {
        _coursesModel = await courseApi.fetchCoursesData(authToken);
        printIfDebug(
            "Courses Fetched : ${_coursesModel.length} ${_coursesModel[0].name}");
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> updateCourseModel(String authToken) async {
    try {
      _isLoading = true;
      notifyListeners();
      _coursesModel = await courseApi.fetchCoursesData(authToken);
      printIfDebug(
          "Courses Fetched : ${_coursesModel.length} ${_coursesModel[0].name}");
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      throw Exception(e);
    }
  }
}
