import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:front/constants/app_constants.dart';
import 'package:front/controllers/book_provider.dart';
import 'package:front/models/request/bookmarks/bookmarks_model.dart';
import 'package:front/models/response/jobs/jobs_response.dart';
import 'package:front/models/response/jobs/pro_res.dart';
import 'package:front/views/common/app_style.dart';

import 'package:front/views/common/height_spacer.dart';
import 'package:front/views/common/reusable_text.dart';
import 'package:front/views/common/width_spacer.dart';

import 'package:front/views/pages/job-details.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class proHorizontalTile extends StatelessWidget {
  final void Function()? onTap;
  final ProResponse pro;

  const proHorizontalTile({
    Key? key,
    this.onTap,
     required this.pro,
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
  backgroundImage: AssetImage("assets/images/pro2.png"),
),

                  WidthSpacer(width: 15),
                  ReusableText(
                    text: pro.username,
                    style: appstyle(20, Color(kDark.value), FontWeight.w600),
                  ),
                ],
              ),
              HeightSpacer(size: 20),
              ReusableText(
                text: pro.title,
                style: appstyle(15, Color(kDark.value), FontWeight.w400),
              ),
              HeightSpacer(size: 30),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                     
                      WidthSpacer(width: 20),
                      Icon(
                        Icons.monetization_on_outlined,
                        size: 20,
                      ),
                      ReusableText(
                        text: pro.salary,
                        style:
                            appstyle(20, Color(kDark.value), FontWeight.w600),
                      ),
                      WidthSpacer(width: 20),
                      Icon(
                        Icons.location_on_outlined,
                        size: 20,
                      ),
                      ReusableText(
                        text: "remotely",
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
                    if (bookMarkNotifier.jobs.contains(pro.id)) {
                      bookMarkNotifier.deleteBookMark(pro.id);
                
                    } else {
                      BookmarkReqResModel model = BookmarkReqResModel(job: pro.id);
                      bookMarkNotifier.addBookMark(model, pro.id);
                    }
                  },
                  child: Padding(
                      padding: EdgeInsets.only(right: 12.0.w),
                      child: !bookMarkNotifier.jobs.contains(pro.id)
                          ? Icon(Icons.favorite_border)
                          : Icon(Icons.favorite)),
                );
              }),




                 //     Icon(Icons.favorite_border, size: 30),
                      Spacer(),
                      Container(width: 10),
                      ElevatedButton(
                        onPressed: () {
                          Get.to(() =>JobDetail(title: pro.username, id: pro.id,));
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

