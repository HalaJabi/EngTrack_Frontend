
/*

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:front/constants/app_constants.dart';
import 'package:front/controllers/book_provider.dart';
import 'package:front/controllers/job_provider.dart';
import 'package:front/helpers/chat_helper.dart';
import 'package:front/helpers/msg_helper.dart';
import 'package:front/mainscreen.dart';
import 'package:front/models/request/bookmarks/bookmarks_model.dart';
import 'package:front/models/request/chat/create_chat.dart';
import 'package:front/models/request/messaging/send_message.dart';
import 'package:front/models/response/jobs/jobs_response.dart';
import 'package:front/views/common/app_bar.dart';
import 'package:front/views/common/app_style.dart';
import 'package:front/views/common/custom_outline_btn.dart';
import 'package:front/views/common/heading_widget.dart';
import 'package:front/views/common/height_spacer.dart';
import 'package:front/views/common/horizantal_shimmer.dart';
import 'package:front/views/common/reusable_text.dart';
import 'package:front/views/common/width_spacer.dart';
import 'package:front/views/pages/pdf.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:provider/provider.dart';

class JobPage extends StatefulWidget {
  const JobPage({super.key, required this.title, required this.id});

  final String title;
  final String id;

  @override
  State<JobPage> createState() => _JobPageState();
}

class _JobPageState extends State<JobPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<JobsNotifier>(builder: (context, jobsNotifier, child) {
      jobsNotifier.getJob(widget.id);

      return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(50.h),
          child: CustomAppBar(
            text: widget.title,
            child: GestureDetector(
              onTap: () => Get.back(),
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
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Stack(
                  children: [
                    ListView(
                      padding: EdgeInsets.zero,
                      children: [
                        HeightSpacer(size: 30),
                        Row(
                          children: [
                            Container(
                              width: 75,
                              height: 75,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.network(
                                  job!.imageUrl,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            Column(
                              children: [
                                ReusableText(
                                  text: job.company,
                                  style: appstyle(
                                      22, Color(kDark.value), FontWeight.bold),
                                ),
                                ReusableText(
                                  text: job.title,
                                  style: appstyle(
                                      15, Color(kDark.value), FontWeight.w600),
                                ),
                                HeightSpacer(size: 30),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Icon(
                                      Icons.access_time,
                                      size: 20,
                                    ),
                                    ReusableText(
                                      text: job.period,
                                      style: appstyle(14, Color(kDark.value),
                                          FontWeight.w600),
                                    ),
                                    WidthSpacer(width: 20),
                                    Icon(
                                      Icons.monetization_on_outlined,
                                      size: 20,
                                    ),
                                    ReusableText(
                                      text: job.salary,
                                      style: appstyle(14, Color(kDark.value),
                                          FontWeight.w600),
                                    ),
                                    WidthSpacer(width: 20),
                                    Icon(
                                      Icons.location_on_outlined,
                                      size: 20,
                                    ),
                                    ReusableText(
                                      text: job.location,
                                      style: appstyle(12, Color(kDark.value),
                                          FontWeight.w600),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 30),
                        Divider(
                          height: 1,
                          thickness: 5,
                          color: Color(k5.value),
                        ),
                        const HeightSpacer(size: 20),
                        ReusableText(
                            text: "Job Description",
                            style: appstyle(
                                22, Color(kDark.value), FontWeight.w600)),
                        const HeightSpacer(size: 10),
                        Text(
                          job.description,
                          textAlign: TextAlign.justify,
                          maxLines: 8,
                          style: appstyle(
                              16, Color(kDarkGrey.value), FontWeight.normal),
                        ),
                        HeightSpacer(size: 20),
                        ReusableText(
                            text: "Requirments",
                            style: appstyle(
                                22, Color(kDark.value), FontWeight.w600)),
                        const HeightSpacer(size: 10),
                      
                        const HeightSpacer(size: 10),
                        Text(
                          job.requirements,
                          textAlign: TextAlign.justify,
                          maxLines: 8,
                          style: appstyle(
                              16, Color(kDarkGrey.value), FontWeight.normal),
                        ),
                        const HeightSpacer(size: 20),























































                      ],
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 20.h),
                        child: CustomOutlineBtn(
                              onTap: () { Get.to(UploadPDF());}
                        
                            /*
                            showModalBottomSheet(
                              context: context,
                              builder: (BuildContext context) {
                                return InkWell(
                                  onTap: () {
                                    Get.to(UploadPDF());
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Color(k5.value), // إضافة اللون هنا
                                      borderRadius: BorderRadius.circular(15.0),
                                    ),
                                    height: 200,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 20.0),
                                          child: Text(
                                            'Please Upload Your CV',
                                            style: TextStyle(
                                               color: Color(0xffFE7A36),
                                              fontSize: 20.0,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                          Icon(Icons.picture_as_pdf, size: 50, color: Color(0xffFE7A36)), // لون الأيقونة
                                      ],
                                    ), 
                                  ),
                                );
                              },
                            );
                          },
                          */
                          ,color2: Color(kOrange.value),
                          width: width,
                          height: height * 0.06,
                          text: "Apply Now",
                          color: Color(kLight.value),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }
          },
        ),
      );
    });
  }
}*/