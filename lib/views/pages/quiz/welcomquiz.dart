import 'package:flutter/material.dart';
import 'package:front/constants/app_constants.dart';
import 'package:front/controllers/quiz_provider.dart';
import 'package:front/helpers/UserManger.dart';
import 'package:front/models/response/getquiz.dart';
import 'package:front/views/common/app_bar.dart';
import 'package:front/views/common/custom_btn.dart';
import 'package:front/views/common/drawer_widget.dart';
import 'package:front/views/pages/quiz/Add-quiz.dart';
import 'package:front/views/pages/quiz/question.dart';
import 'package:front/views/pages/test1.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class ImagePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<QuizzNotifier>(builder: (context, quizNotifier, child) {
      quizNotifier.getquiz(UserManager.jobId);

      return FutureBuilder<GetQuiz>(
        future: quizNotifier.quiz,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text("Error ${snapshot.error}"),
            );
          } else {
            final userData = snapshot.data;

            return Scaffold(
              appBar: PreferredSize(
                preferredSize: const Size.fromHeight(50),
                child: CustomAppBar(
                  color: Color(0xFFFAF0E6),
                  text: "Start Quiz",
                  child: GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: Padding(
                      padding: EdgeInsets.all(12.0),
                      child: const DrawerWidget(),
                    ),
                  ),
                ),
              ),
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      width: 200,
                      height: 200,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: AssetImage(
                              "assets/images/quiz.png"), // Replace with the actual image path
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(height: 20), // Space between image and button
                    CustomButton(
                      width: 200,
                      height: 50,
                      color: Color(kOrange.value),
                      onTap: () {
                      
                        Get.to(Question());
                      },
                      text:
                          "Before starting the quiz, please note that you have a ${userData!.question.length} number of questions to focus on.",
                    ),
                    SizedBox(height: 20),
                    Text(
                      'You ',
                      style: TextStyle(fontSize: 20),
                    ),
                  ],
                ),
              ),
            );
          }
        },
      );
    });
  }
}
