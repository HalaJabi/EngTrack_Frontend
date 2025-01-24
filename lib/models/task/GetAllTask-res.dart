// To parse this JSON data, do
//
//     final getAllTaskRes = getAllTaskResFromJson(jsonString);
/*
import 'package:meta/meta.dart';
import 'dart:convert';

List<GetAllTaskRes> getAllTaskResFromJson(String str) =>
    List<GetAllTaskRes>.from(
        json.decode(str).map((x) => GetAllTaskRes.fromJson(x)));

String getAllTaskResToJson(List<GetAllTaskRes> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetAllTaskRes {
  final String jobid;
  final String id;
  final String title;
  final String note;
  final List<String>? members;
  final String? comment;
  final DateTime startDate;
  final DateTime endDate;
  final String endTime;
  final DateTime createdAt;
  final DateTime updatedAt;
   bool ?toDo;
 bool ?inProgress;
bool ?underReview;
 bool ?done;

  GetAllTaskRes({
    required this.jobid,
    required this.id,
    required this.title,
    required this.note,
  this.members,
    this.comment,
    required this.startDate,
    required this.endDate,
    required this.endTime,
    required this.createdAt,
    required this.updatedAt,
     this.toDo,
  this.inProgress,
   this.underReview,
       this.done,
  });

  factory GetAllTaskRes.fromJson(Map<String, dynamic> json) => GetAllTaskRes(
        jobid: json["jobid"] ?? '',
        id: json["_id"] ?? '',
        title: json["title"] ?? '',
        note: json["Note"] ?? '',
      members: List<String>.from(json["members"] ?? ''),
       comment: json["comment"] ?? '',
        startDate: DateTime.parse(json["StartDate"] ?? ''),
        endDate: DateTime.parse(json["EndDate"] ?? ''),
        endTime: json["EndTime"] ?? '',
        createdAt: DateTime.parse(json["createdAt"] ?? ''),
        updatedAt: DateTime.parse(json["updatedAt"] ?? ''),
toDo:json["toDo"]?? '',
inProgress:json["inProgress"]?? '',
underReview:json["underReview"]?? '',
done:json["done"]?? '',



      );

  Map<String, dynamic> toJson() => {
        "jobid": jobid,
        "_id": id,
        "title": title,
        "Note": note,
        "members": members,
       "comment": comment,
        "StartDate": startDate.toIso8601String(),
        "EndDate": endDate.toIso8601String(),
        "EndTime": endTime,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),


        "toDo":toDo,
        "inProgress":inProgress,
        "underReview":underReview,
       "done":done,
      };
}
*/

// To parse this JSON data, do
//
//     final getAllTaskRes = getAllTaskResFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<GetAllTaskRes> getAllTaskResFromJson(String str) =>
    List<GetAllTaskRes>.from(
        json.decode(str).map((x) => GetAllTaskRes.fromJson(x)));

String getAllTaskResToJson(List<GetAllTaskRes> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetAllTaskRes {
  final String jobid;
  final String id;
  final String title;
  final String note;
  final List<String>? members;
  final String? comment;
  final DateTime? startDate;
  final DateTime? endDate;
  final String? endTime;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  bool? toDo;
  bool? inProgress;
  bool? underReview;
  bool? done;

  GetAllTaskRes({
    required this.jobid,
    required this.id,
    required this.title,
    required this.note,
    this.members,
    this.comment,
    this.startDate,
    this.endDate,
    this.endTime,
    this.createdAt,
    this.updatedAt,
    this.toDo,
    this.inProgress,
    this.underReview,
    this.done,
  });

  factory GetAllTaskRes.fromJson(Map<String, dynamic> json) => GetAllTaskRes(
        jobid: json["jobid"] ?? '',
        id: json["_id"] ?? '',
        title: json["title"] ?? '',
        note: json["Note"] ?? '',
        members: json["members"] != null
            ? List<String>.from(json["members"])
            : null,
        comment: json["comment"],
        startDate: json["StartDate"] != null && json["StartDate"].isNotEmpty
            ? DateTime.parse(json["StartDate"])
            : null,
        endDate: json["EndDate"] != null && json["EndDate"].isNotEmpty
            ? DateTime.parse(json["EndDate"])
            : null,
        endTime: json["EndTime"],
        createdAt: json["createdAt"] != null && json["createdAt"].isNotEmpty
            ? DateTime.parse(json["createdAt"])
            : null,
        updatedAt: json["updatedAt"] != null && json["updatedAt"].isNotEmpty
            ? DateTime.parse(json["updatedAt"])
            : null,
        toDo: json["toDo"],
        inProgress: json["inProgress"],
        underReview: json["underReview"],
        done: json["done"],
      );

  Map<String, dynamic> toJson() => {
        "jobid": jobid,
        "_id": id,
        "title": title,
        "Note": note,
        "members": members,
        "comment": comment,
        "StartDate": startDate?.toIso8601String(),
        "EndDate": endDate?.toIso8601String(),
        "EndTime": endTime,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "toDo": toDo,
        "inProgress": inProgress,
        "underReview": underReview,
        "done": done,
      };
}
