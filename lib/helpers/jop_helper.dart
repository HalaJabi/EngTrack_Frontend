import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:front/constants/app_constants.dart';
import 'package:front/helpers/UserManger.dart';
import 'package:front/helpers/config.dart';
import 'package:front/models/myjob-res.dart';
import 'package:front/models/request/jobs/cr_job.dart';
import 'package:front/models/request/jobs/cre_pro.dart';
import 'package:front/models/response/Ai_res.dart';
import 'package:front/models/response/Backend_res.dart';
import 'package:front/models/response/Frontend_res.dart';

import 'package:front/models/response/jobs/cre_pro_res.dart';
import 'package:front/models/response/jobs/get_job.dart';
import 'package:front/models/response/jobs/job_id.dart';
import 'package:front/models/response/jobs/jobs_response.dart';
import 'package:front/models/response/jobs/pro_res.dart';
import 'package:front/models/response/web-res.dart';
import 'package:front/views/pages/quiz/Add-quiz.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

// FIX: ADDED TRY CATCHES EVERYWHERE
class JobsHelper {
  static http.Client client = http.Client();

   static Future<JobsResponse> getRecent() async {
    final requestHeaders = <String, String>{
      'Content-Type': 'application/json',
    };

    final url = Uri.http(Config.apiUrl, Config.jobs, {'new': 'true'});
    final response = await client.get(
      url,
      headers: requestHeaders,
    );

    if (response.statusCode == 200) {
      final jobsList = jobsResponseFromJson(response.body);

      final recent = jobsList.first;
      return recent;
    } else {
      throw Exception('Failed to get the jobs');
    }
  }

static Future<List<JobsResponse>> getRecent2() async {
  try {
    final requestHeaders = <String, String>{
      'Content-Type': 'application/json',
    };

    final url = Uri.http(Config.apiUrl, Config.jobs, {'new': 'true'});
    final response = await client.get(
      url,
      headers: requestHeaders,
    );

    if (response.statusCode == 200) {
      final jobsList = jobsResponseFromJson(response.body);

      // تحقق من عدد الوظائف إذا كانت أقل من 5
      if (jobsList.length <= 5) {
        return jobsList; // إذا كانت القائمة أقل من 5، قم بإعادة القائمة كاملة
      } else {
        // إرجاع العناصر الخمسة الأخيرة
        return jobsList.sublist(jobsList.length - 5);
      }
    } else {
      throw Exception('Failed to get the jobs');
    }
  } catch (e, s) {
    debugPrint('Error Occurred: -------------- $e ---------------');
    debugPrintStack(stackTrace: s);
    rethrow;
  }
}

  

  static Future<List<JobsResponse>> getJobs() async {
    try {
      final requestHeaders = <String, String>{
        'Content-Type': 'application/json',
      };

      final url = Uri.http(Config.apiUrl, Config.jobs);

      print(url);
      final response = await client.get(
        url,
        headers: requestHeaders,
      );

      //print("halala ${response.statusCode}");

      if (response.statusCode == 200) {
        final jobsList = jobsResponseFromJson(response.body);
        // print("bbessanm855");
        return jobsList;
      } else {
        throw Exception('Failed to get the jobs');
      }
    } catch (e, s) {
      debugPrint('Error Occurred: -------------- $e ---------------');
      debugPrintStack(stackTrace: s);
      rethrow;
    }
  }

  static Future<List<MyjobRes>> getMyjob(String adminId) async {
    try {
      final requestHeaders = <String, String>{
        'Content-Type': 'application/json',
      };

      final url = Uri.http(Config.apiUrl, "${Config.Jobforcompany}/$adminId");
      print(url);

      final response = await client.get(
        url,
        headers: requestHeaders,
      );

      if (response.statusCode == 200) {
        final jobsList = myjobResFromJson(response.body);
        return jobsList;
      } else {
        throw Exception('Failed to get MY job');
      }
    } catch (e, s) {
      debugPrint('Error Occurred: -------------- $e ---------------');
      debugPrintStack(stackTrace: s);
      rethrow;
    }
  }

