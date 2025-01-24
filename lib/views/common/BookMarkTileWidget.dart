import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:front/constants/app_constants.dart';
import 'package:front/constants/theme.dart';
import 'package:front/models/response/bookmarks/all_bookmarks.dart';
import 'package:front/views/common/app_style.dart';
import 'package:front/views/common/reusable_text.dart';
import 'package:front/views/common/width_spacer.dart';
import 'package:front/views/pages/JopPage.dart';
import 'package:front/views/pages/job-details.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';

class BookMarkTileWidget extends StatelessWidget {
  const BookMarkTileWidget({required this.job, super.key});
  final AllBookmark job;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: GestureDetector(
        onTap: () {
  Get.to(() => JobDetail(title: job.job.company, id: job.job.id));


        },
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 20.w),
          height: height * 0.15,
          width: width,
          color: Color(k5.value),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundImage: NetworkImage(job.job.imageUrl),
                      ),
                      const WidthSpacer(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ReusableText(
                            text: job.job.company,
                            style: appstyle(
                              20,
                              Color(kDark.value),
                              FontWeight.w600,
                            ),
                          ),
                          SizedBox(
                            width: width * 0.5,
                            child: ReusableText(
                              text: job.job.title,
                              style: appstyle(
                                14,
                                Color(kDark.value),
                                FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
               Icon(
                      Ionicons.chevron_forward,
                      color: Color(kDark.value),
                    ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 65.w),
                child: Row(
                  children: [
                    ReusableText(
                      text: job.job.salary,
                      style: appstyle(14, Color(kDark.value), FontWeight.w600),
                    ),
                    ReusableText(
                      text: '/${job.job.period}',
                      style: appstyle(
                        14,
                        Color(kDark.value),
                        FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
