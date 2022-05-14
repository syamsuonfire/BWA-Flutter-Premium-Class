import 'package:flutter/material.dart';
import 'package:shamo/model/user_model.dart';
import 'package:shamo/services/auth_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider with ChangeNotifier {
  UserModel? _user;

  UserModel? get user => _user;

  set user(UserModel? user) {
    _user = user;
    notifyListeners();
  }

  getPref() async {
    final prefs = await SharedPreferences.getInstance();

    _user = UserModel(
      id: prefs.getInt('id'),
      name: prefs.getString('name'),
      email: prefs.getString('email'),
      username: prefs.getString('username'),
      profilePhotoUrl: prefs.getString('photo'),
    );
  }

  Future<bool> register({required String name, required String username, required String email, required String password}) async {
    try {
      UserModel user = await AuthService().register(name: name, username: username, email: email, password: password);

      _user = user;
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> login({required String email, required String password}) async {
    try {
      UserModel user = await AuthService().login(email: email, password: password);

      _user = user;
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
