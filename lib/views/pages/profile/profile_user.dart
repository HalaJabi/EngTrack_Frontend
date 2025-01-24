import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:front/constants/app_constants.dart';

import 'package:front/controllers/login_provider.dart';
import 'package:front/controllers/profile_provider.dart';
import 'package:front/controllers/signup_provider.dart';
import 'package:front/models/profile_model.dart';
import 'package:front/views/common/app_bar.dart';
import 'package:front/views/common/app_style.dart';
import 'package:front/views/common/drawer_widget.dart';

import 'package:front/views/common/reusable_text.dart';
import 'package:front/views/common/width_spacer.dart';

import 'package:front/views/pages/profile/update_com.dart';
import 'package:front/views/pages/profile/update_user.dart';

import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../login_sig/page_three.dart';

class user_profile extends StatelessWidget {
  const user_profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
      var loginNotifier =Provider.of<LoginNotifier>(context); 
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.h),
        child: CustomAppBar(
          text: "Profile",
          actions: [
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.all(12.h),
                ),
                GestureDetector(
                  onTap: () {
                  loginNotifier.logout();
                  },
                  child: const Icon(
                    Icons.logout,
                    size: 20,
                  ),
                )
              ],
            )
          ],
          child: Padding(
            padding: EdgeInsets.all(12.0.h),
            child: const DrawerWidget(),
          ),
        ),
      ),



















      body: Consumer<ProfileNotifier>(
        builder: (context, profileNotifier, child) {
          profileNotifier.getProfile();

          return FutureBuilder<ProfileRes>(
            future: profileNotifier.profile,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text("Error ${snapshot.error}"),
                );
              } else {
                final userData = snapshot.data;





                return Container(
                  color: Colors.white,
                  child: Column(
                    children: [


                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 200,
                        decoration: BoxDecoration(
                          color: Color(kOrange.value), // Changed color to blue for demonstration
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CircleAvatar(
                                  radius: 60,
                                  backgroundColor: Color(k5.value),
                                  child: userData!.profile == null
                                      ? Image.asset(
                                          'assets/images/user.png',
                                          width: 80,
                                          height: 100,
                                        )
                                      : ClipOval(
                                          child: CachedNetworkImage(
                                            width: 100,
                                            height: 100,
                                            imageUrl: userData.profile!,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    profile = userData.skills;
                                    Get.to(() => update_user());
                                  },
                                  child: const Icon(
                                    Icons.edit,
                                    size: 20,
                                  ),
                                )
                              ],
                            ),
                            ReusableText(
                                text: userData.username,
                                style: appstyle(
                                    18, Color(kDark.value), FontWeight.bold)),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.location_pin,
                                  color: Color(k5.value),
                                ),
                                const WidthSpacer(width: 5),
                                ReusableText(
                                    text: userData.location,
                                    style: appstyle(16, Color(k5.value),
                                        FontWeight.w600)),
                              ],
                            ),
                          ],
                        ),
                      ),






























                      SizedBox(height: 20),
                    /*  Row(   mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ReusableText(
                              text: " Presonal Infomation:",
                              style:
                                  appstyle(16, Colors.black, FontWeight.w600)),
                        ],
                      ),*/
                      SizedBox(height: 30),
                      Container(
                          width: MediaQuery.of(context).size.width,
                          height: 80,
                          decoration: BoxDecoration(
                         ///   color: Color(k5.value), // Changed color to blue for demonstration
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                //  Icon(Icons.phone),
                                  ReusableText(
                                      text: "Phone Number:",
                                      style: appstyle(
                                          16,
                                          Color(kDarkGrey.value),
                                          FontWeight.w600)),
                                ],
                              ),
                              SizedBox(height: 10),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  ReusableText(
                                      text: userData.phone,
                                      style: appstyle(
                                          16, Colors.black, FontWeight.w600)),
                                ],
                              ),
                            ],
                          )),
                      SizedBox(height: 10),
                      Container(
                          width: MediaQuery.of(context).size.width,
                          height: 80,
                          decoration: BoxDecoration(
                          //  color: Color(k5
                        //        .value), // Changed color to blue for demonstration
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                              //    Icon(Icons.cake),
                                  ReusableText(
                                      text: "About Me:",
                                      style: appstyle(
                                          16,
                                          Color(kDarkGrey.value),
                                          FontWeight.w600)),
                                ],
                              ),
                              SizedBox(height: 10),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  ReusableText(
                                      text: userData.skills[0],
                                      style: appstyle(
                                          16, Colors.black, FontWeight.w600)),
                                ],
                              ),
                            ],
                          )),
                      SizedBox(height: 10),
                      Container(
                          width: MediaQuery.of(context).size.width,
                          height: 80,
                          decoration: BoxDecoration(
                       //     color: Color(k5
                             //   .value), // Changed color to blue for demonstration
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                //  Icon(Icons.book),
                                  ReusableText(
                                      text: "Specialties:",
                                      style: appstyle(
                                          16,
                                          Color(kDarkGrey.value),
                                          FontWeight.w600)),
                                ],
                              ),
                              SizedBox(height: 10),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  ReusableText(
                                      text: userData.skills[1],
                                      style: appstyle(
                                          16, Colors.black, FontWeight.w600)),
                                ],
                              ),
                            ],
                          )),
                  
               
                      SizedBox(height: 10),






                    ],
                  ),
                );
              }
            },
          );
        },
      ),
    );
  }
}