import 'package:flutter/material.dart';
import 'package:front/models/request/CreateForm-req.dart';
import 'package:front/models/response/bookmarks/all_bookmarks.dart';
import 'package:provider/provider.dart';
import 'package:front/controllers/FormJobs_provider.dart';
import 'package:front/controllers/profile_provider.dart';
import 'package:front/controllers/job_provider.dart';
import 'package:front/models/profile_model.dart';

/*
class NewFormPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New Form Page'),
      ),
      body: Consumer<ProfileNotifier>(
        builder: (context, profileNotifier, _) {
          return FutureBuilder<ProfileRes>(
            future: profileNotifier.getProfile(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text("Error ${snapshot.error}"),
                );
              } else {
                final userData = snapshot.data!;
                return Consumer<JobsNotifier>(
                  builder: (context, jobsNotifier, _) {
                    return FutureBuilder<Job>(
                      future: jobsNotifier.getJob(userData.id),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (snapshot.hasError) {
                          return Center(
                            child: Text("Error ${snapshot.error}"),
                          );
                        } else {
                          final job = snapshot.data!;
                          // بناء النموذج بالبيانات المطلوبة وطباعتها
                          FormReq formData = FormReq(
                            agentId: userData.id,
                            jobId: job.id,
                            adminId: 'admin_id_value',
                            score: 'score_value',
                            cv: 'cv_value',
                          );

                          // طباعة القيم للتحقق منها
                          print('Agent ID: ${formData.agentId}');
                          print('Job ID: ${formData.jobId}');
                          print('Admin ID: ${formData.adminId}');
                          print('Score: ${formData.score}');
                          print('CV: ${formData.cv}');

                          // إرسال النموذج إلى الـ FormNotifier لإنشائه
                          Provider.of<FormNotifier>(context, listen: false)
                              .createForm(formData);
                          return Center(
                            child: Text(
                              'This is the new form page.',
                              style: TextStyle(fontSize: 24),
                            ),
                          );
                        }
                      },
                    );
                  },
                );
              }
            },
          );
        },
      ),
    );
  }
}*/