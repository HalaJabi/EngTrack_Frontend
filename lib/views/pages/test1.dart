import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:front/helpers/UserManger.dart';
import 'package:front/models/response/jobs/get_job.dart';
import 'package:front/models/response/jobs/jobs_response.dart';
import 'package:front/views/pages/quiz/Add-quiz.dart';
import 'package:front/constants/app_constants.dart';
import 'package:front/controllers/job_provider.dart';
import 'package:front/controllers/login_provider.dart';
import 'package:front/controllers/profile_provider.dart';
import 'package:front/models/profile_model.dart';
import 'package:front/models/request/jobs/cr_job.dart';

import 'package:front/views/common/app_bar.dart';
import 'package:front/views/common/custom_btn.dart';
import 'package:front/views/common/custom_textfield.dart';
import 'package:front/views/common/drawer_widget.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class CreateJob extends StatefulWidget {
  const CreateJob({Key? key}) : super(key: key);

  @override
  State<CreateJob> createState() => _CreateJobState();
}

class _CreateJobState extends State<CreateJob> {
  TextEditingController title = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController salary = TextEditingController();
  TextEditingController requirement = TextEditingController();
  bool full = false;
  bool part = false;

  @override
  void dispose() {
    title.dispose();
    description.dispose();
    salary.dispose();
    requirement.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //var profileNotifier = Provider.of<ProfileNotifier>(context);
    // profileNotifier.getProfile();

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: CustomAppBar(
          color: Color(0xFFFAF0E6),
          text: "Create Job",
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
                    controller: description,
                    hintText: "Description",
                    keyboardType: TextInputType.text,
                    line: 3,
                  ),
                  SizedBox(height: 20),
                  CustomTextField(
                    controller: requirement,
                    hintText: "Requirement",
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
                  Row(
                    children: [
                      Expanded(
                        child: ListTile(
                          title: Text('Full Time'),
                          leading: Radio(
                              value: true,
                              groupValue: full,
                              onChanged: (value) {
                                setState(() {
                                  full = value as bool;
                                  part =
                                      !full; // Set isAgent to the opposite of isAdmin
                                });
                              },
                              activeColor: Color(kOrange.value)),
                        ),
                      ),
                      Expanded(
                        child: ListTile(
                          title: Text('Part Time'),
                          leading: Radio(
                              value: true,
                              groupValue: part,
                              onChanged: (value) {
                                setState(() {
                                  full = !(value
                                      as bool); // Set isAdmin to the opposite of the selected value
                                  part =
                                      !full; // Set isAgent to the opposite of isAdmin
                                });
                              },
                              activeColor: Color(kOrange.value)),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),


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
                                    //  print(userData.id);

                                    if (title.text.isNotEmpty &&
                                        salary.text.isNotEmpty &&
                                        description.text.isNotEmpty) {
                                      CreateJobsRequest model =
                                          CreateJobsRequest(
                                        title: title.text,
                                        company: userData.username,
                                        salary: salary.text,
                                        location: userData.location,
                                        description: description.text,
                                        period: 'monthly',
                                        contract:
                                            full ? "Full Time" : "Part Time",
                                        imageUrl: userData.profile,
                                        adminId: userData.id,
                                        requirements: requirement.text,
                                      );

                                      print(requirement.text);

bool isSuccess = await jobsNotifier.createJob(model);
                                   if( isSuccess==true)  
                                   {
                                     Get.to(
      () => Addquiz(
        jobid:UserManager.back,
      ),
      transition: Transition.fade,
      duration: const Duration(seconds: 2),
    );
                                   } 



                                    

                                      //    Get.to(Addquiz());

                                      // Here you can call a function to submit the job creation request
                                    }
                                  },
                                  text: "Create Job",
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


/*import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:front/Add-quiz.dart';
import 'package:front/constants/app_constants.dart';
import 'package:front/controllers/job_provider.dart';
import 'package:front/controllers/login_provider.dart';
import 'package:front/controllers/profile_provider.dart';
import 'package:front/models/profile_model.dart';
import 'package:front/models/request/jobs/create_job.dart';
import 'package:front/views/common/app_bar.dart';
import 'package:front/views/common/custom_btn.dart';
import 'package:front/views/common/custom_textfield.dart';
import 'package:front/views/common/drawer_widget.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class CreateJob extends StatefulWidget {
  const CreateJob({Key? key}) : super(key: key);

  @override
  State<CreateJob> createState() => _CreateJobState();
}

class _CreateJobState extends State<CreateJob> {
  TextEditingController title = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController salary = TextEditingController();
  TextEditingController requirements = TextEditingController();
  bool full = false;
  bool part = false;

  @override
  void dispose() {
    title.dispose();
    description.dispose();
    salary.dispose();
    requirements.dispose();

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
          text: "Create Job",
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
                    controller: description,
                    hintText: "Description",
                    keyboardType: TextInputType.text,
                    line: 3,
                  ),
                  SizedBox(height: 20),
                  CustomTextField(
                    controller: requirements,
                    hintText: "Requirement",
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
                  Row(
                    children: [
                      Expanded(
                        child: ListTile(
                          title: Text('Full Time'),
                          leading: Radio(
                              value: true,
                              groupValue: full,
                              onChanged: (value) {
                                setState(() {
                                  full = value as bool;
                                  part =
                                      !full; // Set isAgent to the opposite of isAdmin
                                });
                              },
                              activeColor: Color(kOrange.value)),
                        ),
                      ),
                      Expanded(
                        child: ListTile(
                          title: Text('Part Time'),
                          leading: Radio(
                              value: true,
                              groupValue: part,
                              onChanged: (value) {
                                setState(() {
                                  full = !(value
                                      as bool); // Set isAdmin to the opposite of the selected value
                                  part =
                                      !full; // Set isAgent to the opposite of isAdmin
                                });
                              },
                              activeColor: Color(kOrange.value)),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
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
                                    //  print(userData.id);

                                    if (title.text.isNotEmpty &&
                                        salary.text.isNotEmpty &&
                                        description.text.isNotEmpty) {
                                      CreateJobsRequest model =
                                          CreateJobsRequest(
                                        title: title.text,
                                        company: userData.username,
                                        salary: salary.text,
                                        location: userData.location,
                                        description: description.text,
                                        period: 'monthly',
                                        contract:full ? "Full Time" : "Part Time",
                                        imageUrl: userData.profile,
                                        adminId: userData.id,
                                        requirements: requirements.text,
                                      );
print(requirements.text);
                                      print(title.text);
                                      print(userData.username);
                                       print(salary.text);
                                        print(userData.location);


                                         print(description.text);

                                          print( userData.profile);

                                           print(full);
                                            print( userData.id);
                                             


                                      jobsNotifier.createJob(model);

                                      Get.to(Addquiz());

                                      // Here you can call a function to submit the job creation request
                                    }
                                  },
                                  text: "Create Job",
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
*/