// To parse this JSON data, do
//
//     final getFormRes = getFormResFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

GetFormRes getFormResFromJson(String str) => GetFormRes.fromJson(json.decode(str));

String getFormResToJson(GetFormRes data) => json.encode(data.toJson());

class GetFormRes {
    final String id;
    final String jobId;
    final String adminId;
    final String agentId;
    final String score;
    final String cv;
    final bool reject;
    final bool accepted;
     final String similarity;
    final DateTime createdAt;
    final DateTime updatedAt;

    GetFormRes({
        required this.id,
        required this.jobId,
        required this.adminId,
        required this.agentId,
        required this.score,
        required this.cv,
        required this.reject,
        required this.accepted,
           required this.similarity,
        required this.createdAt,
        required this.updatedAt,
    });

    factory GetFormRes.fromJson(Map<String, dynamic> json) => GetFormRes(
        id: json["_id"]?? ' ',
        jobId: json["JobId"]?? ' ',
        adminId: json["adminId"]?? ' ',
        agentId: json["agentId"]?? ' ',
        score: json["Score"]?? ' ',
        cv: json["CV"]?? ' ',
        reject: json["reject"]?? ' ',
        accepted: json["Accepted"]?? ' ',
          similarity: json["similarity"] ?? ' ',
        createdAt: DateTime.parse(json["createdAt"]?? ' '),
        updatedAt: DateTime.parse(json["updatedAt"]?? ' '),
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "JobId": jobId,
        "adminId": adminId,
        "agentId": agentId,
        "Score": score,
        "CV": cv,
        "reject": reject,
        "Accepted": accepted,
          "similarity": similarity,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
    };
}