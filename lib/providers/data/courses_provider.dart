import 'package:fablearner_app/models/courses_model.dart';
import 'package:flutter/material.dart';

class CoursesProvider with ChangeNotifier{
  List<CourseModel> _coursesModel= [];
  List<CourseModel> get coursesModel => _coursesModel;
  
  void updateCoursesModel(List<CourseModel> newCourses){
    _coursesModel = newCourses;
    notifyListeners();
  }
}