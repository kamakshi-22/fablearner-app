import 'package:fablearner_app/models/user_model.dart';
import 'package:fablearner_app/services/auth_api.dart';
import 'package:flutter/material.dart';

class UserProvider with ChangeNotifier {
  late UserModel _user;
  UserModel get user => _user;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  final AuthApi apiService = AuthApi();

  Future<void> fetchUser(String username, String password) async{
    try {
      _isLoading=true;
      notifyListeners();
      _user = await apiService.fetchAuthToken(
 username, password
      );
       _isLoading=false;
      notifyListeners();
    } catch (e) {
      _isLoading=false;
      notifyListeners();
      throw Exception(e);
    }
  }
}
