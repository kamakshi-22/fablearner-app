
import 'package:fablearner_app/models/finish_lesson_model.dart';
import 'package:fablearner_app/services/markfinish_api.dart';
import 'package:flutter/material.dart';

class FinishLessonProvider with ChangeNotifier{
  late FinishLessonModel _finishlessonModel;
  FinishLessonModel get finishlessonModel => _finishlessonModel;

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  final MarkFinishApi markFinishApi = MarkFinishApi();
  
  Future<void> markLessonFinished(int lessonId, String authToken) async {
     try {
      _isLoading=true;
      notifyListeners();
      _finishlessonModel = await markFinishApi.finishLesson(lessonId, authToken);
       _isLoading=false;
      notifyListeners();
    } catch (e) {
      _isLoading=false;
      notifyListeners();
      throw Exception(e);
    }
  }
}