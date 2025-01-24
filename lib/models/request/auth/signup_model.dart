import 'dart:convert';

SignupModel signupModelFromJson(String str) =>
    SignupModel.fromJson(json.decode(str));

String signupModelToJson(SignupModel data) => json.encode(data.toJson());

class SignupModel {
  SignupModel({
    required this.username,
    required this.email,
    required this.password,
    required this.isAdmin,
    required this.isAgent,
    required this.user,
    //  required this.isFreelancer,
  });

  factory SignupModel.fromJson(Map<String, dynamic> json) => SignupModel(
        username: json['username'],
        email: json['email'],
        password: json['password'],
        isAdmin: json['isAdmin'],
        isAgent: json['isAgent'],
        user: json['user'],
        //    isFreelancer: json['isFreelancer'],
      );

  final String username;
  final String email;
  final String password;
  final bool isAdmin;
  final bool isAgent;
  final bool user;
  //final bool isFreelancer;
  Map<String, dynamic> toJson() => {
        'username': username,
        'email': email,
        'password': password,
        'isAdmin': isAdmin,
        'isAgent': isAgent,
        'user':user,
        // 'isFreelancer':isFreelancer
      };
}
