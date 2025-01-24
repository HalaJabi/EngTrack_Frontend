import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:front/constants/app_constants.dart';
import 'package:front/helpers/UserManger.dart';
import 'package:front/helpers/config.dart';
import 'package:front/helpers/jop_helper.dart';
import 'package:front/models/myjob-res.dart';
import 'package:front/models/request/jobs/cr_job.dart';
import 'package:front/models/request/jobs/cre_pro.dart';
import 'package:front/models/response/Ai_res.dart';
import 'package:front/models/response/Backend_res.dart';
import 'package:front/models/response/Frontend_res.dart';
import 'package:front/models/response/auth/login_res_model.dart';
import 'package:front/models/response/jobs/cre_pro_res.dart';
import 'package:front/models/response/jobs/get_job.dart';
import 'package:front/models/response/jobs/jobs_response.dart';
import 'package:front/models/response/jobs/pro_res.dart';
import 'package:front/models/response/web-res.dart';
import 'package:front/views/pages/MyJopList.dart';
import 'package:front/views/pages/quiz/Add-quiz.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart' as https;
import 'package:shared_preferences/shared_preferences.dart';

class JobsNotifier extends ChangeNotifier {
  late Future<List<JobsResponse>> jobList;
  //late Future<JobsResponse> recent;

  late Future<GetJobRes> job;
  Future<List<MyjobRes>> Myjob = Future.value([]);

  late Future<ProjectRes> project;

  late Future<List<ProResponse>> proList;

  Future<List<WebRes>> webjob = Future.value([]);
  Future<List<FrontendRes>> Frontendjob = Future.value([]);
  Future<List<BackendRes>> Backendjob = Future.value([]);
  Future<List<AiRes>> Aijob = Future.value([]);
/*
  getRecent() {
    recent = JobsHelper.getRecent();
  }
*/
  getJobs() {
    jobList = JobsHelper.getJobs();
  }

  getJob(String jobId) {
    job = JobsHelper.getJob(jobId);
  }

  getproject(String proId) {
    project = JobsHelper.getPro(proId);
  }

  getpros() {
    proList = JobsHelper.getpros();
  }

  getMyjob(String adminId) {
    Myjob = JobsHelper.getMyjob(adminId);
  }

  getMyjobmember(String memberId) {
    Myjob = JobsHelper.getMyjobforuser(memberId);
  }

  Future<void> deleteJob(String jobId) async {
    try {
      bool response = await JobsHelper.deleteJob(jobId);
      if (response) {
        print('Job Successfully Deleted');
      } else {
        print(response);
        print('Failed to delete the job');
      }
    } catch (error) {
      print('Error occurred: $error');
    }
  }

  Future<void> addMemberToJob(String jobId, String memberId) async {
    try {
      bool response = await JobsHelper.addMember(jobId, memberId);
      print(response);
      if (response) print('Member added successfully to the job');
    } catch (error) {
      print('Error occurred while adding member to job: $error');
    }
  }

/*
  createJob(CreateJobsRequest jobData) {
    JobsHelper.createJob(jobData).then((response) {
      String id = jobData.adminId;
      if (response) {
        Get.offAll(
          () => const Addquiz(
            jobid: id,
          ),
          transition: Transition.fade,
          duration: const Duration(seconds: 2),
        );
      } else {
        Get.snackbar(
          'Sign up Failed',
          "Please Check your credentials",
          colorText: Color(kLight.value),
          backgroundColor: Colors.red,
          icon: const Icon(Icons.add_alert),
        );
      }
    });
  }
*/

  Future<bool> createJob(CreateJobsRequest jobData) async {
    try {
      bool response = await JobsHelper.createJob(jobData);

      if (response) {
        Get.snackbar(
          'Create Job Success',
          "Please Try Again", // Double check this message
          colorText: Color(kLight.value),
          backgroundColor: Colors.green,
          icon: const Icon(Icons.add_alert),
        );
      } else {
        Get.snackbar(
          'Create Job Failed',
          "Please Try Again",
          colorText: Color(kLight.value),
          backgroundColor: Colors.red,
          icon: const Icon(Icons.add_alert),
        );
      }

      return response;
    } catch (e) {
      print('Error creating job: $e');
      return false; // Return false if an exception occurs
    }
  }

  createproj(ProjectReq pData) {
    JobsHelper.createProj(pData).then((response) {
      if (response) {
        //  Get.offAll(
        //   () => const Addquiz(),
        //  transition: Transition.fade,
        //  duration: const Duration(seconds: 2),
        //    );
      } else {
        Get.snackbar(
          'Sign up Failed',
          "Please Check your credentials",
          colorText: Color(kLight.value),
          backgroundColor: Colors.red,
          icon: const Icon(Icons.add_alert),
        );
      }
    });
  }

  getwebjob() {
    webjob = JobsHelper.getwebjob();
  }

  getFrontendjob() {
    Frontendjob = JobsHelper.getFrontendjob();
  }

  getBackendjob() {
    Backendjob = JobsHelper.getBackendjob();
  }

  getAijob() {
    Aijob = JobsHelper.getAijob();
  }
}
