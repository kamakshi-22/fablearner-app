
import 'package:fablearner_app/models/lesson_model.dart';
import 'package:flutter/material.dart';

class LessonProvider with ChangeNotifier{
  late LessonModel _lessonModel;
  LessonModel get lessonModel => _lessonModel;
  
  void updateLessonModel(LessonModel newLesson){
    _lessonModel = newLesson;
    notifyListeners();
  }
}