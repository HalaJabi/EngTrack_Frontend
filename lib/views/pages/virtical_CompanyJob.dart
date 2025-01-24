import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:front/constants/app_constants.dart';
import 'package:front/models/myjob-res.dart';

import 'package:front/views/common/app_style.dart';
import 'package:front/views/common/reusable_text.dart';
import 'package:ionicons/ionicons.dart';

class virtical_CompanyJob extends StatefulWidget {
  const virtical_CompanyJob({required this.job, super.key, this.onTap});

  final MyjobRes? job;
  final void Function()? onTap;

  @override
  _virtical_CompanyJobState createState() => _virtical_CompanyJobState();
}

class _virtical_CompanyJobState extends State<virtical_CompanyJob> {
  bool isDetailsVisible = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isDetailsVisible = !isDetailsVisible;
        });
        widget.onTap?.call();
      },
      
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
        height: height * 0.1,    
        width: width,
        decoration: BoxDecoration(
          color: Color(0xFFFAF0E6),
          //Colors.grey[200],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ReusableText(
                         text: widget.job!.title,
                          style: appstyle(
                            20,
                            const Color.fromARGB(255, 0, 0, 0),
                            FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                GestureDetector(
  onTap: () {
    setState(() {
      isDetailsVisible = !isDetailsVisible;
    });
    widget.onTap?.call();
  },
  child: Row(
    children: [
      Container(
        padding: EdgeInsets.all(6),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Color(0xFFFAF0E6),
          border: Border.all(
            color: Color(0xFFFAF0E6),
            width: 2,
          ),
        ),
        child: Icon(
          Ionicons.eye,
          color: Colors.grey[600],
        ),
      ),
      SizedBox(width: 10),  
    
    ],
  ),
),

                ],
              ),
            ),
            if (isDetailsVisible)
              Padding(
                padding: EdgeInsets.only(left: 0.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    ReusableText(
                      text: 'salary: ${widget.job!.salary}',
                      style: appstyle(
                        16,
                        Colors.black,
                        FontWeight.w600,
                      ),
                    ),
                    ReusableText(
                      text: ' / period: ${widget.job!.period}',
                      style: appstyle(
                        14,
                        Colors.black,
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