
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:front/constants/app_constants.dart';
import 'package:front/views/common/app_style.dart';

import 'package:front/views/common/height_spacer.dart';
import 'package:front/views/common/reusable_text.dart';
import 'package:front/views/common/width_spacer.dart';
class JobHorizontalTile_2 extends StatelessWidget {
  final void Function()? onTap;
  final String imagePath;
  final String companyName;
  final String jobTitle;
  final String salary;
  final String location;


  const JobHorizontalTile_2({
    Key? key,
    this.onTap,
    required this.imagePath,
    required this.companyName,
    required this.jobTitle,
    required this.salary,
    required this.location,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.only(left: 12.w),
        child: Transform.scale(
          scale: 0.8, // تعيين العامل لتحديد حجم GestureDetector
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
            width: width * 0.8, //width
            height: height * 0.28, //height
            decoration: BoxDecoration(
              color: Color(k5.value),
              borderRadius: BorderRadius.circular(30),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: AssetImage(imagePath),
                    ),
                    WidthSpacer(width: 15),
                    ReusableText(
                      text: companyName,
                      style: appstyle(20, Color(kDark.value), FontWeight.w600),
                    ),
                  ],
                ),
                HeightSpacer(size: 20),
                ReusableText(
                  text: jobTitle,
                  style: appstyle(15, Color(kDark.value), FontWeight.w400),
                ),
                HeightSpacer(size: 30),
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        WidthSpacer(width: 20),
                        Icon(Icons.monetization_on_outlined, size: 20),
                        ReusableText(
                          text: salary,
                          style: appstyle(20, Color(kDark.value), FontWeight.w600),
                        ),
                        WidthSpacer(width: 20),
                        Icon(Icons.location_on_outlined, size: 20),
                        ReusableText(
                          text: location,
                          style: appstyle(12, Color(kDark.value), FontWeight.w600),
                        ),
                      ],
                    ),
                    HeightSpacer(size: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Icon(Icons.favorite_border, size: 30),
                        Spacer(),
                        Container(width: 10),
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
      ),
    );
  }
}


