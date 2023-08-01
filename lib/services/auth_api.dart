import 'package:fablearner_app/models/user_model.dart';
import 'package:fablearner_app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
class AuthApi{

  /* Authentication */
  Future<UserModel> fetchAuthToken(String username, String password) async {
    try {
      final response = await http.post(
        Uri.parse(appLoginUrl),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'username': username,
          'password':  password,
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
    }
  }

}