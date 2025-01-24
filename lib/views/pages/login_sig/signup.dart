import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:front/constants/app_constants.dart';
import 'package:front/controllers/login_provider.dart';
import 'package:front/controllers/signup_provider.dart';
import 'package:front/models/request/auth/signup_model.dart';
//import 'package:front/controllers/signup_provider.dart';
import 'package:front/views/common/app_bar.dart';
import 'package:front/views/common/app_style.dart';
import 'package:front/views/common/custom_btn.dart';
import 'package:front/views/common/custom_textfield.dart';
import 'package:front/views/common/height_spacer.dart';
import 'package:front/views/common/reusable_text.dart';
import 'package:front/views/common/sig_user.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
//import 'package:provider/provider.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  bool isAdmin = false;
  bool isAgent = false;
  bool isuser = false;
  TextEditingController _skillController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
    _skillController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var loginNotifier =
        Provider.of<LoginNotifier>(context); //enstance of login notifier

    return Consumer<SignUpNotifier>(builder: (context, signUpNotifier, child) {
      return Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(50),
            child: CustomAppBar(
              color: Color(0xFFFAF0E6),
              text: "Sign Up",
              child: GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: const Icon(CupertinoIcons.arrow_left),
              ),
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
                    text: " Hello,Welcome! ",
                    style: appstyle(30, Color(kDark.value), FontWeight.bold)),
                ReusableText(
                    align: TextAlign.center,
                    text: "Enter Your Information to signup",
                    style:
                        appstyle(16, Color(kDarkGrey.value), FontWeight.w600)),
                HeightSpacer(size: 50),
                CustomTextField(
                  controller: nameController,
                  hintText: "Full name",
                  keyboardType: TextInputType.text,
                  validator: (nameController) {
                    if (nameController!.isEmpty) {
                      return "Please enter your name";
                    } else {
                      return null;
                    }
                  },
                  suffixIcon: const Icon(Icons.person, color: kOrange),
                ),
                HeightSpacer(size: 30),
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
                  suffixIcon: const Icon(Icons.email, color: kOrange),
                ),
                HeightSpacer(size: 30),
                CustomTextField(
                  controller: passwordController,
                  textStyle:
                      appstyle(16, Color(kDark.value), FontWeight.normal),
                  suffixIcon: GestureDetector(
                      onTap: () {
                        signUpNotifier.obscureText =
                            !signUpNotifier.obscureText;
                      },
                      child: Icon(
                        signUpNotifier.obscureText
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: kOrange,
                      )),
                  keyboardType: TextInputType.text,
                  obscureText: signUpNotifier.obscureText,
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
                HeightSpacer(size: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
crossAxisAlignment:  CrossAxisAlignment.center,
                  children: [

CustomButton(text: "Admin",sizeof :20,width: 150,height: 30, onTap: (){

    isAdmin = true;
                      isAgent = false;
                      isuser = false;
},),

CustomButton(text: "user",sizeof: 20, width: 150,height: 30,onTap: (){
    
                      isAgent = true;
                      isAdmin = false;
                      isuser = false;
},)


              
                  ],
                ),
                HeightSpacer(size: 50),
                CustomButton(
                  text: "Sign Up",
                  onTap: () async {
                /*    if (_skillController.text == "Company") {
                      print("Company");
                      isAdmin = true;
                      isAgent = false;
                      isuser = false;
                    }
                    if (_skillController.text == "Engineer") {
                      print("Engineer");
                      isAgent = true;
                      isAdmin = false;
                      isuser = false;
                    }
                    if (_skillController.text == "User") {
                      print("User");
                      isuser = true;
                      isAdmin = false;
                      isAgent = false;
                    }*/

                    if (emailController.text.isNotEmpty &&
                        passwordController.text.isNotEmpty &&
                        nameController.text.isNotEmpty) {
                      SignupModel model = SignupModel(
                          username: nameController.text,
                          email: emailController.text,
                          password: passwordController.text,
                          isAdmin: isAdmin,
                          isAgent: isAgent,
                          user: isuser);
                      //    loginNotifier.firstTime = !loginNotifier.firstTime;
                      loginNotifier.firstTime = true;

                      signUpNotifier.upSignup(model);

                   
                     
                  

/*
 static Future<void> createUser() async {
    final time = DateTime.now().millisecondsSinceEpoch.toString();

    final chatUser = ChatUser(
        id: user.uid,
        name: user.displayName.toString(),
        email: user.email.toString(),
        about: "Hey, I'm using We Chat!",
        image: user.photoURL.toString(),
        createdAt: time,
        isOnline: false,
        lastActive: time,
        pushToken: '');

    return await firestore
        .collection('users')
        .doc(user.uid)
        .set(chatUser.toJson());
  }*/
                    } else {
                      Get.snackbar(
                        'Sign up Failed',
                        "Please Check your credentials",
                        colorText: Color(kLight.value),
                        backgroundColor: Colors.red,
                        icon: const Icon(Icons.add_alert),
                      );
                    }
                  },
                ),
              ],
            ),
          ));
    });
  }
}






























































