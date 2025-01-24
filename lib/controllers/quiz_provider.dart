import 'dart:async';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:front/constants/app_constants.dart';
import 'package:front/helpers/UserManger.dart';
import 'package:front/helpers/quiz_helper.dart';
import 'package:front/models/request/quiz_req.dart';
import 'package:front/models/response/getquiz.dart';
import 'package:front/models/response/jobs/cre_pro_res.dart';
import 'package:front/models/response/jobs/get_job.dart';
import 'package:front/models/response/jobs/jobs_response.dart';
import 'package:front/models/response/jobs/pro_res.dart';
import 'package:front/views/pages/MyJopList.dart';
import 'package:front/views/pages/create_job.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class QuizzNotifier extends ChangeNotifier {
  late Future<GetQuiz> quiz;

 

  







  getquiz(String jobId) {
    quiz = QuizHelper.getQuiz(jobId);
  }

  List<String> correct = [];

  List<String> option1 = [];
  List<String> option2 = [];
  List<String> option3 = [];
  List<String> option4 = [];

  void addcorrect(String correcta) {
    correct.add(correcta);
    notifyListeners(); // Notify listeners of changes
  }

  void addoption1(String option11) {
    option1.add(option11);
    notifyListeners(); // Notify listeners of changes
  }

  void addoption2(String option22) {
    option2.add(option22);
    notifyListeners(); // Notify listeners of changes
  }

  void addoption3(String option33) {
    option3.add(option33);
    notifyListeners(); // Notify listeners of changes
  }

  void addoption4(String option44) {
    option4.add(option44);
    notifyListeners(); // Notify listeners of changes
  }

  createquiz(QuizReq quizData) {
    QuizHelper.createquiz(quizData).then((response) {
      if (response) {
        UserManager.questions = [];
        UserManager.option1 = [];
        UserManager.option2 = [];
        UserManager.option3 = [];
        UserManager.option4 = [];
           
        Get.snackbar(
          'Create Quiz Succeed ',
          "Please Check try again",
          colorText: Color(kLight.value),
          backgroundColor: Colors.green,
          icon: const Icon(Icons.add_alert),
        );


        
      } else {
        Get.snackbar(
          'Create Quiz Failed',
          "Please Check try again",
          colorText: Color(kLight.value),
          backgroundColor: Colors.red,
          icon: const Icon(Icons.add_alert),
        );
      }
    });
  }
}
