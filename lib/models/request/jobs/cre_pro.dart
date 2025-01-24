// To parse this JSON data, do
//
//     final projectReq = projectReqFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

ProjectReq projectReqFromJson(String str) => ProjectReq.fromJson(json.decode(str));

String projectReqToJson(ProjectReq data) => json.encode(data.toJson());

class ProjectReq {
    final String title;
    final String username;
    final String description;
    final String imageUrl;
    final String salary;
    final String userId;
    final String requirements;
    final String deadline;

    ProjectReq({
        required this.title,
        required this.username,
        required this.description,
        required this.imageUrl,
        required this.salary,
        required this.userId,
        required this.requirements,
        required this.deadline,
    });

    factory ProjectReq.fromJson(Map<String, dynamic> json) => ProjectReq(
        title: json["title"]?? '',
        username: json["username"]?? '',
        description: json["description"]?? '',
        imageUrl: json["imageUrl"]?? '',
        salary: json["salary"]?? '',
        userId: json["UserId"]?? '',
        requirements: json["requirements"]?? '',
        deadline: json["deadline"]?? '',
    );

    Map<String, dynamic> toJson() => {
        "title": title,
        "username": username,
        "description": description,
        "imageUrl": imageUrl,
        "salary": salary,
        "UserId": userId,
        "requirements": requirements,
        "deadline": deadline,
    };
}