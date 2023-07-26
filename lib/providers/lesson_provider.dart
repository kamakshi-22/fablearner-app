
import 'package:fablearner_app/models/lesson_model.dart';
import 'package:fablearner_app/services/lesson_api.dart';
import 'package:flutter/material.dart';

class LessonProvider with ChangeNotifier{
  late LessonModel _lessonModel;
  LessonModel get lessonModel => _lessonModel;

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  final LessonApi lessonApi = LessonApi();

  // void updateLessonModel(LessonModel newLessonModel){
  //   _lessonModel = newLessonModel;
  //   notifyListeners();
  // }
  
  Future<void> fetchLessonModel(int lessonId, String authToken) async {
     try {
      _isLoading=true;
      notifyListeners();
      _lessonModel = await lessonApi.fetchLessonData(lessonId, authToken);
       _isLoading=false;
      notifyListeners();
    } catch (e) {
      _isLoading=false;
      notifyListeners();
      throw Exception(e);
    }
  }
}