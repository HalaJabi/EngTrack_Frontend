import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:front/controllers/job_provider.dart';
import 'package:front/models/response/jobs/jobs_response.dart';
import 'package:front/views/common/app_bar.dart';
import 'package:front/views/common/job_title.dart';
import 'package:front/views/pages/login_sig/search_page.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:provider/provider.dart';

class JobListPage extends StatelessWidget {
  const JobListPage({super.key});

  @override
  Widget build(BuildContext context) {
    var joblist = Provider.of<JobsNotifier>(context);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.h),
        child: CustomAppBar(
            text: "Jobs",
            child: GestureDetector(
              onTap: () => Get.back(),
              child: const Icon(CupertinoIcons.arrow_left),
            )),
      ),

      
      body: FutureBuilder<List<JobsResponse>>(
          future: joblist.jobList,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Text("Error ${snapshot.error}");
            }else if (snapshot.data!.isEmpty) {
              return const SearchLoading(text: "No Jobs to display");
            }  else {
              final job = snapshot.data;
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: ListView.builder(
                    itemCount: job!.length,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      final jobs = job[index];
                      return VerticalTileWidget(job: jobs,);
                    }),
              );
            }
          }),
    );
  }
}
