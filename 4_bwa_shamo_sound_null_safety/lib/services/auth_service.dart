import 'dart:convert';

// import 'package:shamo/model/auth_token.dart';
import 'package:shamo/model/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class AuthService {
  String baseUrl = 'https://shamo-backend.buildwithangga.id/api';

  Future<UserModel> register({required String name, required String username, required String email, required String password}) async {
    var url = '$baseUrl/register';
    var headers = {'Content-Type': 'application/json'};
    var body = jsonEncode({
      'name': name,
      'username': username,
      'email': email,
      'password': password,
    });

    print(jsonDecode(body));

    var response = await http.post(
      Uri.parse(url),
      headers: headers,
      body: body,
    );

    print(response.body);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['data'];
      UserModel user = UserModel.fromJson(data['user']);
      user.token = 'Bearer ' + data['access_token'];
      return user;
    } else {
      print("Gagal Register");
      throw Exception("Gagal Register");
    }
  }

  Future<UserModel> login({required String email, required String password}) async {
    var url = '$baseUrl/login';
    var headers = {'Content-Type': 'application/json'};
    var body = jsonEncode({
      'email': email,
      'password': password,
    });

    print(jsonDecode(body));

    var response = await http.post(
      Uri.parse(url),
      headers: headers,
      body: body,
    );

    print(response.body);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['data'];
      UserModel user = UserModel.fromJson(data['user']);
      user.token = 'Bearer ' + data['access_token'];

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', user.token!);
      await prefs.setInt('id', user.id!);
      await prefs.setString('name', user.name!);
      await prefs.setString('email', user.email!);
      await prefs.setString('username', user.username!);
      await prefs.setString('photo', user.profilePhotoUrl!);

      return user;
    } else {
      print("Gagal Login");
      throw Exception("Gagal Login");
    }
  }
}
