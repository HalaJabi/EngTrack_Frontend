import 'package:flutter/material.dart';
import 'package:front/helpers/auth_helper.dart';
import 'package:front/models/profile_model.dart';

class ProfileNotifier extends ChangeNotifier {
  

  Future<ProfileRes>? profile;
  getProfile() async {
    profile = AuthHelper.getProfile();
  }
}