  static Future<List<MyjobRes>> getMyjobforuser(String memberId) async {
    try {
      final requestHeaders = <String, String>{
        'Content-Type': 'application/json',
      };

      final url =
          Uri.http(Config.apiUrl, "${Config.getjobformember}/$memberId");

      print(url);

      final response = await client.get(
        url,
        headers: requestHeaders,
      );

      print(response.statusCode);
      if (response.statusCode == 200) {
        final jobsList = myjobResFromJson(response.body);
        return jobsList;
      } else {
        throw Exception('Failed to get MY job');
      }
    } catch (e, s) {
      debugPrint('Error Occurred: -------------- $e ---------------');
      debugPrintStack(stackTrace: s);
      rethrow;
    }
  }

  static Future<GetJobRes> getJob(String jobId) async {
    //try {
    final requestHeaders = <String, String>{
      'Content-Type': 'application/json',
    };

    final url = Uri.http(Config.apiUrl, "${Config.jobs}/$jobId");
    print(url);
    final response = await client.get(
      url,
      headers: requestHeaders,
    );

    //print("halala ${response.statusCode}");

    if (response.statusCode == 200) {
      var job = getJobResFromJson(response.body);
      //  print("bbessanm855");
      return job;
    } else {
      throw Exception('Failed to get a job');
    }
  }

//SEARCH
  static Future<List<JobsResponse>> searchJobs(String searchQeury) async {
    final requestHeaders = <String, String>{
      'Content-Type': 'application/json',
    };

    final url = Uri.http(Config.apiUrl, '${Config.search}/$searchQeury');
    final response = await client.get(
      url,
      headers: requestHeaders,
    );

    if (response.statusCode == 200) {
      final jobsList = jobsResponseFromJson(response.body);
      return jobsList;
    } else {
      throw Exception('Failed to get the jobs');
    }
  }

  static Future<bool> deleteJob(String jobId) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');

      Map<String, String> requestHeaders = {
        'Content-Type': 'application/json',
        'token': 'Bearer $token',
      };
      final url = Uri.http(Config.apiUrl, '${Config.delete}/$jobId');

