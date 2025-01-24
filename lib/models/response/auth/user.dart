// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
    final String id;
    final String username;
    final String email;
    final bool isAdmin;
    final bool isAgent;
    final bool user;
    final List<String> skills;
    final String profile;
    final DateTime updatedAt;
    final String location;
    final String phone;

    UserModel({
        required this.id,
        required this.username,
        required this.email,
        required this.isAdmin,
        required this.isAgent,
        required this.user,
        required this.skills,
        required this.profile,
        required this.updatedAt,
        required this.location,
        required this.phone,
    });

    factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["_id"]?? '',
        username: json["username"]?? '',
        email: json["email"]?? '',
        isAdmin: json["isAdmin"]?? '',
        isAgent: json["isAgent"]?? '',
        user: json["user"]?? '',
        skills: List<String>.from(json["skills"].map((x) => x)?? ''),
        profile: json["profile"]?? '',
        updatedAt: DateTime.parse(json["updatedAt"]?? ''),
        location: json["location"]?? '',
        phone: json["phone"]?? '',
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "username": username,
        "email": email,
        "isAdmin": isAdmin,
        "isAgent": isAgent,
        "user": user,
        "skills": List<dynamic>.from(skills.map((x) => x)),
        "profile": profile,
        "updatedAt": updatedAt.toIso8601String(),
        "location": location,
        "phone": phone,
    };
}
