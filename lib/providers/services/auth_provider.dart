import 'package:fablearner_app/models/user_model.dart';
import 'package:fablearner_app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AuthProvider with ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<UserModel> fetchAuthToken() async {
    try {
      _isLoading = true;
      notifyListeners();
      final response = await http.post(
        Uri.parse(appLoginUrl),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'username': appTestUsername1,
          'password': appTestUserpassword1,
        }),
      );
      if (response.statusCode == 200) {
        final jsonString = response.body;
        final userModel = userModelFromJson(jsonString);
        printIfDebug("AUTH_PROVIDER : ${userModel.userDisplayName}");
        return userModel;
      } else {
        throw Exception("Error: ${response.statusCode} - ${response.body}");
      }
    } catch (e) {
      throw Exception(e);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
