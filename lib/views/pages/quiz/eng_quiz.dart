import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:front/constants/app_constants.dart';
import 'package:front/constants/theme.dart';
import 'package:front/views/common/height_spacer.dart';
import 'package:front/views/pages/quiz/quiz_screen.dart';
import 'package:front/views/pages/quiz/text_style.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class welcom_quiz extends StatefulWidget {
  const welcom_quiz({super.key});

  @override
  State<welcom_quiz> createState() => _welcom_quizState();
}

class _welcom_quizState extends State<welcom_quiz> {
  @override
  Widget build(BuildContext context) {
   
    var size = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: const BoxDecoration(
              gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [kDarkBlue, kOrange],
          )),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
          

   const HeightSpacer(size: 20),


 GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: const Icon(CupertinoIcons.arrow_left,color: white,),
              ),
           







              Image.asset(
                "assets/images/quiz.png",
              ),
              const SizedBox(height: 20),
              normalText(color: Colors.white, size: 18, text: "Welcome to our"),
              headingText(color: Colors.white, size: 32, text: "Quiz App"),
              const SizedBox(height: 20),
              normalText(
                  color: Colors.white,
                  size: 16,
                  text: "Do you feel confident? Here you'll face our most difficult questions!"),
              const Spacer(),
              Align(
                alignment: Alignment.center,
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const QuizScreen()));
                  },
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 20),
                    alignment: Alignment.center,
                    width: size.width - 100,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: headingText(color: kOrange, size: 18, text: "Continue"),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );


  }
}