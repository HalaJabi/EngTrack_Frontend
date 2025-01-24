import 'dart:async';
import 'dart:ffi';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:front/constants/app_constants.dart';
import 'package:front/controllers/quiz_provider.dart';
import 'package:front/helpers/UserManger.dart';
import 'package:front/models/profile_model.dart';
import 'package:front/models/response/getquiz.dart';
import 'package:front/models/response/quiz_res.dart';
import 'package:front/views/common/custom_btn.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:provider/provider.dart';

class Question extends StatefulWidget {
  const Question({super.key});

  @override
  State<Question> createState() => _MyQuestion();
}

class _MyQuestion extends State<Question> {
  int index = 0;

  int num_of_Q = UserManager.questions.length;

  int count_correct_answer = 0;

  final RxInt _sec = 30.obs;

  late PageController page;
  bool ispress = false;
  String? selected;
  int indexOption = 0;
  Timer? timer;
  final maxSec = 30;
  int correct = 1;
  @override
  void initState() {
    super.initState();
    page = PageController(initialPage: 0);
    restAnswer();
  }

  @override
  void dispose() {
    page.dispose();

    super.dispose();
  }

  void restAnswer() {
    setState(() {
      for (var element in UserManager.questions) {
        UserManager.questions.addAll({element});
      }
    });
  }

  void resetTimer() => _sec.value = maxSec;

  void stopTimer() => timer!.cancel();
  void starttimer() {
    resetTimer();
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_sec.value > 0) {
        _sec.value--;
      } else {
        stopTimer();
        nextQuestion();
      }
    });
  }

  double get scoreResult {
    return count_correct_answer * 100 / UserManager.questions.length;
  }

  void checkAnswer(String selctAns) {
    setState(() {
      ispress = true;
      selected = selctAns;
      //correct = UserManager.option1[index];

      if (UserManager.option1[index] == selected) {
        count_correct_answer++;
      }

      stopTimer();
    });

    Future.delayed(const Duration(milliseconds: 500))
        .then((value) => nextQuestion());
  }

  nextQuestion() {
    if (timer != null || timer!.isActive) {
      stopTimer();
    }
    if (page.page == UserManager.questions.length - 1) {
    } else {
      ispress = false;
      page.nextPage(
          duration: Duration(microseconds: 500), curve: Curves.linear);
      index++;
      starttimer();
    }

    num_of_Q = num_of_Q + 2; //مش حااسه صح
  }

  Color getColor(int aindex) {
    if (ispress) {
      if (aindex == correct) {
        return Colors.green;
      } else if (aindex != 1) {
        //في مشكله 24

        return Colors.red;
      }
    }
    return Colors.white;
  }

  IconData geticon(int aindex) {
    if (ispress) {
      if (aindex == correct) {
        return Icons.done;
      } else if (aindex != 1) {
        //في مشكله 24
        return Icons.close;
      }
    }
    return Icons.close;
  }

  void startAgin() {
    count_correct_answer = 0;
    selected = null;
    restAnswer();
    //go to welcom
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(kOrange.value),
        body: Consumer<QuizzNotifier>(builder: (context, quizNotifier, child) {
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

                //  print(UserManager.jobId);

                //  print(userData!.question[index]);

                  return Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 50.0, left: 20.0),
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap: () => Get.back(),
                              child: const Icon(CupertinoIcons.arrow_left),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20.0),
                      Expanded(
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30),
                              topRight: Radius.circular(30),
                            ),
                          ),
                          child: Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                    left: 20.0, right: 20.0, top: 40.0),
                                child: Container(
                                  padding: EdgeInsets.all(15),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Color(0xFF818181), width: 1.5),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: Text(
                                    userData!.question[index],
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 100),
                              // Add your options here using the same structure
                              Container(
                                width: MediaQuery.of(context).size.width,
                                padding: EdgeInsets.all(15),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Color(0xFF818181), width: 1.5),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Text(
                                  userData!.option1Controller[index],
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              SizedBox(height: 20.0),
                              Container(
                                width: MediaQuery.of(context).size.width,
                                padding: EdgeInsets.all(15),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Color(0xFF818181), width: 1.5),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Text(
                                  userData!.option2Controller[index],
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              SizedBox(height: 20.0),
                              Container(
                                width: MediaQuery.of(context).size.width,
                                padding: EdgeInsets.all(15),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Color(0xFF818181), width: 1.5),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Text(
                                  userData!.option3Controller[index],
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              SizedBox(height: 20.0),
                              Container(
                                width: MediaQuery.of(context).size.width,
                                padding: EdgeInsets.all(15),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Color(0xFF818181), width: 1.5),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Text(
                                  userData!.option4Controller[index],
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),

                              CustomButton(
                                text: "next",
                                onTap: () {
                             setState(() {
      if (index < userData.question.length - 1) {
        index++;
      } else {
        // If you want to loop back to the first question when reaching the end
        index = 0;
      }
                                  });
                                },
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                }
              });
        }));
  }
}






/*




   return InkWell(
                    onTap: null,
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(width: 3, color: getColor(indexOption))),
                    ),
                  );

     








return Obx(
      () => SizedBox(
        height: 50,
        width: 50,
        child: Stack(
          alignment: Alignment.center,
          fit: StackFit.expand,
          children: [
            CircularProgressIndicator(
              value: 1 - (_sec.value / 15),
              color: KPrimaryColor,
              backgroundColor: Colors.grey,
              strokeWidth: 8,
            ),
            Center(
              child: Text(
                '${_sec.value}',
                style: Theme.of(context)
                    .textTheme
                    .headline6!
                    .copyWith(color: KPrimaryColor),
              ),
            ),
          ],
        ),
      ),
    );
*/ 