// To parse this JSON data, do
//
//     final quizReq = quizReqFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

QuizReq quizReqFromJson(String str) => QuizReq.fromJson(json.decode(str));

String quizReqToJson(QuizReq data) => json.encode(data.toJson());







class QuizReq {

  final String jobId;
    final List<String> question;
    final List<String> correctcontroller;
    final List<String> option1controller;
    final List<String> option2controller;
    final List<String> option3controller;
    final List<String> option4controller;
  
    QuizReq({
      required this.question, 
      required this.correctcontroller,
       required this.option1controller, 
       required this.option2controller, 
         required this.option3controller,
           required this.option4controller, 
        required this.jobId,
        
    });

    factory QuizReq.fromJson(Map<String, dynamic> json) => QuizReq(
        jobId: json["JobId"],
      


        question: List<String>.from(json["question"].map((x) => x)),
        correctcontroller: List<String>.from(json["correctcontroller"].map((x) => x)),
        option1controller: List<String>.from(json["option1controller"].map((x) => x)),
        option2controller: List<String>.from(json["option2controller"].map((x) => x)),
          option3controller: List<String>.from(json["option3controller"].map((x) => x)),
            option4controller: List<String>.from(json["option4controller"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "JobId": jobId,


          "question": List<dynamic>.from(question.map((x) => x)),
        "correctcontroller": List<dynamic>.from(correctcontroller.map((x) => x)),
        "option1controller": List<dynamic>.from(option1controller.map((x) => x)),
        "option2controller": List<dynamic>.from(option2controller.map((x) => x)),
   "option3controller": List<dynamic>.from(option2controller.map((x) => x)),
   "option4controller": List<dynamic>.from(option2controller.map((x) => x)),
    };
}






/*




// To parse this JSON data, do
//
//     final quizResp = quizRespFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

QuizResp quizRespFromJson(String str) => QuizResp.fromJson(json.decode(str));

String quizRespToJson(QuizResp data) => json.encode(data.toJson());

class QuizResp {
    final String jobId;
    final List<String> question;
    final List<String> correctcontroller;
    final List<String> option1controller;
    final List<String> option2controller;
    final List<String> option3controller;
    final List<String> option4controller;
    final String id;
    final DateTime createdAt;

    QuizResp({
     required this.question, 
      required this.correctcontroller,
       required this.option1controller, 
       required this.option2controller, 
         required this.option3controller,
           required this.option4controller, 
        required this.jobId,
        
        required this.id,
        required this.createdAt,
    });

    factory QuizResp.fromJson(Map<String, dynamic> json) => QuizResp(
        jobId: json["JobId"],
        question: List<String>.from(json["question"].map((x) => x)),
        correctcontroller: List<String>.from(json["correctcontroller"].map((x) => x)),
        option1controller: List<String>.from(json["option1controller"].map((x) => x)),
        option2controller: List<String>.from(json["option2controller"].map((x) => x)),
          option3controller: List<String>.from(json["option3controller"].map((x) => x)),
            option4controller: List<String>.from(json["option4controller"].map((x) => x)),

        id: json["_id"],
        createdAt: DateTime.parse(json["createdAt"]),
    );

    Map<String, dynamic> toJson() => {
        "JobId": jobId,
        "question": List<dynamic>.from(question.map((x) => x)),
        "correctcontroller": List<dynamic>.from(correctcontroller.map((x) => x)),
        "option1controller": List<dynamic>.from(option1controller.map((x) => x)),
        "option2controller": List<dynamic>.from(option2controller.map((x) => x)),
   "option3controller": List<dynamic>.from(option2controller.map((x) => x)),
   "option4controller": List<dynamic>.from(option2controller.map((x) => x)),

   
        "_id": id,
        "createdAt": createdAt.toIso8601String(),
    };
}




*/ 