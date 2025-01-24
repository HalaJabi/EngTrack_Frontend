import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:front/constants/app_constants.dart';
import 'package:front/controllers/profile_provider.dart';
import 'package:front/controllers/quiz_provider.dart';
import 'package:front/helpers/FormJobs_helper.dart';
import 'package:front/helpers/UserManger.dart';
import 'package:front/models/profile_model.dart';
import 'package:front/models/request/CreateForm-req.dart';
import 'package:front/models/response/getquiz.dart';
import 'package:front/views/pages/quiz/text_style.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({Key? key}) : super(key: key);

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  var uuid = Uuid();

  double similarityScore = 0.0; // Variable to hold the similarity score

  Future<File?> pickPDF() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null) {
      return File(result.files.single.path!);
    } else {
      return null;
    }
  }

  Future<void> uploadPDFAndCheckSimilarity(
      File file, String requirements, String description) async {
   var uri =
      Uri.parse('http://192.168.1.21:5000/upload'); // Replace with server URL


   // var uri = Uri.parse('http://127.0.0.1:5000/upload');
    var request = http.MultipartRequest('POST', uri)
      ..files.add(await http.MultipartFile.fromPath('file', file.path))
      ..fields['requirement'] = requirements
      ..fields['job_description'] = description;

    var response = await request.send();
    print('Response status code: ${response.statusCode}');

    if (response.statusCode == 200) {
      var responseData = await response.stream.bytesToString();
      var json = jsonDecode(responseData);
      setState(() {
        similarityScore = json['average_similarity_score']; // Update the score
      });

      /*  ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(
                'File uploaded successfully. Similarity score: $similarityScore%')),
      );*/
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to upload file')),
      );
    }
  }

  Future<firebase_storage.UploadTask?> uploadFileToFirebase(File? file) async {
    if (file == null) {
      print("No file was picked");
      return null;
    }
    firebase_storage.UploadTask? uploadTask;
    firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance
        .ref()
        .child('file')
        .child("${uuid.v1()}.pdf");

    final metadata = firebase_storage.SettableMetadata(
        contentType: 'application/pdf',
        customMetadata: {'picked-file-path': file.path});
    print("uploading");
    uploadTask = ref.putFile(file, metadata);
    print("done");
    return uploadTask;
  }

