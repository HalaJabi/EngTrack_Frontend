/*import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
//import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:front/constants/app_constants.dart';
import 'package:front/views/common/app_style.dart';
import 'package:front/views/common/custom_outline_btn.dart';
import 'package:front/views/common/height_spacer.dart';
import 'package:front/views/common/reusable_text.dart';
import 'package:front/views/pages/login.dart';
import 'package:front/views/pages/signup.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PageThree extends StatelessWidget {
  const PageThree({super.key});
bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= 600;

  bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < 600;
  @override
  Widget build(BuildContext context) {


      if (isMobile(context)) {
    return Scaffold(
        body: Container(
      width: width,
      height: height,
      color: Color(kOrange.value),
      child: Column(
        children: [
          const HeightSpacer(
            size: 100,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset("assets/images/logo2.png"),
          ),
          const HeightSpacer(size: 150),
          Column(
            children: [
              ReusableText(
                  text: "Welcom to Eng Track",
                  style: appstyle(20, Color(kLight.value), FontWeight.w500)),
              const HeightSpacer(size: 100),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomOutlineBtn(
                    onTap: () async {
                      final SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      await prefs.setBool('entrypoint', true);

                      Get.to(() => const LoginPage());
                    },
                    text: "Login",
                    width: width * 0.4,
                    height: height * 0.06,
                    color: Color(kLight.value),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                      onTap: () {
                        Get.to(() => const RegistrationPage());
                      },
                      child: Container(
                          width: width * 0.4,
                          height: height * 0.06,
                          color: Color(kLight.value),
                          child: Center(
                            child: ReusableText(
                                text: "Sign Up",
                                style: appstyle(
                                    16, Color(kOrange.value), FontWeight.w600)),
                          ))),
                )
              ]),
              const HeightSpacer(size: 30),
              ReusableText(
                  text: "Continue as guest",
                  style: appstyle(16, Color(kLight.value), FontWeight.w400))
            ],
          )
        ],
      ),
    ));
  }
  
}*/

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:front/constants/app_constants.dart';
import 'package:front/views/common/app_style.dart';
import 'package:front/views/common/custom_outline_btn.dart';
import 'package:front/views/common/height_spacer.dart';
import 'package:front/views/common/reusable_text.dart';
import 'package:front/views/pages/login_sig/login.dart';
import 'package:front/views/pages/login_sig/signup.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PageThree extends StatelessWidget {
  const PageThree({Key? key}) : super(key: key);
  bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= 600;

  bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < 600;

  @override
  Widget build(BuildContext context) {
    if (isMobile(context)) {
      return Scaffold(
          body: Container(
        width: width,
        height: height,
        color: Color(kOrange.value),
        child: Column(
          children: [
            const HeightSpacer(
              size: 100,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset("assets/images/logo2.png"),
            ),
            const HeightSpacer(size: 150),
            Column(
              children: [
                ReusableText(
                    text: "Welcom to Eng Track",
                    style: appstyle(25, Color(kLight.value), FontWeight.bold)),
                const HeightSpacer(size: 100),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CustomOutlineBtn(
                          onTap: () async {
                            final SharedPreferences prefs = await SharedPreferences
                                .getInstance(); // first time that visit the app
                            await prefs.setBool(
                                'entrypoint', true); //first time we login

                            Get.to(() => const LoginPage());
                          },
                          text: "Login",
                          borderRadius: 20.0,
                          titleFontSize: 20,
                          width: width * 0.4,
                          height: height * 0.06,
                          color: Color(kLight.value),
                        ),
                      ),
                      Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                            onTap: () {
                              Get.to(() => const RegistrationPage());
                            },
                            child: Container(
                              width: width * 0.4,
                              height: height * 0.06,
                              decoration: BoxDecoration(
                                color: Color(kLight.value),
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              child: Center(
                                child: ReusableText(
                                  text: "Sign Up",
                                  style: appstyle(20, Color(kOrange.value),
                                      FontWeight.w600),
                                ),
                              ),
                            ),
                          ))
                    ]),
                const HeightSpacer(size: 50),
                ReusableText(
                  text: 'You Can Vist Us',
                  style: appstyle(14, Color(kLight.value), FontWeight.bold),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.facebook,
                        color: kDarkBlue,
                      ),
                      onPressed: () {
                        // Add your Facebook profile link here
                      },
                    ),
                    IconButton(
                      icon: Icon(FontAwesomeIcons.github, color: kDarkBlue),
                      onPressed: () {
                        // Add your Twitter profile link here
                      },
                    ),
                    IconButton(
                      icon: Icon(FontAwesomeIcons.linkedin, color: kDarkBlue),
                      onPressed: () {
                        // Add your LinkedIn profile link here
                      },
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
      ));
    } else if (isDesktop(context)) {




      return Scaffold(
        body: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            color: Color(kOrange.value),
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const HeightSpacer(size: 50),
                Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Image.asset("assets/images/logo2.png"),
                ),
                const HeightSpacer(size: 100),
                ReusableText(
                  text: "Welcome to Eng Track",
                  style: appstyle(10, Color(kLight.value), FontWeight.w500),
                ),
                const HeightSpacer(size: 130),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomOutlineBtn(
                      onTap: () async {
                        final SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        await prefs.setBool('entrypoint', true);

                        Get.to(() => const LoginPage());
                      },
                      text: "Login",
                      titleFontSize: 10,
                      width: 250,
                      height: 100,
                      color: Color(kLight.value),
                    ),
                    const SizedBox(width: 10),
                    GestureDetector(
                      onTap: () {
                        Get.to(() => const RegistrationPage());
                      },
                      child: Container(
                        width: 250,
                        height: 100,
                        color: Color(kLight.value),
                        child: Center(
                          child: ReusableText(
                            text: "Sign Up",
                            style: appstyle(
                              10,
                              Color(kOrange.value),
                              FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    }

    return Container();
  }
}
