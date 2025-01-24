import 'package:flutter/material.dart';
import 'package:front/constants/app_constants.dart';
import 'package:front/helpers/auth_helper.dart';
import 'package:front/models/request/auth/signup_model.dart';
import 'package:front/views/pages/login_sig/login.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUpNotifier extends ChangeNotifier {
  bool _obscureText = true;

  bool get obscureText => _obscureText;

  set obscureText(bool newState) {
    _obscureText = newState;
    notifyListeners();
  }

  upSignup(SignupModel model) {
    
    AuthHelper.signup(model).then((response) {
      print(response);
      if (response) {
        Get.offAll(
          () => const LoginPage(),
          transition: Transition.fade,
          duration: const Duration(seconds: 2),
        );
      } else {
        Get.snackbar(
          'Sign up Failed',
          "Please Check->The password is less then 8 character",
          colorText: Color(kLight.value),
          backgroundColor: Colors.red,
          icon: const Icon(Icons.add_alert),
        );
      }
    });
  }
}
