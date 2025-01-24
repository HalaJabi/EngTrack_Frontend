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
import 'package:front/views/pages/login_sig/page_three.dart';
import 'package:front/views/pages/profile/profile_user.dart';
import 'package:front/views/pages/profile/update_prof_eng.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

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

           /*     return Container(
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
                                    Get.to(() => ProfileUpdate());
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
                      Row(   mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ReusableText(
                              text: " Presonal Infomation:",
                              style:
                                  appstyle(16, Colors.black, FontWeight.w600)),
                        ],
                      ),
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
                               
                                  ReusableText(
                                      text: "Years of Experience:",
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
                                 
                                  ReusableText(
                                      text: "University name:",
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ReusableText(
                              text: "Presonal Skilles:",
                              style:
                                  appstyle(16, Colors.black, FontWeight.w600)),
                        ],
                      ),
                      SizedBox(height: 20),
                      Container(
                          width: MediaQuery.of(context).size.width,
                          height: 50,
                          decoration: BoxDecoration(
                  //          color: Color(k5
                        //        .value), // Changed color to blue for demonstration
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                             
                              ReusableText(
                                  text: userData.skills[4],
                                  style: appstyle(
                                      16, Colors.black, FontWeight.w600)),
                            ],
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
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                             
                              ReusableText(
                                  text: userData.skills[3],
                                  style: appstyle(
                                      16, Colors.black, FontWeight.w600)),
                            ],
                          )),
                      SizedBox(height: 10),


                      ReusableText(
                              text: "Github:",
                              style:
                                  appstyle(16, Colors.black, FontWeight.w600)),


                          Container(
                          width: MediaQuery.of(context).size.width,
                          height: 50,
                          decoration: BoxDecoration(
                          //  color: Color(k5
                            //    .value), // Changed color to blue for demonstration
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                             
                              ReusableText(
                                  text: userData.skills[5],
                                  style: appstyle(
                                      16, Colors.black, FontWeight.w600)),
                            ],
                          )),
                    ],
                  ),
                );
             
             */
             




               return Container(
                        color: Colors.white,
                        child: Column(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width,
                              height: 200,
                              decoration: BoxDecoration(
                                color: Color(kOrange.value),
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
                                    ],
                                  ),
                                  ReusableText(
                                    text: userData.username,
                                    style: appstyle(18, Color(kDark.value), FontWeight.bold),
                                  ),
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
                                        style: appstyle(16, Color(k5.value), FontWeight.w600),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ReusableText(
                                  text: " Presonal Infomation:",
                                  style: appstyle(16, Colors.black, FontWeight.w600),
                                ),
                              ],
                            ),
                            SizedBox(height: 30),


                            Container(


                              width: MediaQuery.of(context).size.width,
                              height: 80,
                              decoration: BoxDecoration(
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
                                
                                        ReusableText(
                                
                                          text: "Phone Number:",
                                          style: appstyle(16, Color(kDarkGrey.value), FontWeight.w600),
                                        ),
                                
                                
                                
                                
                                      
                                      ],
                                    ),
                                  SizedBox(height: 10),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                
                                        ReusableText(
                                          text: userData.phone,
                                          style: appstyle(16, Colors.black, FontWeight.w600),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: 10),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              height: 80,
                              decoration: BoxDecoration(
                                 border: Border.all(color: Color(kOrange.value)  , width: 2,),
                                borderRadius: BorderRadius.circular(30),
                              ),


                                padding: EdgeInsets.only(left: 16),
                        
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      ReusableText(
                                        text: "Years of Experience:",
                                        style: appstyle(16, Color(kDarkGrey.value), FontWeight.w600),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 10),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      ReusableText(
                                        text: userData.skills[0],
                                        style: appstyle(16, Colors.black, FontWeight.w600),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 10),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              height: 80,
                              decoration: BoxDecoration(
                                 border: Border.all(color: Color(kOrange.value)  , width: 2,),
                                borderRadius: BorderRadius.circular(30),
                              ),
 padding: EdgeInsets.only(left: 16),


                              
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      ReusableText(
                                        text: "University name:",
                                        style: appstyle(16, Color(kDarkGrey.value), FontWeight.w600),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 10),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      ReusableText(
                                        text: userData.skills[1],
                                        style: appstyle(16, Colors.black, FontWeight.w600),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ReusableText(
                                  text: "Presonal Skilles:",
                                  style: appstyle(16, Colors.black, FontWeight.w600),
                                ),
                              ],
                            ),
                            SizedBox(height: 20),
                            Container(



                              width: MediaQuery.of(context).size.width,
                              height: 50,
                               padding: EdgeInsets.only(left: 16),
                              decoration: BoxDecoration(


                                 border: Border.all(color: Color(kOrange.value)  , width: 2,),
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  ReusableText(
                                    text: userData.skills[4],
                                    style: appstyle(16, Colors.black, FontWeight.w600),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 10),
                            Container(
                               padding: EdgeInsets.only(left: 16),
                              width: MediaQuery.of(context).size.width,
                              height: 50,
                              decoration: BoxDecoration(
                                 border: Border.all(color: Color(kOrange.value)  , width: 2,),
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  ReusableText(
                                    text: userData.skills[3],
                                    style: appstyle(16, Colors.black, FontWeight.w600),
                                  ),
                                ],
                              ),
                            ),

                            SizedBox(height: 10),
                         ReusableText(

                              text: "Github:",
                              style: appstyle(16, Colors.black, FontWeight.w600),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              height: 50,
                               padding: EdgeInsets.only(left: 16),
                              decoration: BoxDecoration(
                                 border: Border.all(color: Color(kOrange.value)  , width: 2,),
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                     
                                  ReusableText(
                                    text: userData.skills[5],
                                    style: appstyle(16, Colors.black, FontWeight.w600),
                                  ),
                                ],
                              ),
                            ),

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
