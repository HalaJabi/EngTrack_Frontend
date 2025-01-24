import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:front/constants/app_constants.dart';
import 'package:front/constants/theme.dart';
import 'package:front/controllers/login_provider.dart';
import 'package:front/controllers/profile_provider.dart';
import 'package:front/controllers/signup_provider.dart';
import 'package:front/models/profile_model.dart';
import 'package:front/views/common/app_bar.dart';
import 'package:front/views/common/app_style.dart';
import 'package:front/views/common/drawer_widget.dart';
import 'package:front/views/common/height_spacer.dart';
import 'package:front/views/common/reusable_text.dart';
import 'package:front/views/common/width_spacer.dart';
import 'package:front/views/pages/login_sig/login.dart';
import 'package:front/views/pages/profile/profile_eng.dart';
import 'package:front/views/pages/profile/profile_user.dart';
import 'package:front/views/pages/profile/update_com.dart';
import 'package:front/views/pages/profile/update_prof_eng.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../login_sig/page_three.dart';

class company_profile extends StatelessWidget {
  const company_profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

      var loginNotifier =Provider.of<LoginNotifier>(context); //enstance of login notifier

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
                                    Get.to(() => company_PROFILE_update());
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
                          child: Container(
                            
                            padding: EdgeInsets.only(left: 16),
                                 decoration: BoxDecoration(
                                    border: Border.all(color: Color(kOrange.value)  , width: 2,),
                                    borderRadius: BorderRadius.circular(20),
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
                            ),
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
                          child: Container(

                              padding: EdgeInsets.only(left: 16),
                                 decoration: BoxDecoration(
                                    border: Border.all(color: Color(kOrange.value)  , width: 2,),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                //    Icon(Icons.cake),
                                    ReusableText(
                                        text: "About Us:",
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
                            ),
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
                          child: Container(
                              padding: EdgeInsets.only(left: 16),
                                 decoration: BoxDecoration(
                                    border: Border.all(color: Color(kOrange.value)  , width: 2,),
                                    borderRadius: BorderRadius.circular(20),
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
                            ),
                          )),
                   /*   Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ReusableText(
                              text: " Presonal Skilles:",
                              style:
                                  appstyle(16, Colors.black, FontWeight.w600)),
                        ],
                      ),*/
                      SizedBox(height: 20),
                      Container(
                          width: MediaQuery.of(context).size.width,
                          height: 50,
                          decoration: BoxDecoration(
                  //          color: Color(k5
                        //        .value), // Changed color to blue for demonstration
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Container(
                              padding: EdgeInsets.only(left: 16),
                                 decoration: BoxDecoration(
                                    border: Border.all(color: Color(kOrange.value)  , width: 2,),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                            
                            
                            
                                   ReusableText(
                                        text: "Founded:",
                                        style: appstyle(
                                            16,
                                            Color(kDarkGrey.value),
                                            FontWeight.w600)),
                              //  Icon(Icons.star),
                                ReusableText(
                                    text: userData.skills[2],
                                    style: appstyle(
                                        16, Colors.black, FontWeight.w600)),
                              ],
                            ),
                          )),
                      SizedBox(height: 10),
                      Container(
                          width: MediaQuery.of(context).size.width,
                          height: 50,
                          decoration: BoxDecoration(
                          //  color: Color(k5
                            //    .value), // Changed color to blue for demonstration
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Container(
                              padding: EdgeInsets.only(left: 16),
                                 decoration: BoxDecoration(
                                    border: Border.all(color: Color(kOrange.value)  , width: 2,),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                   ReusableText(
                                        text: "Services:",
                                        style: appstyle(
                                            16,
                                            Color(kDarkGrey.value),
                                            FontWeight.w600)),
                            //    Icon(Icons.star),
                                ReusableText(
                                    text: userData.skills[3],
                                    style: appstyle(
                                        16, Colors.black, FontWeight.w600)),
                              ],
                            ),
                          )),
                      SizedBox(height: 10),






                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: 50,
                          decoration: BoxDecoration(
                          //  color: Color(k5
                            //    .value), // Changed color to blue for demonstration
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Container(
                              padding: EdgeInsets.only(left: 16),
                                 decoration: BoxDecoration(
                                    border: Border.all(color: Color(kOrange.value)  , width: 2,),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                   ReusableText(
                                        text: "Website:",
                                        style: appstyle(
                                            16,
                                            Color(kDarkGrey.value),
                                            FontWeight.w600)),
                            //    Icon(Icons.star),
                                ReusableText(
                                    text: userData.skills[4],
                                    style: appstyle(
                                        16, Colors.black, FontWeight.w600)),
                              ],
                            ),
                          )),
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




/*
class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {

    
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.h),
        child: CustomAppBar(
          text: "Profile",
          actions: [
            Padding(
              padding: EdgeInsets.all(12.h),
              
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
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                  return Text("Error ${snapshot.error}");
                } else {















                  final UserData = snapshot.data;

                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: ListView(
                      padding: EdgeInsets.zero,
                      children: [
                        Container(
                          width: width,
                          height: height * 0.12,
                          color: Color(kLight.value),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
ClipRRect(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(20)),
                                      // Fix: Image not loading, somewhere
                                      // the userData.profile is being set to
                                      // the string 'null', this shouldn't be
                                      // the case, make it nullable rather.
                                      // so for now, I'm just checking for 'n
                                      // ull', You should rather make profile
                                      // nullable. I didn't have time to go
                                      // change the profile everywhere and
                                      // correct the backend code or wherever
                                      // it was being set as null
                                      child: UserData!.profile == 'null'
                                          ? Image.asset(
                                              'assets/images/user.png',
                                            )
                                          : CachedNetworkImage(
                                              width: 80.w,
                                              height: 100.h,
                                              imageUrl: UserData.profile,
                                            ),
                                    ),


                                  const WidthSpacer(width: 20),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      ReusableText(
                                          text: UserData!.username,
                                          style: appstyle(
                                              20,
                                              Color(kDark.value),
                                              FontWeight.w600)),
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.location_pin,
                                            color: Color(kDarkGrey.value),
                                          ),
                                          const WidthSpacer(width: 5),
                                          ReusableText(
                                              text: UserData.location,
                                              style: appstyle(
                                                  16,
                                                  Color(kDarkGrey.value),
                                                  FontWeight.w600)),
                                        ],
                                      )
                                    ],
                                  ),
                                ],
                              ),
                              GestureDetector(
                                onTap: () {
                                   profile = UserData.skills;
                                          Get.to(() => ProfileUpdate());
                                },
                                child: const Icon(
                                  Icons.edit,
                                  size: 18,
                                ),
                              )
                            ],
                          ),
                        ),
                        const HeightSpacer(size: 20),
                        Stack(
                          children: [
                            Container(
                              width: width,
                              height: height * 0.12,
                              color: Color(kLightGrey.value),


                      /*        child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [



                                  Container(
                                    margin: EdgeInsets.only(left: 12.w),
                                    width: 60.w,
                                    height: 70.h,
                                    color: Color(kLight.value),
                                    child: const Icon(Icons.picture_as_pdf,
                                        color: Colors.red, size: 40),
                                  ),





                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      ReusableText(
                                          text: "Resume from JobHub",
                                          style: appstyle(
                                              18,
                                              Color(kDark.value),
                                              FontWeight.w500)),
                                      ReusableText(
                                          text: "JobHub Resume",
                                          style: appstyle(
                                              16,
                                              Color(kDarkGrey.value),
                                              FontWeight.w500)),
                                    ],
                                  ),
                                  const WidthSpacer(width: 1)
                                ],
                              ),

*/



                            ),
                            Positioned(
                                top: 2.h,
                                right: 5.w,
                                child: GestureDetector(
                                  onTap: () {},
                                  child: ReusableText(
                                      text: "Edit",
                                      style: appstyle(16, Color(kOrange.value),
                                          FontWeight.w500)),
                                ))
                          ],
                        ),
                        const HeightSpacer(size: 20),
                        Container(
                          padding: EdgeInsets.only(left: 8.w),
                          width: width,
                          height: height * 0.06,
                          color: Color(kLightGrey.value),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: ReusableText(
                                text: UserData.email,
                                style: appstyle(
                                    16, Color(kDark.value), FontWeight.w600)),
                          ),
                        ),
                        const HeightSpacer(size: 20),
                        Container(
                          padding: EdgeInsets.only(left: 8.w),
                          width: width,
                          height: height * 0.06,
                          color: Color(kLightGrey.value),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Row(
                              children: [
                                Icon(
                                  Icons.flag,
                                  size: 20,
                                ),
                                const WidthSpacer(width: 15),
                                ReusableText(
                                    text: UserData.phone,
                                    style: appstyle(16, Color(kDark.value),
                                        FontWeight.w600)),
                              ],
                            ),
                          ),
                        ),
                        const HeightSpacer(size: 20),
                        Container(
                          color: Color(kLightGrey.value),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.all(8.h),
                                child: ReusableText(
                                    text: "Skills",
                                    style: appstyle(16, Color(kDark.value),
                                        FontWeight.w600)),
                              ),
                              const HeightSpacer(size: 3),
                              SizedBox(
                                height: height * 0.5,
                                child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 8.w, vertical: 8.h),
                                    child: ListView.builder(
                                        itemCount: UserData.skills.length,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemBuilder: (context, index) {
                                          String skill = UserData.skills[index];
                                          return Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Container(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 10.w),
                                                width: width,
                                                height: height * 0.06,
                                                color: Color(kLight.value),
                                                child: Row(
                                                  children: [
                                                    ReusableText(
                                                        text: skill,
                                                        style: appstyle(
                                                            16,
                                                            Color(kDark.value),
                                                            FontWeight.normal)),
                                                  ],
                                                )),
                                          );
                                        })),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  );
                }
              });
        },
      ),
    );
  
  }
}


*/
