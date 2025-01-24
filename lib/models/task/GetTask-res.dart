// To parse this JSON data, do
//
//     final getTaskRes = getTaskResFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

GetTaskRes getTaskResFromJson(String str) => GetTaskRes.fromJson(json.decode(str));

String getTaskResToJson(GetTaskRes data) => json.encode(data.toJson());

class GetTaskRes {
    final String id;
    final String title;
    final String note;
    final DateTime startDate;
    final DateTime endDate;
    final String endTime;
    final DateTime createdAt;
    final DateTime updatedAt;
    final List<String>? members;

    GetTaskRes({
        required this.id,
        required this.title,
        required this.note,
        required this.startDate,
        required this.endDate,
        required this.endTime,
        required this.createdAt,
        required this.updatedAt,
        this.members,
    });

    factory GetTaskRes.fromJson(Map<String, dynamic> json) => GetTaskRes(
        id: json["_id"]??'',
        title: json["title"]??'',
        note: json["Note"]??'',
        startDate: DateTime.parse(json["StartDate"]??''),
        endDate: DateTime.parse(json["EndDate"]??''),
        endTime: json["EndTime"]??'',
        createdAt: DateTime.parse(json["createdAt"]??''),
        updatedAt: DateTime.parse(json["updatedAt"]??''),
       members: List<String>.from(json["members"] ?? ''),
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "title": title,
        "Note": note,
        "StartDate": startDate.toIso8601String(),
        "EndDate": endDate.toIso8601String(),
        "EndTime": endTime,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
          "members": members,
    };
}