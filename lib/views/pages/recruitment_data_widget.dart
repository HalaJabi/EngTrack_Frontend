/*

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:front/constants/app_constants.dart';
import 'package:front/controllers/FormJobs_provider.dart';
import 'package:front/controllers/job_provider.dart';
import 'package:front/controllers/profile_provider.dart';
import 'package:front/helpers/UserManger.dart';
import 'package:front/helpers/auth_helper.dart';
import 'package:front/helpers/jop_helper.dart';
import 'package:front/models/profile_model.dart';

import 'package:front/models/response/auth/user.dart';
import 'package:front/views/common/app_bar.dart';
import 'package:front/views/common/drawer_widget.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';

import '../../constants/firebase_api.dart';

class RecruitmentDataWidget extends StatefulWidget {
  @override
  _RecruitmentDataWidgetState createState() => _RecruitmentDataWidgetState();
}

class _RecruitmentDataWidgetState extends State<RecruitmentDataWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: CustomAppBar(
          color: Color(0xFFFAF0E6),
          text: "All applicants",
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
      body: ChangeNotifierProvider<FormNotifier>(
        create: (_) => FormNotifier(), // هنا يتم إنشاء المزود
        child: Consumer<FormNotifier>(
          builder: (context, formNotifier, child) {
            formNotifier.getAllForms(UserManager.userId);
          

            return FutureBuilder(
              future: formNotifier.FormList,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Text("Error ${snapshot.error}");
                } else {
                  final forms = snapshot.data;

                  return SingleChildScrollView(
                    child: Column(
                      children: forms!.map((Form) {
                        return Consumer<JobsNotifier>(
                          builder: (context, jobsNotifier, child) {
                            jobsNotifier.getJob(Form.jobId);

                            return FutureBuilder(
                              future: jobsNotifier.job,
                              builder: (context, jobSnapshot) {
                                if (jobSnapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return const Center(
                                      child: CircularProgressIndicator());
                                } else if (jobSnapshot.hasError) {
                                  return Text("Error ${jobSnapshot.error}");
                                } else {
                                  final job = jobSnapshot.data;

                                  return FutureBuilder<UserModel?>(
                                    future:
                                        AuthHelper.getUserById(Form.agentId),
                                    builder: (context, userSnapshot) {
                                      if (userSnapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        return Center(
                                            child: CircularProgressIndicator());
                                      } else if (userSnapshot.hasError) {
                                        return Center(
                                            child: Text(
                                                "Error ${userSnapshot.error}"));
                                      } else if (userSnapshot.hasData) {
                                        final userData = userSnapshot.data;

                                        print(userData!.username);

                                        return SingleChildScrollView(
                                          scrollDirection: Axis.horizontal,
                                          child: DataTable(
                                            columnSpacing: 20,
                                            columns: [
                                              DataColumn(
                                                  label: tableHeader("Image")),
                                              DataColumn(
                                                  label:
                                                      tableHeader("User Name")),
                                              DataColumn(
                                                  label:
                                                      tableHeader("Job Name")),
                                              DataColumn(
                                                  label:
                                                      tableHeader("View CV")),
                                              DataColumn(
                                                  label: tableHeader("Score")),
                                              DataColumn(
                                                  label: tableHeader(
                                                      "Suitable Score")),
                                              DataColumn(
                                                  label: tableHeader("Accept")),
                                              DataColumn(
                                                  label: tableHeader("Reject")),
                                            ],
                                            rows: [
                                              DataRow(cells: [
                                                DataCell(
                                                  Row(
                                                    children: [
                                                      CircleAvatar(
                                                        radius: 20,
                                                        backgroundColor:
                                                            Color(k5.value),
                                                        child: userData!
                                                                    .profile ==
                                                                null
                                                            ? Image.asset(
                                                                'assets/images/user.png',
                                                                width: 20,
                                                                height: 20,
                                                              )
                                                            : ClipOval(
                                                                child:
                                                                    CachedNetworkImage(
                                                                  imageUrl: userData
                                                                      .profile!,
                                                                  fit: BoxFit
                                                                      .cover,
                                                                ),
                                                              ),
                                                      ),

                                                      SizedBox(width: 10),
                                                      //   Text(userData.username),
                                                      //Text(userData!.username ?? ""),
                                                    ],
                                                  ),
                                                ),
                                                DataCell(
                                                    Text(userData.username)),
                                                DataCell(Text(job!.title)),
                                                //Text(job?.title ?? "")),

                                                DataCell(
                                                  InkWell(
                                                    onTap: () {
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) =>
                                                              PdfViewerScreen(
                                                            pdfUrl: Form.cv,
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                    child: Text(
                                                      "View Cv",
                                                      style: TextStyle(
                                                          color: Colors.blue),
                                                    ),
                                                  ),
                                                ),

                                                DataCell(Text(Form.score)),

                                                DataCell(Text(Form.similarity)),
                                                DataCell(
                                                  IconButton(
                                                    icon: Icon(Icons.check,
                                                        color: Colors.green),
                                                    onPressed: () {
                                                      PushNotificationService
                                                          .sendNotificationToSelectedDriver(
                                                              "eTInTKvSR3WJHYCTPyN5FU:APA91bG5ibY9BA2jsXDYIa5kKlHXs1Kn3tCmsvNMXx7BbbXJsfcv9Oo96Ozpz8saVHpJku4FV0y62SCjaKr4HkSW0SuiEUl1DtSrRzv-xk1dvbFPr_AoiSCu_X-trzUyBH2JhsfnsNod");

                                                      jobsNotifier
                                                          .addMemberToJob(
                                                              job.id,
                                                              userData.id);

                                                      // Add logic for acceptance
                                                    },
                                                  ),
                                                ),

                                                DataCell(
                                                  IconButton(
                                                    icon: Icon(Icons.close,
                                                        color: Colors.red),
                                                    onPressed: () {
                                                      // Add logic for rejection
                                                    },
                                                  ),
                                                ),
                                              ]),
                                            ],
                                          ),
                                        );
                                      } else {
                                        return Container();
                                      }
                                    },
                                  );
                                }
                              },
                            );
                          },
                        );
                      }).toList(),
                    ),
                  );
                }
              },
            );
          },
        ),
      ),
    );
  }

  Widget tableHeader(String text) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 15),
      child: Text(
        text,
        style: TextStyle(fontWeight: FontWeight.bold, color: AppColor.black),
      ),
    );
  }
}

class PdfViewerScreen extends StatelessWidget {
  final String pdfUrl;

  PdfViewerScreen({required this.pdfUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("PDF Viewer"),
      ),
      body: PDFView(
        filePath: pdfUrl,
      ),
    );
  }
}*/

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:front/constants/app_constants.dart';
import 'package:front/controllers/FormJobs_provider.dart';
import 'package:front/controllers/job_provider.dart';
import 'package:front/controllers/profile_provider.dart';
import 'package:front/helpers/UserManger.dart';
import 'package:front/helpers/auth_helper.dart';
import 'package:front/helpers/jop_helper.dart';
import 'package:front/helpers/notification.dart';
import 'package:front/models/profile_model.dart';
import 'package:front/models/request/not_req.dart';

