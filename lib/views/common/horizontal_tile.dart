import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:front/constants/app_constants.dart';
import 'package:front/controllers/book_provider.dart';
import 'package:front/models/request/bookmarks/bookmarks_model.dart';
import 'package:front/models/response/jobs/jobs_response.dart';
import 'package:front/views/common/app_style.dart';

import 'package:front/views/common/height_spacer.dart';
import 'package:front/views/common/reusable_text.dart';
import 'package:front/views/common/width_spacer.dart';
import 'package:front/views/pages/JopPage.dart';
import 'package:front/views/pages/job-details.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class JobHorizontalTile extends StatelessWidget {
  final void Function()? onTap;
  final JobsResponse job;

  const JobHorizontalTile({
    Key? key,
    this.onTap,
    required this.job,
  });

  @override
  Widget build(BuildContext context) {
  
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.only(right: 12.w),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
          width: width * 0.8, //width
          height: height * 0.28, //height

          decoration: BoxDecoration(
            color: Color(k5.value),
            borderRadius: BorderRadius.circular(30), // تطبيق حواف مستديرة
          ),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(job.imageUrl),
                  ),
                  WidthSpacer(width: 15),
                  ReusableText(
                    text: job.company,
                    style: appstyle(20, Color(kDark.value), FontWeight.w600),
                  ),
                ],
              ),
              HeightSpacer(size: 20),
              ReusableText(
                text: job.title,
                style: appstyle(15, Color(kDark.value), FontWeight.w400),
              ),
              HeightSpacer(size: 30),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(
                        Icons.access_time,
                        size: 20,
                      ),
                      ReusableText(
                        text: job.period,
                        style:
                            appstyle(14, Color(kDark.value), FontWeight.w600),
                      ),
                      WidthSpacer(width: 20),
                      Icon(
                        Icons.monetization_on_outlined,
                        size: 20,
                      ),
                      ReusableText(
                        text: job.salary,
                        style:
                            appstyle(20, Color(kDark.value), FontWeight.w600),
                      ),
                      WidthSpacer(width: 20),
                      Icon(
                        Icons.location_on_outlined,
                        size: 20,
                      ),
                      ReusableText(
                        text: job.location,
                        style:
                            appstyle(12, Color(kDark.value), FontWeight.w600),
                      ),
                    ],
                  ),
                  HeightSpacer(size: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Consumer<BookMarkNotifier>(
                          builder: (context, bookMarkNotifier, child) {
                        bookMarkNotifier.loadJobs();

                        return GestureDetector(
                          onTap: () {
                            if (bookMarkNotifier.jobs.contains(job.id)) {
                              bookMarkNotifier.deleteBookMark(job.id);
                            } else {
                              BookmarkReqResModel model =
                                  BookmarkReqResModel(job: job.id);
                              bookMarkNotifier.addBookMark(model, job.id);
                            }
                          },
                          child: Padding(
                              padding: EdgeInsets.only(right: 12.0.w),
                              child: !bookMarkNotifier.jobs.contains(job.id)
                                  ? Icon(Icons.favorite_border)
                                  : Icon(Icons.favorite)),
                        );
                      }),

                      //     Icon(Icons.favorite_border, size: 30),
                      Spacer(),
                      Container(width: 10),
                      ElevatedButton(
                        onPressed: () {
                          Get.to(() => JobDetail(
                                title: job.company,
                                id: job.id,
                              ));
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(kOrange.value),
                          padding: EdgeInsets.all(10),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Text(
                          "Apply Now",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}




/*
class JobHorizontalTile extends StatelessWidget {
  final void Function()? onTap;
  final String imagePath;
  final String companyName;
  final String jobTitle;
  final String jobType;
  final String salary;
  final String location;

  const JobHorizontalTile({
    Key? key,
    this.onTap,
    required this.imagePath,
    required this.companyName,
    required this.jobTitle,
    required this.jobType,
    required this.salary,
    required this.location,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.only(right: 12.w),
        child: Container(
          width: width * 0.7,
          height: height * 0.27,
          decoration: BoxDecoration(
            color: Color(kLightGrey.value),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: Colors.grey[300]!,
              width: 1.0,
            ),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 20,
                      backgroundImage: AssetImage(imagePath),
                    ),
                    WidthSpacer(width: 15),
                    Expanded(
                      child: ReusableText(
                        text: companyName,
                        style: appstyle(20, Color(kDark.value), FontWeight.w600),
                      ),
                    ),
                  ],
                ),
                HeightSpacer(size: 10),
                ReusableText(
                  text: jobTitle,
                  style: appstyle(15, Color(kDark.value), FontWeight.w200),
                ),
                HeightSpacer(size: 5),
                ReusableText(
                  text: jobType,
                  style: appstyle(12, Color(kDark.value), FontWeight.w400),
                ),
                HeightSpacer(size: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ReusableText(
                          text: salary,
                          style: appstyle(20, Color(kDark.value), FontWeight.w600),
                        ),
                        HeightSpacer(size: 5),
                        ReusableText(
                          text: location,
                          style: appstyle(12, Color(kDark.value), FontWeight.w400),
                        ),
                      ],
                    ),
                    ElevatedButton(
                      onPressed: () {
                        // Add your onPressed logic here
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(kOrange.value),
                        padding: EdgeInsets.all(10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(
                        "Apply Now",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
*/

