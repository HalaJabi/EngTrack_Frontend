// To parse this JSON data, do
//
//     final addTaskRes = addTaskResFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';
/*
AddTaskRes addTaskResFromJson(String str) => AddTaskRes.fromJson(json.decode(str));

String addTaskResToJson(AddTaskRes data) => json.encode(data.toJson());

class AddTaskRes {
      final String jobid;
    final String title;
    final String note;
    final DateTime startDate;
    final DateTime endDate;
    final String endTime;
    final String id;
    final DateTime createdAt;

    AddTaskRes({
       required this.jobid,
        required this.title,
        required this.note,
        required this.startDate,
        required this.endDate,
        required this.endTime,
        required this.id,
        required this.createdAt,
    });

    factory AddTaskRes.fromJson(Map<String, dynamic> json) => AddTaskRes(
        jobid: json["jobid"]?? '',
        title: json["title"]?? '',
        note: json["Note"]?? '',
        startDate: DateTime.parse(json["StartDate"]?? ''),
        endDate: DateTime.parse(json["EndDate"]?? ''),
        endTime: json["EndTime"]?? '',
        id: json["_id"]?? '',
        createdAt: DateTime.parse(json["createdAt"]?? ''),
    );

    Map<String, dynamic> toJson() => {
        "jobid": jobid,
        "title": title,
        "Note": note,
        "StartDate": startDate.toIso8601String(),
        "EndDate": endDate.toIso8601String(),
        "EndTime": endTime,
        "_id": id,
        "createdAt": createdAt.toIso8601String(),
    };
}*/