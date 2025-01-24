import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:front/constants/app_constants.dart';
import 'package:front/models/response/not_get_all.dart';
import 'package:front/models/response/not_res.dart';
import 'package:front/views/common/app_bar.dart';
import 'package:front/views/common/app_style.dart';
import 'package:front/views/common/not_TileWidget.dart';
import 'package:front/views/common/reusable_text.dart';
import 'package:front/views/common/width_spacer.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
/*
class Not_Screen extends StatefulWidget {
  
   final NotGetAll notRes;

  const Not_Screen(this.notRes, {Key? key}) : super(key: key);
  @override
  State<Not_Screen> createState() => _Not_ScreenState();
}

class _Not_ScreenState extends State<Not_Screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: CustomAppBar(
          color: Color(0xFFFAF0E6),
          text: "Notifications",
          child: GestureDetector(
            onTap: () {
              Get.back();
            },
            child: const Icon(CupertinoIcons.arrow_left),
          ),
        ),
      ),
      body: Container(
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
                      backgroundImage: NetworkImage( widget.notRes.adminImage),
                    ),
                    const WidthSpacer(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ReusableText(
                          text: widget.notRes.adminName,
                          style: appstyle(
                            22,
                            Color(kDark.value),
                            FontWeight.w600,
                          ),
                        ),
                        SizedBox(
                          width: width * 0.5,
                          child: ReusableText(
                            text: widget.notRes.createdAt.toString(),
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
           
          ],
        ),
      ),
    );
  }
}
*/


class Not_Screen extends StatefulWidget {
  final List<NotGetAll> notifications;

  const Not_Screen(this.notifications, {Key? key}) : super(key: key);

  @override
  State<Not_Screen> createState() => _Not_ScreenState();
}

class _Not_ScreenState extends State<Not_Screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: CustomAppBar(
          color: const Color(0xFFFAF0E6),
          text: "Notifications",
          child: GestureDetector(
            onTap: () {
              Get.back();
            },
            child: const Icon(CupertinoIcons.arrow_left),
          ),
        ),
      ),
      body: ListView.builder(
        padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 20.w),
        itemCount: widget.notifications.length,
        itemBuilder: (context, index) {
          final notification = widget.notifications[index];
          return Container(
            padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 20.w),
            margin: EdgeInsets.only(bottom: 10.h),
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
                          backgroundImage: NetworkImage(notification.adminImage),
                        ),
                        const WidthSpacer(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ReusableText(
                              text: notification.adminName,
                              style: appstyle(
                                22,
                                Color(kDark.value),
                                FontWeight.w600,
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.5,
                              child: ReusableText(
                                text: notification.createdAt.toString(),
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
              ],
            ),
          );
        },
      ),
    );
  }
}
