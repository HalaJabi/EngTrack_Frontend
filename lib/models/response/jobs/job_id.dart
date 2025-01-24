// To parse this JSON data, do
//
//     final jobRes = jobResFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

JobRes jobResFromJson(String str) => JobRes.fromJson(json.decode(str));

String jobResToJson(JobRes data) => json.encode(data.toJson());

class JobRes {
    final String title;
    final String location;
    final String company;
    final String description;
    final String salary;
    final String period;
    final String contract;
    final String adminId;
    final String requirements;
    final String id;
    final DateTime createdAt;

    JobRes({
        required this.title,
        required this.location,
        required this.company,
        required this.description,
        required this.salary,
        required this.period,
        required this.contract,
        required this.adminId,
        required this.requirements,
        required this.id,
        required this.createdAt,
    });

    factory JobRes.fromJson(Map<String, dynamic> json) => JobRes(
        title: json["title"],
        location: json["location"],
        company: json["company"],
        description: json["description"],
        salary: json["salary"],
        period: json["period"],
        contract: json["contract"],
        adminId: json["adminId"],
        requirements: json["requirements"],
        id: json["_id"],
        createdAt: DateTime.parse(json["createdAt"]),
    );

    Map<String, dynamic> toJson() => {
        "title": title,
        "location": location,
        "company": company,
        "description": description,
        "salary": salary,
        "period": period,
        "contract": contract,
        "adminId": adminId,
        "requirements": requirements,
        "_id": id,
        "createdAt": createdAt.toIso8601String(),
    };
}