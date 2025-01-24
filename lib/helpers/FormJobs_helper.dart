import 'package:flutter/material.dart';
import 'package:front/constants/app_constants.dart';
import 'package:front/models/request/CreateForm-req.dart';
import 'package:front/models/response/GetAllForm-res.dart';
import 'package:front/models/response/GetForm-res.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart' as http;
import 'package:front/helpers/config.dart';


import 'package:shared_preferences/shared_preferences.dart';

class FormJobsHelper {
  static http.Client client = http.Client();

   static Future<bool> createFormJob(FormReq Formjobs) async {
   
   final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'token': 'Bearer $token',
    };

      final url = Uri.http(Config.apiUrl, Config.FormJobs);
      final response = await client.post(
        url,
        headers: requestHeaders,
        body: formReqToJson(Formjobs),
      );
      debugPrint('hala:${response.statusCode}');

     if (response.statusCode == 200) {
        Get.snackbar(
          'Form is Send',
          " ",
          colorText: Color(kLight.value),
          backgroundColor: Colors.green,
          icon: const Icon(Icons.add_alert),
        );
      return true;
    } else {

        Get.snackbar(
          'Form  Send  is Failed',
          "Please Try Again",
          colorText: Color(kLight.value),
          backgroundColor: Colors.red,
          icon: const Icon(Icons.add_alert),
        );
      return false;
    }
 
  }




static Future<List<GetAllFormRes>> getAllForms(String adminid) async {
    try {
      final requestHeaders = <String, String>{
        'Content-Type': 'application/json',
      };

     // final url = Uri.http(Config.apiUrl, Config.AllForm );

final url = Uri.parse('http://${Config.apiUrl}/api/Form/GetAll?adminId=$adminid');

      print(url);
      final response = await client.get(
        url,
        headers: requestHeaders,
      );

      
      if (response.statusCode == 200) {
        final FormList = getAllFormResFromJson(response.body);
        // print("bbessanm855");
        return FormList;
      } else {
        throw Exception('Failed to get the hala');
      }
    } catch (e, s) {
      debugPrint('Error Occurred: -------------- $e ---------------');
      debugPrintStack(stackTrace: s);
      rethrow;
    }




    
  }







static Future<GetFormRes> getForm(String FormId) async {
    //try {
    final requestHeaders = <String, String>{
      'Content-Type': 'application/json',
    };

    final url = Uri.http(Config.apiUrl, "${Config.GetFormJobs}/$FormId");
    print(url);
    final response = await client.get(
      url,
      headers: requestHeaders,
    );

    //print("halala ${response.statusCode}");

    if (response.statusCode == 200) {
      var Form = getFormResFromJson(response.body);
      //  print("bbessanm855");
      return Form;
    } else {
      throw Exception('Failed to get Form');
    }
  }

















static Future<bool> deleteForm(String formId) async {
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    final requestHeaders = {
      'Content-Type': 'application/json',
      'token': 'Bearer $token',
    };

    final url = Uri.parse('http://${Config.apiUrl}/api/Form/$formId');
    final response = await client.delete(
      url,
      headers: requestHeaders,
    );

    if (response.statusCode == 200) {
      Get.snackbar(
        'Form Deleted',
        "Form has been successfully deleted",
        colorText: Color(kLight.value),
        backgroundColor: Colors.green,
        icon: const Icon(Icons.delete),
      );
      return true;
    } else {
      Get.snackbar(
        'Delete Failed',
        "Failed to delete form, please try again",
        colorText: Color(kLight.value),
        backgroundColor: Colors.red,
        icon: const Icon(Icons.error),
      );
      return false;
    }
  }








static Future<bool> deleteForm2(String formId) async {
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    final requestHeaders = {
      'Content-Type': 'application/json',
      'token': 'Bearer $token',
    };

    final url = Uri.parse('http://${Config.apiUrl}/api/Form/$formId');
    final response = await client.delete(
      url,
      headers: requestHeaders,
    );

    if (response.statusCode == 200) {
      Get.snackbar(
        'This Form add to member of project',
        "",
        colorText: Color(kLight.value),
        backgroundColor: Colors.green,
        icon: const Icon(Icons.delete),
      );
      return true;
    } else {
      Get.snackbar(
        'Add Failed',
        "",
        colorText: Color(kLight.value),
        backgroundColor: Colors.red,
        icon: const Icon(Icons.error),
      );
      return false;
    }
  }




















}