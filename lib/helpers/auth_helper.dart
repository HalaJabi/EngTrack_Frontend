import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:front/helpers/UserManger.dart';
import 'package:front/helpers/config.dart';
import 'package:front/models/chatm.dart';
import 'package:front/models/profile_model.dart';
import 'package:front/models/profile_update_model.dart';
import 'package:front/models/request/auth/signup_model.dart';
import 'package:front/models/response/auth/user.dart';

import 'package:http/http.dart' as http;

import 'package:front/models/request/auth/login_model.dart';
import 'package:front/models/response/auth/login_res_model.dart';

import 'package:shared_preferences/shared_preferences.dart';

class AuthHelper {
  
  static var client = http.Client();

  static Future<bool> login(LoginModel model) async {
    Map<String, String> requestHeaders = {'Content-Type': 'application/json'};

    var url = Uri.http(Config.apiUrl, Config.loginUrl);
    var response = await client.post(
      url,
      headers: requestHeaders,
      body: jsonEncode(model),
    );

    if (response.statusCode == 200) {
      final SharedPreferences prefs = await SharedPreferences.getInstance();

      String token = loginResponseModelFromJson(response.body).userToken;
      String userId = loginResponseModelFromJson(response.body).id;
      String profile = loginResponseModelFromJson(response.body).profile;
      bool isAdmin = loginResponseModelFromJson(response.body).isAdmin;
      bool isAgent = loginResponseModelFromJson(response.body).isAgent;
      bool user = loginResponseModelFromJson(response.body).user;

      String username = loginResponseModelFromJson(response.body).username;

      String email = loginResponseModelFromJson(response.body).email;
      await prefs.setString('token', token);
      await prefs.setString('userId', userId);
       
      await prefs.setString('profile', profile);
      await prefs.setBool('loggedIn', true);
      await prefs.setBool('isAdmin', isAdmin);
      await prefs.setBool('isAgent', isAgent);
      await prefs.setBool('user', user);
      await prefs.setString('username', username);
      await prefs.setString('email', email);
      final time = DateTime.now().millisecondsSinceEpoch.toString();

      UserManager.setUserDetails(id: userId);

      ChatUser model = ChatUser(
          id: userId,
          name: username,
          email: email,
          image: profile,
          createdAt: time,
          isOnline: false,
          lastActive: time,
          pushToken: '');

      UserManager.setchat(models: model);

/*
 if (await userExists(model) == false) {
        createUser(model);

      }

*/

      return true;
    } else {
      return false;
    }
  }

  static Future<bool> updateProfile(ProfileUpdateReq model) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'token': 'Bearer $token'
    };
    print(token);

    var url = Uri.http(Config.apiUrl, Config.profileUrl);
    var response = await client.put(
      url,
      headers: requestHeaders,
      body: jsonEncode(model),
    );

    print(response.statusCode);

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  static Future<bool> signup(SignupModel model) async {
    Map<String, String> requestHeaders = {'Content-Type': 'application/json'};
    var url = Uri.http(Config.apiUrl, Config.signupUrl);
    var response = await client.post(
      url,
      headers: requestHeaders,
      body: jsonEncode(model),
    );

print(response.statusCode  );

    if (response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }




  static Future<ProfileRes> getProfile() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'token': 'Bearer $token'
    };

    var url = Uri.http(Config.apiUrl, Config.profileUrl);
    var response = await client.get(
      url,
      headers: requestHeaders,
    );

    if (response.statusCode == 200) {
      final profile = profileResFromJson(response.body);
      return profile;
    } else {
      throw Exception('Failed to get the profile');
    }
  }

  

/*

  static Future<void> createUser(ChatUser model) async {
    return await Config.firestore
        .collection('users')
        .doc(model.id)
        .set(model.toJson());
  }

  static Future<bool> userExists(ChatUser model) async {
    return (await Config.firestore.collection('users').doc(model.id).get())
        .exists;
  }

*/

//
  static Future<void> updateUserInfo(ChatUser model) async {
    await Config.firestore.collection('users').doc(model.id).update({
      'image': model.image,
    });
  }

static Future<UserModel?> getUserById(String userId) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };

    var url = Uri.http(Config.apiUrl, '/api/users/$userId');
    var response = await http.get(
      url,
      headers: requestHeaders,
    );

    print(response.statusCode);

    if (response.statusCode == 200) {
      print("User fetched successfully");

      final Map<String, dynamic> responseData = jsonDecode(response.body);
      final UserModel userData = UserModel.fromJson(responseData['data']); // Assuming the user data is under a 'data' key

      return userData;
    } else {
      print('Failed to get the user. Status code: ${response.statusCode}');
      return null;
    }
  }








static Future<bool> isAdmin(String userId) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };

    var url = Uri.http(Config.apiUrl, '/api/users/$userId/role');
    var response = await client.get(
      url,
      headers: requestHeaders,
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> responseData = jsonDecode(response.body);
      String role = responseData['role'];
      if (role.toLowerCase() == 'admin')
      {
   return  true;
      }
      else
         return  false;
   
    }
     else {
      throw Exception('Failed to fetch user role');
    }
  }








}

























