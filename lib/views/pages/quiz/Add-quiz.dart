import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:front/constants/app_constants.dart';
import 'package:front/controllers/quiz_provider.dart';
import 'package:front/helpers/UserManger.dart';
import 'package:front/models/request/quiz_req.dart';
import 'package:front/views/common/app_bar.dart';
import 'package:front/views/common/custom_btn.dart';
import 'package:front/views/pages/MyJopList.dart';
import 'package:front/views/pages/quiz/Qpage1.dart';
import 'package:front/views/pages/quiz/Qpage2.dart';
import 'package:front/views/pages/quiz/Qpage3.dart';
import 'package:front/views/pages/quiz/Qpage4.dart';
import 'package:front/views/pages/quiz/Qpage5.dart';
import 'package:front/views/pages/quiz/progress.dart';
import 'package:front/views/pages/quiz/quiz_screen.dart';
import 'package:front/views/pages/quiz/text_style.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:provider/provider.dart';

class Addquiz extends StatefulWidget {
  final String jobid;
  const Addquiz({super.key, required this.jobid});

  @override
  State<Addquiz> createState() => _MyAddquiz();
}

class _MyAddquiz extends State<Addquiz> {

  @override
  Widget build(BuildContext context) {

  double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(




appBar: PreferredSize(
  preferredSize: const Size.fromHeight(50),
  child: CustomAppBar(
    color: const Color(0xFFFAF0E6),
    text: "Add Quiz",
    child: GestureDetector(
      onTap: () {
        Get.back();
          Get.back();
       
      },
      child: const Icon(CupertinoIcons.arrow_left),
    ),
  ),
),


      
      body: Stack(
        children: [
          Container(
            width: width,
            height: height,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [Color(kOrange.value), Colors.white],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter)),
          ),
          Image.asset("assets/images/quiz.png"),
          DraggableScrollableSheet(
            maxChildSize: .9,
            minChildSize: .5,
            initialChildSize: .6,
            builder: (ctx, controller) {
              return Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30)),
                child: SingleChildScrollView(
                  controller: controller,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      PForm(pages: [
                        Page1(),
                        Page2(),
                        Page3(),
                        Page4(),
                      ], title: [
                        PTitle(
                          title: "Question 1",
                          subTitle:
                              "Please put the first option as correct answer",
                          activeColor: Colors.orange,
                        ),
                        PTitle(
                          title: "Question 2",
                          subTitle:
                              "Please put the first option as correct answer",
                          activeColor: Colors.orange,
                        ),
                        PTitle(
                          title: "Question 3",
                          subTitle:
                              "Please put the first option as correct answer",
                          activeColor: Colors.orange,
                        ),
                        PTitle(
                          title: "Question 4",
                          subTitle:
                              "Please put the first option as correct answer",
                          activeColor: Colors.orange,
                        ),
                      ]),



                      
                      Consumer<QuizzNotifier>(
                          builder: (context, quizzNotifier, child) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CustomButton(
                              width: 200,
                              height: 50,
                              color: Color(kOrange.value),
                              onTap: () async {
                                QuizReq model = QuizReq(
                                  jobId: widget.jobid,
                                  question: UserManager.questions,
                                  correctcontroller: ['1'],
                                  option1controller: UserManager.option1,
                                  option2controller: UserManager.option2,
                                  option3controller: UserManager.option3,
                                  option4controller: UserManager.option4,
                                );

                                quizzNotifier.createquiz(model);

  
                              
                                
                              },
                              text: "Add Quiz",
                            ),
                            SizedBox(width: 100),
                            Padding(
                              
                              padding: const EdgeInsets.only(bottom: 10),
                              child: FloatingActionButton(
                                  backgroundColor: Color(kOrange.value),
                                  onPressed: () {
                                  Get.to(  Page5());
                                  },
                                  child: const Icon(
                                    Icons.add,
                                    size: 30,
                                  )),
                            ),
                          ],
                        );
                      })
                    ],
                  ),
                ),
              );
            },
          )
        ],
      ),
    );
  }
}