      final response = await http.delete(
        url,
        headers: requestHeaders,
      );
      print(response.statusCode);
      print(jobId);
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (error) {
      print('Error occurred: $error');
      throw error;
    }
  }

  static Future<bool> createJob(CreateJobsRequest jobData) async {
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'token': 'Bearer $token',
    };

    final url = Uri.http(Config.apiUrl, Config.jobs);
    final response = await client.post(
      url,
      headers: requestHeaders,
      body: createJobsRequestToJson(jobData),
    );

    String jobId = jobResFromJson(response.body).id;

    UserManager.setback(id: jobId);

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  static Future<bool> createProj(ProjectReq pData) async {
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'token': 'Bearer $token',
    };

    final url = Uri.http(Config.apiUrl, Config.pro);
    final response = await client.post(
      url,
      headers: requestHeaders,
      body: projectReqToJson(pData),
    );
    print(response.statusCode);

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  static Future<ProjectRes> getPro(String proId) async {
    final requestHeaders = <String, String>{
      'Content-Type': 'application/json',
    };

    final url = Uri.http(Config.apiUrl, "${Config.pro}/$proId");

    final response = await client.get(
      url,
      headers: requestHeaders,
    );

    if (response.statusCode == 200) {
      var project = projectResFromJson(response.body);

      return project;
    } else {
      throw Exception('Failed to get a job');
    }
  }

  static Future<List<ProResponse>> getpros() async {
    try {
      final requestHeaders = <String, String>{
        'Content-Type': 'application/json',
      };

      final url = Uri.http(Config.apiUrl, Config.pro);
      print(url);
      final response = await client.get(
        url,
        headers: requestHeaders,
      );

      if (response.statusCode == 200) {
        final proList = proResponseFromJson(response.body);

        return proList;
      } else {
        throw Exception('Failed to get the jobs');
      }
    } catch (e, s) {
      debugPrint('Error Occurred: -------------- $e ---------------');
      debugPrintStack(stackTrace: s);
      rethrow;
    }
  }

  static Future<List<FrontendRes>> getFrontendjob() async {
    try {
      final requestHeaders = <String, String>{
        'Content-Type': 'application/json',
      };

      final url = Uri.http(Config.apiUrl, Config.Frontend);
      print(url);
      final response = await client.get(
        url,
        headers: requestHeaders,
      );

      //print("halala ${response.statusCode}");
      print(response.statusCode);
      if (response.statusCode == 200) {
        final jobsFrontendList = frontendResFromJson(response.body);
        //print("bbessanm855");
        return jobsFrontendList;
      } else {
        throw Exception('Failed to get the Frontend');
      }
    } catch (e, s) {
      debugPrint('Error Occurred: -------------- $e ---------------');
      debugPrintStack(stackTrace: s);
      rethrow;
    }
  }

  static Future<List<BackendRes>> getBackendjob() async {
    try {
      final requestHeaders = <String, String>{
        'Content-Type': 'application/json',
      };

      final url = Uri.http(Config.apiUrl, Config.Backend);
      print(url);
      final response = await client.get(
        url,
        headers: requestHeaders,
      );

      //print("halala ${response.statusCode}");
      print(response.statusCode);
      if (response.statusCode == 200) {
        final jobsBackendList = backendResFromJson(response.body);
        //print("bbessanm855");
        return jobsBackendList;
      } else {
        throw Exception('Failed to get the Frontend');
      }
    } catch (e, s) {
      debugPrint('Error Occurred: -------------- $e ---------------');
      debugPrintStack(stackTrace: s);
      rethrow;
    }
  }

  static Future<List<AiRes>> getAijob() async {
    try {
      final requestHeaders = <String, String>{
        'Content-Type': 'application/json',
      };

      final url = Uri.http(Config.apiUrl, Config.Ai);
      print(url);
      final response = await client.get(
        url,
        headers: requestHeaders,
      );

      //print("halala ${response.statusCode}");
      print(response.statusCode);
      if (response.statusCode == 200) {
        final jobsAiList = aiResFromJson(response.body);
        //print("bbessanm855");
        return jobsAiList;
      } else {
        throw Exception('Failed to get the Frontend');
      }
    } catch (e, s) {
      debugPrint('Error Occurred: -------------- $e ---------------');
      debugPrintStack(stackTrace: s);
      rethrow;
    }
  }

  static Future<List<WebRes>> getwebjob() async {
    try {
      final requestHeaders = <String, String>{
        'Content-Type': 'application/json',
      };

      final url = Uri.http(Config.apiUrl, Config.mobile);
      print(url);
      final response = await client.get(
        url,
        headers: requestHeaders,
      );

      //print("halala ${response.statusCode}");
      print(response.statusCode);
      if (response.statusCode == 200) {
        final jobswebList = webResFromJson(response.body);
        //print("bbessanm855");
        return jobswebList;
      } else {
        throw Exception('Failed to get the webjobs');
      }
    } catch (e, s) {
      debugPrint('Error Occurred: -------------- $e ---------------');
      debugPrintStack(stackTrace: s);
      rethrow;
    }
  }

  static Future<bool> addMember(String jobId, String memberId) async {
    try {
      final requestHeaders = <String, String>{
        'Content-Type': 'application/json',
      };

      final url = Uri.http(Config.apiUrl, "${Config.jobadd}$jobId/addMember");
      final body = jsonEncode({"memberId": memberId});

      final response = await client.put(
        url,
        headers: requestHeaders,
        body: body,
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e, s) {
      debugPrint('Error Occurred: -------------- $e ---------------');
      debugPrintStack(stackTrace: s);
      return false;
    }
  }

  static Future<void> addtask(String jobId, String taskid) async {
    final requestHeaders = <String, String>{
      'Content-Type': 'application/json',
    };

    final url = Uri.http(Config.apiUrl, "${Config.jobadd}$jobId/addTask");

    final body = jsonEncode({"taskId": taskid});

    final response = await client.put(
      url,
      headers: requestHeaders,
      body: body,
    );
    print(response.statusCode);
    if (response.statusCode == 200) {
      print(response.statusCode);
    } else {
      print(response.statusCode);
    }
  }

  static Future<List<String>> getMembersByJobId(String jobId) async {
    try {
      final requestHeaders = <String, String>{
        'Content-Type': 'application/json',
      };

      final url = Uri.http(Config.apiUrl, "${Config.getMembersByJobId}/$jobId");
      print(url);
      final response = await client.get(
        url,
        headers: requestHeaders,
      );

      if (response.statusCode == 200) {
        List<dynamic> members = jsonDecode(response.body);
        return members.cast<String>();
      } else {
        throw Exception('Failed to get members for job $jobId');
      }
    } catch (e, s) {
      debugPrint('Error Occurred: -------------- $e ---------------');
      debugPrintStack(stackTrace: s);
      rethrow;
    }
  }
}