////////////////////////

  var currentQuestionIndex = 0;
  int seconds = 60;
  Timer? timer;
  int points = 0;

  var optionsList = [];

  var optionsColor = [
    Colors.white,
    Colors.white,
    Colors.white,
    Colors.white,
    Colors.white,
  ];

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  resetColors() {
    optionsColor = [
      Colors.white,
      Colors.white,
      Colors.white,
      Colors.white,
      Colors.white,
    ];
  }

  void showResults(BuildContext context, int totalQuestions, int points) {
   // final passThreshold = (totalQuestions * 0.6).ceil();
 //   final passPercentage = ((passThreshold / totalQuestions) * 100).toInt();




 final maxPoints = totalQuestions * 10; 
  final passPercentage = ((points / maxPoints) * 100).toInt(); 

  final passThreshold = (totalQuestions * 0.6).ceil(); 


    showDialog(
      context: context,
      builder: (context) {
        return Consumer<ProfileNotifier>(
          builder: (context, profileNotifier, child) {
            profileNotifier.getProfile();

            return FutureBuilder<ProfileRes>(
              future: profileNotifier.profile,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text("Error ${snapshot.error}"));
                } else if (snapshot.hasData) {
                  final userData = snapshot.data;

                  return AlertDialog(
                    title: const Text('Quiz Finished'),
                    content: points >= passThreshold
                        ? Text(
                            'Congratulations! You scored $points points.\nYou have passed the test with $passPercentage% correct answers.')
                        : Text(
                            'You scored $points points.\nSorry, you have not passed the test.'),
                    actions: [
                      if (points > passThreshold)
                        TextButton(
                          onPressed: () async {
                            File? file = await pickPDF();

                            if (file != null) {
                              // Upload file to Firebase Storage
                              firebase_storage.UploadTask? uploadTask =
                                  await uploadFileToFirebase(file);
                              if (uploadTask != null) {
                                // Handle successful upload
                                /*       ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text(
                                          'File uploaded to Firebase successfully')),
                                );*/

                                // Upload PDF and check similarity score
                                await uploadPDFAndCheckSimilarity(
                                    file,
                                    UserManager.requirements,
                                    UserManager.description);
                              } else {
                                // Handle unsuccessful upload
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text(
                                          'Failed to upload file to Firebase')),
                                );
                              }
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('No file was picked')),
                              );
                            }

                            if (userData != null) {
                              FormReq formData = FormReq(
                                agentId: userData.id,
                                jobId: UserManager.jobId,
                                adminId: UserManager.admainId,
                                score: points.toString(),
                                cv: file!.uri.toString(),
                                similarity: similarityScore.toString(),
                              );

                              FormJobsHelper.createFormJob(formData);

                              Navigator.pop(context);
                              Navigator.pop(context);
                              Navigator.pop(context);
                              Navigator.pop(context);
                              Navigator.pop(context);
                            }
                          },
                          child: const Text('Upload  your pdf'),
                        ),
                      if (points < passThreshold)
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                            Navigator.pop(context);
                            Navigator.pop(context);
                            Navigator.pop(context);
                            Navigator.pop(context);
                          },
                          child: const Text('CANCEL'),
                        ),
                    ],
                  );
                } else {
                  return Center(child: Text("No profile data found"));
                }
              },
            );
          },
        );
      },
    );
  }

  startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (seconds > 0) {
          seconds--;
        } else {
          gotoNextQuestion();
        }
      });
    });
  }

  gotoNextQuestion() {
    currentQuestionIndex++;

    resetColors();
    timer?.cancel();
    seconds = 60;
    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Consumer<QuizzNotifier>(
        builder: (context, quizNotifier, child) {
          quizNotifier.getquiz(UserManager.jobId);

          return SafeArea(
            child: Container(
              width: double.infinity,
              height: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    kOrange,
                    kDarkBlue,
                  ],
                ),
              ),
              child: FutureBuilder<GetQuiz>(
                future: quizNotifier.quiz,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final quizdata = snapshot.data;

                    optionsList = [
                      quizdata!.option1Controller[currentQuestionIndex],
                      quizdata!.option2Controller[currentQuestionIndex],
                      quizdata!.option3Controller[currentQuestionIndex],
                      quizdata!.option4Controller[currentQuestionIndex],
                    ];

                    return SingleChildScrollView(
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  border:
                                      Border.all(color: lightgrey, width: 2),
                                ),
                                child: IconButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  icon: const Icon(
                                    CupertinoIcons.xmark,
                                    color: Colors.white,
                                    size: 28,
                                  ),
                                ),
                              ),
                              Stack(
                                alignment: Alignment.center,
                                children: [
                                  normalText(
                                      color: Colors.white,
                                      size: 24,
                                      text: "$seconds"),
                                  SizedBox(
                                    width: 80,
                                    height: 80,
                                    child: CircularProgressIndicator(
                                      value: seconds / 60,
                                      valueColor: const AlwaysStoppedAnimation(
                                          Colors.white),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          Image.asset("assets/images/quiz2.png", width: 200),
                          const SizedBox(height: 20),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: normalText(
                              color: lightgrey,
                              size: 18,
                              text:
                                  "Question ${currentQuestionIndex + 1} of ${quizdata!.question.length}",
                            ),
                          ),
                          const SizedBox(height: 20),
                          normalText(
                              color: Colors.white,
                              size: 20,
                              text: quizdata.question[currentQuestionIndex]),
                          const SizedBox(height: 20),
                          ListView.builder(
                            shrinkWrap: true,
                            itemCount: 4,
                            itemBuilder: (BuildContext context, int index) {
                              var answer = quizdata
                                  .option1Controller[currentQuestionIndex];

                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    if (answer.toString() ==
                                        optionsList[index].toString()) {
                                      optionsColor[index] = Colors.green;
                                      points = points + 10;
                                    } else {
                                      optionsColor[index] = Colors.red;
                                    }

                                    if (currentQuestionIndex <
                                        quizdata.question.length - 1) {
                                      Future.delayed(const Duration(seconds: 1),
                                          () {
                                        gotoNextQuestion();
                                      });
                                    } else {
                                      timer?.cancel();
                                             
                                      showResults(context,
                                          quizdata.question.length, points);
                            

                                      // here you can do whatever you want with the results
                                    }
                                  });
                                },
                                child: Container(
                                  margin: const EdgeInsets.only(bottom: 20),
                                  alignment: Alignment.center,
                                  width: size.width - 100,
                                  padding: const EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                    color: optionsColor[index],
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: headingText(
                                    color: blue,
                                    size: 18,
                                    text: optionsList[index].toString(),
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    );
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation(Colors.white),
                      ),
                    );
                  }
                },
              ),
            ),
          );
        },
      ),
    );
  }
}

























































