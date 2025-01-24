import 'package:flutter/material.dart';
import 'package:front/constants/app_constants.dart';
import 'package:front/controllers/signup_provider.dart';
import 'package:front/helpers/auth_helper.dart';
import 'package:front/helpers/config.dart';
import 'package:front/mainscreen.dart';
import 'package:front/models/chatm.dart';
import 'package:front/models/profile_update_model.dart';
import 'package:front/models/request/auth/login_model.dart';
import 'package:front/views/pages/login_sig/page_three.dart';
import 'package:front/views/pages/profile/companyDetails.dart';
import 'package:front/views/pages/profile/engDetiales.dart';
import 'package:front/views/pages/profile/user_det.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';



class LoginNotifier extends ChangeNotifier {
  bool _obscureText = true;

  bool get obscureText => _obscureText;

  set obscureText(bool newState) {
    _obscureText = newState;
    notifyListeners();
  }

  bool _firstTime = false; // true

  bool get firstTime => _firstTime;

  set firstTime(bool newState) {
    _firstTime = newState;
    notifyListeners();
  }

  bool? _entrypoint;

  bool get entrypoint => _entrypoint ?? false;

  set entrypoint(bool newState) {
    _entrypoint = newState;
    notifyListeners();
  }

  bool? _loggedIn;

  bool get loggedIn => _loggedIn ?? false;

  set loggedIn(bool newState) {
    _loggedIn = newState;
    notifyListeners();
  }

  Future<bool> getIsUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    bool user = prefs.getBool('user') ?? false;
    return user;
  }

  Future<bool> getIsAgent() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isAgent = prefs.getBool('isAgent') ?? false;
    return isAgent;
  }

  Future<bool> getIsAdmin() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isAdmin = prefs.getBool('isAdmin') ?? false;
    return isAdmin;
  }



  getPrefs() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    entrypoint = prefs.getBool('entrypoint') ?? false;
    loggedIn = prefs.getBool('loggedIn') ?? false;
  }

  userLogin(LoginModel model) async {
    bool isAdmin = await getIsAdmin();
    bool isAgent = await getIsAgent();
    bool user = await getIsUser();

    AuthHelper.login(model).then((response) async {
      if (response && _firstTime && isAgent) {
        print("eng");

        Get.off(() => const PersonalDetails());
      } else if (response && _firstTime && user) {
        print("user");
        Get.off(() => const user_det());
      } else if (response && _firstTime && isAdmin) {
        print("admin");
        Get.off(() => const companyDetails());
      } else if (response && !_firstTime) {
        print("main");

        Get.off(() => const MainScreen());
      } else if (!response) {
        Get.snackbar("Sign Failed", "Please Check your Password",
            colorText: Color(kLight.value),
            backgroundColor: Colors.red,
            icon: const Icon(Icons.add_alert));
      }
    });
  }

  updateProfile(ProfileUpdateReq model) async {
    AuthHelper.updateProfile(model).then((response) {
      if (response) {
        Get.snackbar("Profile Update", "Enjoy your search for a job",
            colorText: Color(kLight.value),
            backgroundColor: Color(kLightBlue.value),
            icon: const Icon(Icons.add_alert));

        Future.delayed(const Duration(seconds: 3)).then((value) {
          Get.offAll(() => const MainScreen());
        });
      } else {
        Get.snackbar("Updating Failed", "Please try again",
            colorText: Color(kLight.value),
            backgroundColor: Color(kOrange.value),
            icon: const Icon(Icons.add_alert));
      }
    });
  }

  final profileFormKey = GlobalKey<FormState>();

  bool profileValiadation() {
    final form = profileFormKey.currentState;
    if (form!.validate()) {
      form.save;
      return true;
    } else {
      return false;
    }
  }

  logout() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setBool('loggedIn', false);
    /*
    await prefs.remove('token');
    await prefs.remove('userId');
    await prefs.remove('profile');
    await prefs.remove('isAdmin');
    await prefs.remove('isAgent');*/




    await prefs.remove('token');
      await prefs.remove('userId');
      await prefs.remove('profile');
    
      await prefs.remove('isAdmin');
     await prefs.remove('isAgent');
     await prefs.remove('user');
       await prefs.remove('username');
       await prefs.remove('email');

    _firstTime =
        false; // مثال افتراضي، قد تحتاج إلى إعادة تعيين المتغيرات الأخرى إلى قيمها الافتراضية

    Get.offAll(const PageThree());
  }

  //static Future<void>
  





}