/*
   var emailController=TextEditingController();
 var passwordController=TextEditingController();
  var nameController=TextEditingController();
 
  
  bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= 600;

  bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < 600;

  
  @override
  Widget build(BuildContext context) {
    // return Consumer<SignUpNotifier>(builder: (context,SignUpNotifier, child) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          margin: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _appbatr(context),
              _header(context),
              _inputField(context),
              _button(context),
            ],
          ),
        ),
      ),
    );
    // });
  }

  _appbatr(context) {
    if (isMobile(context)) {
      return CustomAppBar(
          text: "SignUp",
          child: GestureDetector(
            onTap: () {
              Get.back();
            },
            child: Icon(CupertinoIcons.arrow_left),
          ));
    } else if (isDesktop(context)) {
      return CustomAppBar(
          text: "SignUp",
          titleFontSize: 10,
          child: GestureDetector(
            onTap: () {
              Get.back();
            },
          ));
    }
  }

  _header(context) {
    return const Column(
      children: [
        Text(
          "Hello,Welcom!",
          style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
        ),
        Text("Enter your information to SignUp"),
      ],
    );
  }

  _inputField(context) {
    if (isMobile(context)) {
      return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        CustomTextField(
      //    controller: name,
          suffixIcon: const Icon(Icons.account_balance),
          keyboardType: TextInputType.emailAddress,
          hintText: "Full Name",
          validator: (name) {
            if (name!.isEmpty) {
              return "Please enter your name";
            } else {
              return null;
            }
          }, controller: nameController,
        ),
        HeightSpacer(size: 20),
        CustomTextField(
          //controller: email,
          suffixIcon: const Icon(Icons.person),
          keyboardType: TextInputType.emailAddress,
          hintText: "Email",
          validator: (email) {
            if (email!.isEmpty || !email.contains("@")) {
              return "Please enter a valid email";
            } else {
              return null;
            }
          }, controller: emailController,
        ),
        HeightSpacer(size: 20),
        CustomTextField(
       //   controller: password,
          suffixIcon: const Icon(Icons.password),
          keyboardType: TextInputType.text,
          obscureText: true,
          hintText: "password",
          validator: (password) {
            if (password!.isEmpty || password.length < 7) {
              return "Please enter a valid password";
            } else {
              return null;
            }
          }, controller: passwordController,
        ),
      ]);
    }


    else if (isDesktop(context)){
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.center,
         children: [
          CustomTextField(
             width: 600,
                 borderRadius: BorderRadius.circular(15),
              textStyle: appstyle(8, Color(kDark.value), FontWeight.normal),
        //    controller: name,
            suffixIcon: const Icon(Icons.account_balance),
            keyboardType: TextInputType.emailAddress,

            hintText: "Full Name",
              texthit:  appstyle(3, kDarkGrey, FontWeight.w500),
            validator: (name) {
              if (name!.isEmpty) {
                return "Please enter your name";
              } else {
                return null;
              }
            }, controller: nameController,
          ),
          HeightSpacer(size: 20),
          CustomTextField(
                    width: 600,
                 borderRadius: BorderRadius.circular(15),
              textStyle: appstyle(8, Color(kDark.value), FontWeight.normal),
      //      controller: email,
            suffixIcon: const Icon(Icons.person),
            keyboardType: TextInputType.emailAddress,
            hintText: "Email",
              texthit:  appstyle(3, kDarkGrey, FontWeight.w500),
            validator: (email) {
              if (email!.isEmpty || !email.contains("@")) {
                return "Please enter a valid email";
              } else {
                return null;
              }
            }, controller: emailController,
          ),
          HeightSpacer(size: 20),
          CustomTextField(
                    width: 600,
                 borderRadius: BorderRadius.circular(15),
              textStyle: appstyle(8, Color(kDark.value), FontWeight.normal),
       //     controller: password,
            suffixIcon: const Icon(Icons.password),
            keyboardType: TextInputType.text,
            obscureText: true,
            hintText: "password",
              texthit:  appstyle(3, kDarkGrey, FontWeight.w500),
            validator: (password) {
              if (password!.isEmpty || password.length < 7) {
                return "Please enter a valid password";
              } else {
                return null;
              }
            }, controller: passwordController,
          ),
        ]),
     
      );
    }
  }

  _button(context) {

    return CustomButton(
        width: 250,
        titleFontSize: 5,
        onTap: () {
          
        },
        text: "SignUp",
      );
  
}*/
