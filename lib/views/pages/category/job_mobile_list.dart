import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:front/controllers/job_provider.dart';
import 'package:front/models/response/jobs/jobs_response.dart';

import 'package:front/views/common/app_bar.dart';

import 'package:front/views/pages/login_sig/search_page.dart';
import 'package:front/views/pages/category/virtical_w.dart';
import 'package:front/models/response/web-res.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:provider/provider.dart';

class job_web_list extends StatelessWidget {
  const job_web_list({Key? key});

  @override
  Widget build(BuildContext context) {
    var jobswebList = Provider.of<JobsNotifier>(context);

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.h),
        child: CustomAppBar(
          text: "mobile Jobs",
          child: GestureDetector(
            onTap: () => Get.back(),
            child: const Icon(CupertinoIcons.arrow_left),
          ),
        ),
      ),
      body: Consumer<JobsNotifier>(
        builder: (context, jobsNotifier, child) {
          jobsNotifier.getwebjob();

          return FutureBuilder<List<WebRes>>(
            future: jobswebList.webjob,
            builder: (context, snapshot) {
              final jobw = snapshot.data;
              
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Text("Error ${snapshot.error}");
              } else if (snapshot.data!.isEmpty) {
                return const SearchLoading(text: "No Jobs to display");
              } else {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: ListView.builder(
                    itemCount: jobw!.length,
                    physics: ScrollPhysics(),
                    itemBuilder: (context, index) {
                      final jobs = jobw[index];
                      return Vertical_Web(job: jobs);
                    },
                  ),
                );
              }
            },
          );
        },
      ),
    );
  }
}