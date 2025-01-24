// To parse this JSON data, do
//
//     final projectRes = projectResFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

ProjectRes projectResFromJson(String str) => ProjectRes.fromJson(json.decode(str));

String projectResToJson(ProjectRes data) => json.encode(data.toJson());

class ProjectRes {
    final String title;
    final String username;
    final String description;
    final String salary;
    final String userId;
    final String requirements;
    final String deadline;
    final String id;
    final DateTime createdAt;

    ProjectRes({
        required this.title,
        required this.username,
        required this.description,
        required this.salary,
        required this.userId,
        required this.requirements,
        required this.deadline,
        required this.id,
        required this.createdAt,
    });

    factory ProjectRes.fromJson(Map<String, dynamic> json) => ProjectRes(
        title: json["title"] ?? '',
        username: json["username"] ?? '',
        description: json["description"] ?? '',
        salary: json["salary"] ?? '',
        userId: json["UserId"]?? '',
        requirements: json["requirements"]?? '',
        deadline: json["deadline"]?? '',
        id: json["_id"]?? '',
        createdAt: DateTime.parse(json["createdAt"] ?? ''),
    );

    Map<String, dynamic> toJson() => {
        "title": title,
        "username": username,
        "description": description,
        "salary": salary,
        "UserId": userId,
        "requirements": requirements,
        "deadline": deadline,
        "_id": id,
        "createdAt": createdAt.toIso8601String(),
    };
}