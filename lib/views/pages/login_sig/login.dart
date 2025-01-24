import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:front/constants/app_constants.dart';
import 'package:front/controllers/login_provider.dart';
import 'package:front/helpers/auth_helper.dart';
import 'package:front/helpers/config.dart';
import 'package:front/main.dart';
import 'package:front/models/chatm.dart';
import 'package:front/models/request/auth/login_model.dart';
import 'package:front/models/response/auth/login_res_model.dart';
import 'package:front/views/common/app_bar.dart';
import 'package:front/views/common/app_style.dart';
import 'package:front/views/common/custom_btn.dart';
import 'package:front/views/common/custom_textfield.dart';
import 'package:front/views/common/height_spacer.dart';
import 'package:front/views/common/reusable_text.dart';
import 'package:front/views/pages/login_sig/signup.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:provider/provider.dart';

import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

     bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= 600;

  bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < 600;
  



  if (isMobile(context)){
    return Consumer<LoginNotifier>(builder: (context, loginNotifier, child) {
      loginNotifier.getPrefs();
      return Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(50),
            child: CustomAppBar(
              color: Color(0xFFFAF0E6),
              text: "Login",
              child: loginNotifier.entrypoint && loginNotifier.loggedIn
                  ? GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: const Icon(CupertinoIcons.arrow_left),
                    )
                  : const SizedBox.shrink(),
            ),
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                HeightSpacer(size: 100),
                ReusableText(
                    align: TextAlign.center,
                    text: " Welcome! ",
                    style: appstyle(30, Color(kDark.value), FontWeight.bold)),
                ReusableText(
                    align: TextAlign.center,
                    text: "Enter Your Information to login",
                    style:
                        appstyle(16, Color(kDarkGrey.value), FontWeight.w600)),
                HeightSpacer(size: 100),
                CustomTextField(
                  controller: emailController,
                  hintText: "Email",
                  keyboardType: TextInputType.emailAddress,
                  validator: (emailController) {
                    if (emailController!.isEmpty ||
                        !emailController.contains("@")) {
                      return "Please enter a valid email";
                    } else {
                      return null;
                    }
                  },
                  suffixIcon: const Icon(Icons.person, color: kOrange),
                ),
                HeightSpacer(size: 50),
                CustomTextField(
                  controller: passwordController,
                  textStyle:
                      appstyle(16, Color(kDark.value), FontWeight.normal),
                  suffixIcon: GestureDetector(
                      onTap: () {
                        loginNotifier.obscureText = !loginNotifier.obscureText;
                      },
                      child: Icon(
                        loginNotifier.obscureText
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: kOrange,
                      )),
                  keyboardType: TextInputType.text,
                  obscureText: loginNotifier.obscureText,
                  width: 500,
                  borderRadius: BorderRadius.circular(15),
                  hintText: "Password",
                  texthit: appstyle(16, kDarkGrey, FontWeight.w500),
                  validator: (passwordController) {
                    if (passwordController!.isEmpty ||
                        passwordController.length < 7) {
                      return "Please enter a valid password";
                    } else {
                      return null;
                    }
                  },
                ),
                HeightSpacer(size: 50),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  const Text("Don't have an account? "),
                  TextButton(
                    onPressed: () {
                      // Navigate to SignUpPage when Sign Up is pressed
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => RegistrationPage()),
                      );
                    },
                    child: const Text(
                      "Sign Up",
                      style: TextStyle(
                          color: Color(0xffFE7A36),
                          fontWeight: FontWeight.bold),
                    ),
                  )
                ]),
                const HeightSpacer(size: 100),
                CustomButton(
                  onTap: () async {
                    if (emailController.text.isNotEmpty &&
                        passwordController.text.isNotEmpty) {
                      LoginModel model = LoginModel(
                          email: emailController.text,
                          password: passwordController.text);

                      loginNotifier.userLogin(model);


                      final SharedPreferences prefs =
                          await SharedPreferences.getInstance();
/*
                      debugPrint( prefs.getString('userId'));
debugPrint( prefs.getString('email'));
debugPrint( prefs.getString('profile'));

debugPrint( prefs.getString('username'));
*/
                   
                    } else {
                      Get.snackbar(
                        "Login Failed",
                        "Please enter your credentials",
                        colorText: Color(kLight.value),
                        backgroundColor: Colors.red,
                        icon: const Icon(Icons.error),
                      );
                    }
                  },
                  text: "Login",
                ),
              ],
            ),
          ));
    });
  }
  



  else  if (isDesktop(context)){


    return Consumer<LoginNotifier>(builder: (context, loginNotifier, child) {
      loginNotifier.getPrefs();
      return Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(50),
            child: CustomAppBar(
              color: Color(0xFFFAF0E6),
              text: "Login",
              child: loginNotifier.entrypoint && loginNotifier.loggedIn
                  ? GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: const Icon(CupertinoIcons.arrow_left),
                    )
                  : const SizedBox.shrink(),
            ),
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                HeightSpacer(size: 100),
                ReusableText(
                    align: TextAlign.center,
                    text: " Welcome! ",
                    style: appstyle(30, Color(kDark.value), FontWeight.bold)),
                ReusableText(
                    align: TextAlign.center,
                    text: "Enter Your Information to login",
                    style:
                        appstyle(16, Color(kDarkGrey.value), FontWeight.w600)),
                HeightSpacer(size: 100),
                CustomTextField(
                  controller: emailController,
                  hintText: "Email",
                  keyboardType: TextInputType.emailAddress,
                  validator: (emailController) {
                    if (emailController!.isEmpty ||
                        !emailController.contains("@")) {
                      return "Please enter a valid email";
                    } else {
                      return null;
                    }
                  },
                  suffixIcon: const Icon(Icons.person, color: kOrange),
                ),
                HeightSpacer(size: 50),
                CustomTextField(
                  controller: passwordController,
                  textStyle:
                      appstyle(16, Color(kDark.value), FontWeight.normal),
                  suffixIcon: GestureDetector(
                      onTap: () {
                        loginNotifier.obscureText = !loginNotifier.obscureText;
                      },
                      child: Icon(
                        loginNotifier.obscureText
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: kOrange,
                      )),
                  keyboardType: TextInputType.text,
                  obscureText: loginNotifier.obscureText,
                  width: 100,
                  borderRadius: BorderRadius.circular(15),
                  hintText: "Password",
                  texthit: appstyle(16, kDarkGrey, FontWeight.w500),
                  validator: (passwordController) {
                    if (passwordController!.isEmpty ||
                        passwordController.length < 7) {
                      return "Please enter a valid password";
                    } else {
                      return null;
                    }
                  },
                ),
                HeightSpacer(size: 50),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  const Text("Don't have an account? "),
                  TextButton(
                    onPressed: () {
                      // Navigate to SignUpPage when Sign Up is pressed
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => RegistrationPage()),
                      );
                    },
                    child: const Text(
                      "Sign Up",
                      style: TextStyle(
                          color: Color(0xffFE7A36),
                          fontWeight: FontWeight.bold),
                    ),
                  )
                ]),
                const HeightSpacer(size: 100),
                CustomButton(
                  onTap: () async {
                    if (emailController.text.isNotEmpty &&
                        passwordController.text.isNotEmpty) {
                      LoginModel model = LoginModel(
                          email: emailController.text,
                          password: passwordController.text);

                      loginNotifier.userLogin(model);


                      final SharedPreferences prefs =
                          await SharedPreferences.getInstance();

                   
                    } else {
                      Get.snackbar(
                        "Login Failed",
                        "Please enter your credentials",
                        colorText: Color(kLight.value),
                        backgroundColor: Colors.red,
                        icon: const Icon(Icons.error),
                      );
                    }
                  },
                  text: "Login",
                ),
              ],
            ),
          ));
    });
  }
  

   return Container();
  
  }

  
  
  
  
  
  
  
  
  
  
  
  
  
  
  }



























/*
  createUser() async {
  final time = DateTime.now().millisecondsSinceEpoch.toString();
  final SharedPreferences prefs = await SharedPreferences.getInstance();

  String id = prefs.getString('userId') ?? '';
  String name = prefs.getString('username') ?? '';

  String email = prefs.getString('email') ?? '';
  String profile = prefs.getString('profile') ?? '';

  print(id);

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  final chatUser = ChatUser(
      id: id,
      name: name,
      email: email,
      about: "Hey, I'm using We Chat!",
      image: profile,
      createdAt: time,
      isOnline: false,
      lastActive: time,
      pushToken: '');

  return await firestore.collection('users').doc(id).set(chatUser.toJson());
}*/