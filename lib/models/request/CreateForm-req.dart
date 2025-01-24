// To parse this JSON data, do
//
//     final formReq = formReqFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

FormReq formReqFromJson(String str) => FormReq.fromJson(json.decode(str));

String formReqToJson(FormReq data) => json.encode(data.toJson());

class FormReq {
  final String agentId;
  final String jobId;
  final String adminId;
  final String score;
  final String cv;
  final String similarity;

  FormReq({
    required this.agentId,
    required this.jobId,
    required this.adminId,
    required this.score,
    required this.cv,
     required this.similarity,
  });

  factory FormReq.fromJson(Map<String, dynamic> json) => FormReq(
        agentId: json["agentId"] ?? ' ',
        jobId: json["JobId"] ?? ' ',
        adminId: json["adminId"] ?? ' ',
        score: json["Score"] ?? ' ',
        cv: json["CV"] ?? ' ',
         similarity: json["similarity"] ?? ' ',
      );

  Map<String, dynamic> toJson() => {
        "agentId": agentId,
        "JobId": jobId,
        "adminId": adminId,
        "Score": score,
        "CV": cv,
          "similarity": similarity,
      };
}
