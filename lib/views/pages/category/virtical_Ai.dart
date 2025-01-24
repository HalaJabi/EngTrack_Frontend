import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:front/constants/app_constants.dart';
import 'package:front/models/response/Ai_res.dart';

import 'package:front/views/common/app_style.dart';
import 'package:front/views/common/reusable_text.dart';
import 'package:front/views/common/width_spacer.dart';
import 'package:front/views/pages/job-details.dart';
import 'package:front/views/pages/profile/profile_eng.dart';
import 'package:ionicons/ionicons.dart';

class Vertical_Ai extends StatelessWidget {
  const Vertical_Ai({required this.job, super.key, this.onTap});

  final AiRes? job;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
        height: height * 0.15,
        width: width,
        decoration: BoxDecoration(
          color: k5, // لون خلفية البطاقة
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: width * 0.78,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.white, // لون خلفية الصورة
                        radius: 26,
                        //child: Image.network(job!.imageUrl), // اضف صورة هنا إذا كانت متوفرة
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
                                const Color.fromARGB(255, 0, 0, 0), // لون النص
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
                                Colors.grey, // لون النص
                                FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
  
         
    GestureDetector(
      /*
  onTap: () {
    Navigator.push(
     // context,
     // MaterialPageRoute(builder: (context) => ProfilePage()), 
    );
  },*/
  child: CircleAvatar(
    radius: 18,
    backgroundColor: Colors.white, // لون خلفية الزر
    child: const Icon(
      Ionicons.chevron_forward,
      color: Colors.orange, // لون الرمز
    ),
  ),
),

                    ],
                  ),
                ),
              ],
            ),
            
      Padding(
  padding: EdgeInsets.only(left: 0.w),
  child: Row(
    mainAxisAlignment: MainAxisAlignment.start, // تحديد توجيه النص إلى النهاية اليمنى
    children: [
      ReusableText(
        text: job!.salary,
        style: appstyle(
          15,
          const Color.fromARGB(255, 0, 0, 0), // لون النص
          FontWeight.w600,
        ),
      ),
      ReusableText(
        text: '/${job!.period}',
        style: appstyle(
          12,
          const Color.fromARGB(255, 0, 0, 0), // لون النص
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
}