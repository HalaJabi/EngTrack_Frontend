// To parse this JSON data, do
//
//     final proResponse = proResponseFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<ProResponse> proResponseFromJson(String str) => List<ProResponse>.from(json.decode(str).map((x) => ProResponse.fromJson(x)));

String proResponseToJson(List<ProResponse> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProResponse {
    final String id;
    final String title;
    final String username;
    final String description;
    final String salary;
    final String userId;
    final String requirements;
    final String imageUrl;
    final String deadline;
    final DateTime createdAt;
    final DateTime updatedAt;

    ProResponse({
        required this.id,
        required this.title,
        required this.username,
        required this.description,
        required this.salary,
        required this.userId,
        required this.requirements,
        required this.imageUrl,
        required this.deadline,
        required this.createdAt,
        required this.updatedAt,
    });

    factory ProResponse.fromJson(Map<String, dynamic> json) => ProResponse(
        id: json["_id"] ?? '',
        title: json["title"] ?? '',
        username: json["username"] ?? '',
        description: json["description"] ?? '',
        salary: json["salary"] ?? '',
        userId: json["UserId"] ?? '',
        requirements: json["requirements"] ?? '',
        imageUrl: json["imageUrl"] ?? '',
        deadline: json["deadline"] ?? '',
        createdAt: DateTime.parse(json["createdAt"] ?? ''),
        updatedAt: DateTime.parse(json["updatedAt"] ?? ''),
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "title": title,
        "username": username,
        "description": description,
        "salary": salary,
        "UserId": userId,
        "requirements": requirements,
        "imageUrl": imageUrl,
        "deadline": deadline,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
    };
}