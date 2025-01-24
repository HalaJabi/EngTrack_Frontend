import 'package:flutter/material.dart';
import 'package:front/models/request/CreateForm-req.dart';
import 'package:front/models/response/GetAllForm-res.dart';
import 'package:front/models/response/GetForm-res.dart';

import 'package:get/get.dart';

import 'package:front/helpers/FormJobs_helper.dart';
import 'package:front/views/pages/profile/profile_eng.dart';

import '../constants/app_constants.dart';

class FormNotifier extends ChangeNotifier {
  late Future<GetFormRes> Form;
  late Future<List<GetAllFormRes>> FormList;

  getForm(String FormId) {
    Form = FormJobsHelper.getForm(FormId);
  }

  getAllForms(String adminid) {
    FormList = FormJobsHelper.getAllForms(adminid);
    notifyListeners();
  }

 /* deleteform(String FormId) {
    FormJobsHelper.deleteForm(FormId);
    
  }
*/


    Future<void> deleteform(String formId, String adminId) async {
    bool success = await FormJobsHelper.deleteForm(formId);
    if (success) {
      // Re-fetch the list of forms to update the UI
      getAllForms(adminId);
    }
  }



    Future<void> deleteform2(String formId, String adminId) async {
    bool success = await FormJobsHelper.deleteForm2(formId);
    if (success) {
      // Re-fetch the list of forms to update the UI
      getAllForms(adminId);
    }
  }





}
