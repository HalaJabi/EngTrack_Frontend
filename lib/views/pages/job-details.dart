import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:front/constants/app_constants.dart';
import 'package:front/constants/chat_api.dart';
import 'package:front/controllers/job_provider.dart';
import 'package:front/helpers/UserManger.dart';
import 'package:front/helpers/auth_helper.dart';
import 'package:front/helpers/chat_helper.dart';
import 'package:front/helpers/config.dart';
import 'package:front/helpers/msg_helper.dart';
import 'package:front/mainscreen.dart';
import 'package:front/models/chatm.dart';
import 'package:front/models/msg_model.dart';
import 'package:front/models/request/chat/create_chat.dart';
import 'package:front/models/request/messaging/send_message.dart';
import 'package:front/models/response/auth/user.dart';
import 'package:front/views/common/app_bar.dart';
import 'package:front/views/common/app_style.dart';
import 'package:front/views/common/custom_outline_btn.dart';
import 'package:front/views/common/height_spacer.dart';
import 'package:front/views/common/reusable_text.dart';
import 'package:front/views/common/width_spacer.dart';
import 'package:front/views/pages/pdf.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class JobDetail extends StatelessWidget {
  const JobDetail({Key? key, required this.title, required this.id})
      : super(key: key);

  final String title;
  final String id;

  @override
  Widget build(BuildContext context) {
    Future<void> createUser(ChatUser model) async {
      return await Config.firestore
          .collection('users')
          .doc(model.id)
          .set(model.toJson());
    }

    Future<bool> userExists(ChatUser model) async {
      return (await Config.firestore.collection('users').doc(model.id).get())
          .exists;
    }

    int adminId;
    return Consumer<JobsNotifier>(
      builder: (context, jobsNotifier, child) {
        jobsNotifier.getJob(id);

        return Scaffold(
          backgroundColor: Color(0xFFF6F6F6),
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(50),
            child: CustomAppBar(
              color: Color(0xFFFAF0E6),
              text: "Job Details",
              child: GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: const Icon(CupertinoIcons.arrow_left),
              ),
            ),
          ),
          body: FutureBuilder(
            future: jobsNotifier.job,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Text("Error ${snapshot.error}");
              } else {
                final job = snapshot.data;

                UserManager.setjobDetails(id: job!.adminId);
                UserManager.setjobDetails(id: job!.id);

                UserManager.setrequirements(requirements1: job!.requirements);
                UserManager.setdescription(description1: job!.description);

                UserManager.setadmainId(id: job.adminId);

                print(job!.id);

                return DefaultTabController(
                  length: 2,
                  child: Container(
                    width: double.infinity,
                    padding:
                        EdgeInsets.symmetric(horizontal: 18.0, vertical: 15.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40.0),
                        topRight: Radius.circular(40.0),
                      ),
                    ),
                    child: Column(
                      children: <Widget>[
                        Container(
                          child: Column(
                            children: <Widget>[
                              Container(
                                width: 75,
                                height: 75,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.network(
                                    job.imageUrl,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Column(
                                children: [
                                  ReusableText(
                                    text: job.company,
                                    style: appstyle(22, Color(kDark.value),
                                        FontWeight.bold),
                                  ),
                                  ReusableText(
                                    text: job.title,
                                    style: appstyle(15, Color(kDark.value),
                                        FontWeight.w600),
                                  ),
                                  HeightSpacer(size: 30),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Icon(Icons.access_time, size: 20),
                                      ReusableText(
                                        text: job.period,
                                        style: appstyle(14, Color(kDark.value),
                                            FontWeight.w600),
                                      ),
                                      WidthSpacer(width: 20),
                                      Icon(Icons.monetization_on_outlined,
                                          size: 20),
                                      ReusableText(
                                        text: job.salary,
                                        style: appstyle(14, Color(kDark.value),
                                            FontWeight.w600),
                                      ),
                                      WidthSpacer(width: 20),
                                      Icon(Icons.location_on_outlined,
                                          size: 20),
                                      ReusableText(
                                        text: job.location,
                                        style: appstyle(12, Color(kDark.value),
                                            FontWeight.w600),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(height: 30.0),
                              Material(
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12.0),
                                  side: BorderSide(
                                    color: Color(kOrange.value).withOpacity(.2),
                                  ),
                                ),
                                child: TabBar(
                                  unselectedLabelColor: Color(kDark.value),
                                  indicator: BoxDecoration(
                                    color: k5,
                                    borderRadius: BorderRadius.circular(12.0),
                                  ),
                                  indicatorSize: TabBarIndicatorSize.tab,
                                  tabs: [
                                    Tab(text: "Description"),
                                    Tab(text: "Requirements"),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 10.0),
                        Expanded(
                          child: TabBarView(
                            children: [
                              Container(
                                child: ListView(
                                  children: <Widget>[
                                    ReusableText(
                                      text: "Job Description",
                                      style: appstyle(14, Color(kDark.value),
                                          FontWeight.bold),
                                    ),
                                    const HeightSpacer(size: 10),
                                    Text(
                                      job.description,
                                      textAlign: TextAlign.justify,
                                      style: appstyle(
                                          16,
                                          Color(kDarkGrey.value),
                                          FontWeight.normal),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                child: ListView(
                                  children: <Widget>[
                                    ReusableText(
                                      text: "Job Requirements",
                                      style: appstyle(14, Color(kDark.value),
                                          FontWeight.bold),
                                    ),
                                    const HeightSpacer(size: 10),
                                    Text(
                                      job.requirements,
                                      textAlign: TextAlign.justify,
                                      style: appstyle(
                                          16,
                                          Color(kDarkGrey.value),
                                          FontWeight.normal),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }
            },
          ),
          bottomNavigationBar: PreferredSize(
            preferredSize: Size.fromHeight(60.0),
            child: Container(
              padding: EdgeInsets.only(left: 18.0, bottom: 25.0, right: 18.0),
              color: Colors.white,
              child: SizedBox(
                height: 50.0,
                child: Row(
                  children: [
                    CustomOutlineBtn(
                      borderRadius: 10.0,
                      onTap: () {
                        Get.to(UploadPDF());
                      },
                      color2: Color(kOrange.value),
                      width: 340,
                      height: 50,
                      text: "Apply Now",
                      color: Color(kLight.value),
                    ),
                    SizedBox(width: 10),
                    FloatingActionButton(
                      onPressed: () async {
                        if (await userExists(UserManager.model) == false) {
                          createUser(UserManager.model);
                        }

                        UserModel? us =
                            await AuthHelper.getUserById(UserManager.admainId);

                        print(us!.email);

                        ChatUser model = ChatUser(
                            id: us.id,
                            name: us.username,
                            email: us.email,
                            image: us.profile,
                            createdAt: " ",
                            isOnline: false,
                            lastActive: "",
                            pushToken: "");

                        if (await userExists(model) == false) {
                          createUser(model);
                        }
                        APIs.sendMessage(
                            model, "Hello, I'm interested in ", Type.text);
                      },
                      backgroundColor: Color(kOrange.value),
                      child: Icon(Icons.chat),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
