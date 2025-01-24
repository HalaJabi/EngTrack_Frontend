// To parse this JSON data, do
//
//     final getQuiz = getQuizFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

GetQuiz getQuizFromJson(String str) => GetQuiz.fromJson(json.decode(str));

String getQuizToJson(GetQuiz data) => json.encode(data.toJson());

class GetQuiz {
    final String id;
    final String jobId;
    final List<String> question;
    final List<String> correctcontroller;
    final List<String> option1Controller;
    final List<String> option2Controller;
    final List<String> option3Controller;
    final List<String> option4Controller;
    final DateTime createdAt;
    final DateTime updatedAt;

    GetQuiz({
        required this.id,
        required this.jobId,
        required this.question,
        required this.correctcontroller,
        required this.option1Controller,
        required this.option2Controller,
        required this.option3Controller,
        required this.option4Controller,
        required this.createdAt,
        required this.updatedAt,
    });

    factory GetQuiz.fromJson(Map<String, dynamic> json) => GetQuiz(
        id: json["_id"],
        jobId: json["JobId"],
        question: List<String>.from(json["question"].map((x) => x)),
        correctcontroller: List<String>.from(json["correctcontroller"].map((x) => x)),
        option1Controller: List<String>.from(json["option1controller"].map((x) => x)),
        option2Controller: List<String>.from(json["option2controller"].map((x) => x)),
        option3Controller: List<String>.from(json["option3controller"].map((x) => x)),
        option4Controller: List<String>.from(json["option4controller"].map((x) => x)),
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "JobId": jobId,
        "question": List<dynamic>.from(question.map((x) => x)),
        "correctcontroller": List<dynamic>.from(correctcontroller.map((x) => x)),
        "option1controller": List<dynamic>.from(option1Controller.map((x) => x)),
        "option2controller": List<dynamic>.from(option2Controller.map((x) => x)),
        "option3controller": List<dynamic>.from(option3Controller.map((x) => x)),
        "option4controller": List<dynamic>.from(option4Controller.map((x) => x)),
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
    };
}
