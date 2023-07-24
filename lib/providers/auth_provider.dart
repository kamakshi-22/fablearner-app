import 'package:fablearner_app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AuthProvider with ChangeNotifier {
  String? _authToken;
  String? get authToken => _authToken;

  String _username = '';
  String get username => _username;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> fetchAuthToken() async {
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
        final data = json.decode(response.body);
        _authToken = data['token'];
        _username = data['user_display_name'];
        printIfDebug(_authToken);
        notifyListeners();
      } else {
        // Handle error response
        printIfDebug("Error: ${response.statusCode} - ${response.body}");
      }
    } catch (e) {
      // Handle exceptions
      printIfDebug(e);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
