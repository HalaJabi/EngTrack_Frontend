import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:front/constants/app_constants.dart';
import 'package:front/constants/theme.dart';
import 'package:front/models/response/jobs/jobs_response.dart';
import 'package:front/views/common/app_style.dart';
import 'package:front/views/common/reusable_text.dart';
import 'package:front/views/common/width_spacer.dart';
import 'package:ionicons/ionicons.dart';
/*
class virticaltitle extends StatelessWidget {
  const virticaltitle({super.key, this.onTap, required this.job});
  final void Function()? onTap;
  final JobsResponse job;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
          height: height * 0.15,
          width: width,
          color: Color(k5.value),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: Color(kLightGrey.value),
                        radius: 30,
                        backgroundImage:NetworkImage(job!.imageUrl),
                      ),
                      WidthSpacer(width: 10),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ReusableText(
                            text: job!.company,
                            style: appstyle(
                                20, Color(kDark.value), FontWeight.w600),
                          ),
                          SizedBox(
                            width: width * 0.5,
                            child: ReusableText(
                              text: job!.title,
                              style: appstyle(
                                  18, Color(kDark.value), FontWeight.w600),
                            ),
                          ),
                        ],
                      ),
                      CircleAvatar(
                        radius: 18,
                        backgroundColor: Color(kLight.value),
                        child: Icon(Ionicons.chevron_forward),
                      )
                    ],
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 12.w),
                child: Row(
                  children: [
                    ReusableText(
                        text: job!.salary,
                        style:
                            appstyle(23, Color(kDark.value), FontWeight.w600)),
                    ReusableText(
                        text:job!.period,
                        style: appstyle(
                            23, Color(kDarkGrey.value), FontWeight.w600)),
                  ],
                ),
              )
            ],
          ),
        ));
  }
}*/

import 'package:intl/intl.dart';

class VerticalTile extends StatelessWidget {
  const VerticalTile({required this.job, super.key, this.onTap});

  final JobsResponse? job;

  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
     //   height: height * 0.15,
       // width: width,
        decoration: BoxDecoration(
          color: Color(k5.value),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Fix: added this to remove "RenderFlex children have non-zero flex but incoming width constraints are unbounded."
                SizedBox(
                 width: width * 0.78,
                  child: Row(
                    // Fix: added this to remove "RenderFlex children have non-zero flex but incoming width constraints are unbounded."
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CircleAvatar(
                        backgroundColor: Color(k5.value),
                        radius: 25,
                        backgroundImage: NetworkImage(job!.imageUrl),
                      ),
                      const WidthSpacer(width: 20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: width * 0.5,
                            child: ReusableText(
                              text: job!.company,
                              style: appstyle(
                                16,
                                Color(kDark.value),
                                FontWeight.w600,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: width * 0.5,
                            child: ReusableText(
                              text: job!.title,
                              style: appstyle(
                                16,
                                Color(kDarkGrey.value),
                                FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                      CircleAvatar(
                        radius: 18,
                        backgroundColor: Color(kLight.value),
                        child: const Icon(Ionicons.chevron_forward),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(left: 0.w),
              child: Column(
                children: [
                  Row(
                    children: [
                      ReusableText(
                        text: job!.salary,
                        style: appstyle(15, Color(kDark.value), FontWeight.w600),
                      ),
                      ReusableText(
                        text: '/${job!.period}',
                        style: appstyle(
                          20,
                          Color(kDarkGrey.value),
                          FontWeight.w600,
                        ),
                      ),
                  
                      
                    ],
                  ),


                   ReusableText(
                    text:  _formatPostTime(job!.createdAt),
                    style: appstyle(
                      20,
                      Color(kDarkGrey.value),
                      FontWeight.w600,
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
 String _formatPostTime(DateTime createdAt) {
  final now = DateTime.now();
  final difference = now.difference(createdAt);

  if (difference.inSeconds < 60) {
    return 'moments ago';
  } else if (difference.inMinutes < 60) {
    return '${difference.inMinutes} minutes ago';
  } else if (difference.inHours < 24) {
    return '${difference.inHours} hours ago';
  } else {
    final formatter = DateFormat('dd/MM/yyyy');
    return 'Posted on ${formatter.format(createdAt)}';
  }
}


}

