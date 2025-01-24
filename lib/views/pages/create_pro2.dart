

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:front/constants/app_constants.dart';
import 'package:front/controllers/image_provider.dart';
import 'package:front/controllers/job_provider.dart';
import 'package:front/controllers/login_provider.dart';
import 'package:front/controllers/profile_provider.dart';
import 'package:front/models/profile_model.dart';
import 'package:front/models/request/jobs/cre_pro.dart';

import 'package:front/views/common/app_bar.dart';
import 'package:front/views/common/custom_btn.dart';
import 'package:front/views/common/custom_textfield.dart';
import 'package:front/views/common/drawer_widget.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class createjob_2 extends StatefulWidget {
  const createjob_2({Key? key}) : super(key: key);

  @override
  State<createjob_2> createState() => _createjob_2State();
}

class _createjob_2State extends State<createjob_2> {
  TextEditingController title = TextEditingController();
  TextEditingController username = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController salary = TextEditingController();
  TextEditingController requirement = TextEditingController();
  TextEditingController deadline = TextEditingController();

  @override
  void dispose() {
    title.dispose();
    description.dispose();
    salary.dispose();
    requirement.dispose();
    deadline.dispose();
    username.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
     var profileNotifier = Provider.of<ProfileNotifier>(context);
    profileNotifier.getProfile();

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: CustomAppBar(
          color: Color(0xFFFAF0E6),
          text: "Create Project",
          child: GestureDetector(
            onTap: () {
              Get.back();
            },
            child: const Icon(CupertinoIcons.arrow_left),
          ),
        ),
      ),








      body: Consumer<JobsNotifier>(
        builder: (context, jobsNotifier, child) {
          return ListView(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 60),
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 30),
                  CustomTextField(
                    controller: title,
                    hintText: "Title",
                    keyboardType: TextInputType.text,
                  ),




                  SizedBox(height: 10),
                  CustomTextField(
                    controller: username,
                    hintText: "User Name",
                    keyboardType: TextInputType.text,
                   
                  ),






                  SizedBox(height: 20),
                  CustomTextField(
                    controller: description,
                    hintText: "Description",
                    keyboardType: TextInputType.text,
                    line: 3,
                  ),








                  SizedBox(height: 10),
                  CustomTextField(
                    controller: salary,
                    hintText: "Salary",
                    keyboardType: TextInputType.text,
                  ),






                  SizedBox(height: 10),
               




                  SizedBox(height: 10),
                  CustomTextField(
                    controller: requirement,
                    hintText: "Requirement",
                    keyboardType: TextInputType.text,
                  ),

                  
                  SizedBox(height: 10),
                  CustomTextField(
                    controller: deadline,
                    hintText: "Deadline",
                    keyboardType: TextInputType.text,
                  ),

 SizedBox(height: 10),
                  Consumer<ProfileNotifier>(
                    builder: (context, profileNotifier, child) {
                      profileNotifier.getProfile();

                      return FutureBuilder<ProfileRes>(
                        future: profileNotifier.profile,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                                  ConnectionState.waiting ||
                              snapshot.data == null) {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          } else if (snapshot.hasError) {
                            return Center(
                              child: Text("Error ${snapshot.error}"),
                            );
                          } else {
                            final userData = snapshot.data!;
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                
                                CustomButton(
                                  width: 200,
                                  height: 50,
                                  color: Color(kOrange.value),
                                  onTap: () async {
                                    print(userData.id);

                                   if (title.text.isNotEmpty &&
                                        salary.text.isNotEmpty &&
                                        description.text.isNotEmpty) {
                                      ProjectReq model =
                                          ProjectReq(





                                        title: title.text,
                                        username: username.text,
                                        salary: salary.text,
                                        
                                        description: description.text,
                                        
                                      imageUrl  : 'assets/images/pro2.png',
                                        userId: userData.id,
                                        requirements: requirement.text,
                                          deadline: deadline.text,








                                      );


                                      jobsNotifier.createproj(model);
                                  

                                      // Here you can call a function to submit the job creation request
                                 }
                                  },
                                  text: "Create Project",
                                ),
                              ],
                            );
                          }
                        },
                      );
                    },
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );











  }
}
