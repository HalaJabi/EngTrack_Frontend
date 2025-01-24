// To parse this JSON data, do
//
//     final addTaskReq = addTaskReqFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

AddTaskReq addTaskReqFromJson(String str) =>
    AddTaskReq.fromJson(json.decode(str));

String addTaskReqToJson(AddTaskReq data) => json.encode(data.toJson());

class AddTaskReq {
  final String jobid;
  final String title;
  final String note;
  final String startDate;

  final String endDate;
  final String endTime;
  // final List<String>? members;
  

  AddTaskReq({
    required this.jobid,
    required this.title,
    required this.note,
    required this.startDate,
  
    required this.endDate,
    required this.endTime,
  //this.members,
  });

  factory AddTaskReq.fromJson(Map<String, dynamic> json) => AddTaskReq(
        jobid: json["jobid"] ?? '',
        title: json["title"] ?? '',
        note: json["Note"] ?? '',
        startDate: json["StartDate"] ?? '',
       
        endDate: json["EndDate"] ?? '',
        endTime: json["EndTime"] ?? '',
    //  members: List<String>.from(json["members"] ?? ''),
      );

  Map<String, dynamic> toJson() => {
        "jobid": jobid,
        "title": title,
        "Note": note,
        "StartDate": startDate,
  
        "EndDate": endDate,
        "EndTime": endTime,
   //    "members": members,
      };
}
