import 'package:fablearner_app/models/finish_lesson_model.dart';
import 'package:fablearner_app/models/user_model.dart';
import 'package:flutter/material.dart';

class UserProvider with ChangeNotifier {
  late UserModel _user;
  UserModel get user => _user;

  void fetchUserData(UserModel newUser) {
    _user = newUser;
    notifyListeners();
  }
}