import 'package:front/models/response/auth/user.dart';
import 'package:front/views/common/app_bar.dart';
import 'package:front/views/common/drawer_widget.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';

import '../../constants/firebase_api.dart';

class RecruitmentDataWidget extends StatefulWidget {
  @override
  _RecruitmentDataWidgetState createState() => _RecruitmentDataWidgetState();
}

class _RecruitmentDataWidgetState extends State<RecruitmentDataWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: CustomAppBar(
          color: Color(0xFFFAF0E6),
          text: "All applicants",
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
      body: ChangeNotifierProvider<FormNotifier>(
        create: (_) => FormNotifier(), // هنا يتم إنشاء المزود
        child: Consumer<FormNotifier>(
          builder: (context, formNotifier, child) {
       formNotifier.getAllForms(UserManager.userId);

 //formNotifier.getAllForms("66655675eca244064fd0ba35");
            return FutureBuilder(
              future: formNotifier.FormList,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Text("Error ${snapshot.error}");
                } else {
                  final forms = snapshot.data;

                  if (forms == null || forms.isEmpty) {
                    return Center(child: Text("No applications available."));
                  }

                  return SingleChildScrollView(
                    child: Column(
                      children: forms!.map((Form) {
                        return Consumer<JobsNotifier>(
                          builder: (context, jobsNotifier, child) {
                            jobsNotifier.getJob(Form.jobId);

                            return FutureBuilder(
                              future: jobsNotifier.job,
                              builder: (context, jobSnapshot) {
                                if (jobSnapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return const Center(
                                      child: CircularProgressIndicator());
                                } else if (jobSnapshot.hasError) {
                                  return Text("Error ${jobSnapshot.error}");
                                } else {
                                  final job = jobSnapshot.data;

                                  return FutureBuilder<UserModel?>(
                                    future:
                                        AuthHelper.getUserById(Form.agentId),
                                    builder: (context, userSnapshot) {
                                      if (userSnapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        return Center(
                                            child: CircularProgressIndicator());
                                      } else if (userSnapshot.hasError) {
                                        return Center(
                                            child: Text(
                                                "Error ${userSnapshot.error}"));
                                      } else if (userSnapshot.hasData) {
                                        final userData = userSnapshot.data;

                                        print(userData!.username);

                                        return SingleChildScrollView(
                                          scrollDirection: Axis.horizontal,
                                          child: DataTable(
                                            columnSpacing: 20,
                                            columns: [
                                              DataColumn(
                                                  label: tableHeader("Image")),
                                              DataColumn(
                                                  label:
                                                      tableHeader("User Name")),
                                              DataColumn(
                                                  label:
                                                      tableHeader("Job Name")),
                                              DataColumn(
                                                  label:
                                                      tableHeader("View CV")),
                                              DataColumn(
                                                  label: tableHeader("Score")),
                                              DataColumn(
                                                  label: tableHeader(
                                                      "Suitable Score")),
                                              DataColumn(
                                                  label: tableHeader("Accept")),
                                              DataColumn(
                                                  label: tableHeader("Reject")),
                                            ],
                                            rows: [
                                              DataRow(cells: [
                                                DataCell(
                                                  Row(
                                                    children: [
                                                      CircleAvatar(
                                                        radius: 20,
                                                        backgroundColor:
                                                            Color(k5.value),
                                                        child: userData!
                                                                    .profile ==
                                                                null
                                                            ? Image.asset(
                                                                'assets/images/user.png',
                                                                width: 20,
                                                                height: 20,
                                                              )
                                                            : ClipOval(
                                                                child:
                                                                    CachedNetworkImage(
                                                                  imageUrl: userData
                                                                      .profile!,
                                                                  fit: BoxFit
                                                                      .cover,
                                                                ),
                                                              ),
                                                      ),

                                                      SizedBox(width: 10),
                                                      //   Text(userData.username),
                                                      //Text(userData!.username ?? ""),
                                                    ],
                                                  ),
                                                ),
                                                DataCell(
                                                    Text(userData.username)),
                                                DataCell(Text(job!.title)),
                                                //Text(job?.title ?? "")),

                                                DataCell(
                                                  InkWell(
                                                    onTap: () {
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) =>
                                                              PdfViewerScreen(
                                                            pdfUrl: Form.cv,
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                    child: Text(
                                                      "View Cv",
                                                      style: TextStyle(
                                                          color: Colors.blue),
                                                    ),
                                                  ),
                                                ),

                                                DataCell(Text(Form.score)),

                                                DataCell(Text(Form.similarity)),
                                                DataCell(
                                                  IconButton(
                                                    icon: Icon(Icons.check,
                                                        color: Colors.green),
                                                    onPressed: () {
                                                      PushNotificationService
                                                          .sendNotificationToSelectedDriver(
                                                              "eTInTKvSR3WJHYCTPyN5FU:APA91bG5ibY9BA2jsXDYIa5kKlHXs1Kn3tCmsvNMXx7BbbXJsfcv9Oo96Ozpz8saVHpJku4FV0y62SCjaKr4HkSW0SuiEUl1DtSrRzv-xk1dvbFPr_AoiSCu_X-trzUyBH2JhsfnsNod"
                                                              ,""

                                                              ,""
                                                              
                                                              );

                                                      jobsNotifier
                                                          .addMemberToJob(
                                                              job.id,
                                                              userData.id);



  NotReq not = NotReq(
                          adminId: job.adminId, userId: userData.id, adminName: job.title, userName: userData.username, adminImage: job.imageUrl);






                                                      Not_Helper.create_not(
                                                          not);

                                                      formNotifier.deleteform2(
                                                          Form.id,
                                                          UserManager.userId);

                                                      // Add logic for acceptance
                                                    },
                                                  ),
                                                ),

                                                DataCell(
                                                  IconButton(
                                                    icon: Icon(Icons.close,
                                                        color: Colors.red),
                                                    onPressed: () {


                  PushNotificationService
                                                          .sendNotificationToSelectedDriver(
                                                              "eTInTKvSR3WJHYCTPyN5FU:APA91bG5ibY9BA2jsXDYIa5kKlHXs1Kn3tCmsvNMXx7BbbXJsfcv9Oo96Ozpz8saVHpJku4FV0y62SCjaKr4HkSW0SuiEUl1DtSrRzv-xk1dvbFPr_AoiSCu_X-trzUyBH2JhsfnsNod"
                                                              ,""

                                                              ,""
                                                              
                                                              );

                                                      formNotifier.deleteform(
                                                          Form.id,
                                                          UserManager.userId);


                                                            NotReq not = NotReq(
                          adminId: job.adminId, userId: userData.id, adminName: job.title, userName: userData.username, adminImage: job.imageUrl);


                                                      Not_Helper.create_not(
                                                          not);


                                                      // Add logic for rejection
                                                    },
                                                  ),
                                                ),
                                              ]),
                                            ],
                                          ),
                                        );
                                      } else {
                                        return Container();
                                      }
                                    },
                                  );
                                }
                              },
                            );
                          },
                        );
                      }).toList(),
                    ),
                  );
                }
              },
            );
          },
        ),
      ),
    );
  }

  Widget tableHeader(String text) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 15),
      child: Text(
        text,
        style: TextStyle(fontWeight: FontWeight.bold, color: AppColor.black),
      ),
    );
  }
}

class PdfViewerScreen extends StatelessWidget {
  final String pdfUrl;

  PdfViewerScreen({required this.pdfUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("PDF Viewer"),
      ),
      body: PDFView(
        filePath: pdfUrl,
      ),
    );
  }
}