/*
import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:front/constants/app_constants.dart';
import 'package:front/controllers/quiz_provider.dart';
import 'package:front/helpers/UserManger.dart';
import 'package:front/models/response/getquiz.dart';
import 'package:front/views/pages/quiz/text_style.dart';
import 'package:provider/provider.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({Key? key}) : super(key: key);

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  @override

  
  var currentQuestionIndex = 0;
  int seconds = 60;
  Timer? timer;
  

  int points = 0;

  var isLoaded = false;

  var optionsList = [];

  var optionsColor = [
    Colors.white,
    Colors.white,
    Colors.white,
    Colors.white,
    Colors.white,
  ];

  @override
  void initState() {
    super.initState();
  
    startTimer();
  }

  @override
  void dispose() {
    timer!.cancel();
    super.dispose();
  }

  resetColors() {
    optionsColor = [
      Colors.white,
      Colors.white,
      Colors.white,
      Colors.white,
      Colors.white,
    ];
  }

  startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (seconds > 0) {
          seconds--;
        } else {
          gotoNextQuestion();
        }
      });
    });
  }

  gotoNextQuestion() {
    isLoaded = false;
    currentQuestionIndex++;
    resetColors();
    timer!.cancel();
    seconds = 60;
    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: 


    Consumer<QuizzNotifier>(builder: (context, quizNotifier, child) {
          quizNotifier.getquiz(UserManager.jobId);

    
      
      SafeArea(
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
        child:
        FutureBuilder<GetQuiz>(
              future: quizNotifier.quiz,
              builder: (context, snapshot) {


   if (snapshot.hasData) {
                  final userData = snapshot.data;

            

              return SingleChildScrollView(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            border: Border.all(color: lightgrey, width: 2),
                          ),
                          child: IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: const Icon(
                                CupertinoIcons.xmark,
                                color: Colors.white,
                                size: 28,
                              )),
                        ),
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            normalText(color: Colors.white, size: 24, text: "$seconds"),
                            SizedBox(
                              width: 80,
                              height: 80,
                              child: CircularProgressIndicator(
                                value: seconds / 60,
                                valueColor: const AlwaysStoppedAnimation(Colors.white),
                              ),
                            ),
                          ],
                        ),
                     
                      ],
                    ),
                    const SizedBox(height: 20),
                    Image.asset("", width: 200),
                    const SizedBox(height: 20),
                    Align(
                        alignment: Alignment.centerLeft,
                        child: normalText(
                            color: lightgrey,
                            size: 18,
                            text: "Question ${currentQuestionIndex + 1} of ${userData!.question.length}")),
                    const SizedBox(height: 20),
                    normalText(color: Colors.white, size: 20, text:userData.question[currentQuestionIndex] ),
                    const SizedBox(height: 20),
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: optionsList.length,
                      itemBuilder: (BuildContext context, int index) {
                        var answer =userData.option1Controller[currentQuestionIndex];

                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              if (answer.toString() == optionsList[index].toString()) {
                                optionsColor[index] = Colors.green;
                                points = points + 10;
                              } else {
                                optionsColor[index] = Colors.red;
                              }

                              if (currentQuestionIndex < userData!.question.length - 1) {
                                Future.delayed(const Duration(seconds: 1), () {
                                  gotoNextQuestion();
                                });
                              } else {
                                timer!.cancel();
                                //here you can do whatever you want with the results
                              }
                            });
                          },
                          child: Container(
                            margin: const EdgeInsets.only(bottom: 20),
                            alignment: Alignment.center,
                            width: size.width - 100,
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: optionsColor[index],
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: headingText(
                              color: blue,
                              size: 18,
                              text: optionsList[index].toString(),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              );
            } 
            
            
            
            else {
              return const Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(Colors.white),
                ),
              );
            }
















          },
        ),
      )),
    );
  }
}
*/
