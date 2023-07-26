import 'package:fablearner_app/models/courses_model.dart';
import 'package:fablearner_app/services/course_api.dart';
import 'package:flutter/material.dart';

class CoursesProvider with ChangeNotifier{
  List<CourseModel> _coursesModel= [];
  List<CourseModel> get coursesModel => _coursesModel;

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  final CourseApi courseApi = CourseApi();
  
  Future<void> fetchCourseModel(String authToken) async {
    try {
      _isLoading=true;
      notifyListeners();
      _coursesModel = await courseApi.fetchCoursesData(authToken);
       _isLoading=false;
      notifyListeners();
    } catch (e) {
      _isLoading=false;
      notifyListeners();
      throw Exception(e);
    }
  }
}