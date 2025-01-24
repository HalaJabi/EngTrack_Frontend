import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:front/controllers/job_provider.dart';
import 'package:front/controllers/profile_provider.dart';
import 'package:front/models/myjob-res.dart';
import 'package:front/models/profile_model.dart';

import 'package:front/views/common/app_bar.dart';
import 'package:front/views/common/drawer_widget.dart';
import 'package:front/views/pages/job_task_page%20copy.dart';
import 'package:front/views/pages/job_task_page.dart';
import 'package:front/views/pages/login_sig/search_page.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:provider/provider.dart';

class JobswithTaskuser extends StatelessWidget {
  const JobswithTaskuser({Key? key});

  @override
  Widget build(BuildContext context) {
    var jobsCompanyList = Provider.of<JobsNotifier>(context);

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: CustomAppBar(
          color: Color(0xFFFAF0E6),
          text: "My Jobs",
          child: GestureDetector(
            onTap: () {
              Get.back();
            },
            child: Padding(
              padding: EdgeInsets.all(12.0),
              child: const DrawerWidget(),
            ),
          ),
        ),
      ),
      body: Consumer<ProfileNotifier>(
        builder: (context, profileNotifier, child) {
          profileNotifier.getProfile();
          return FutureBuilder<ProfileRes>(
            future: profileNotifier.profile,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting ||
                  snapshot.data == null) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text("Error ${snapshot.error}"),
                );
              } else {
                final userData = snapshot.data!;
                return Column(
                  children: [
                    Expanded(
                      child: Consumer<JobsNotifier>(
                        builder: (context, jobsNotifier, child) {
                          jobsNotifier.getMyjobmember(userData.id);

                          print(userData.id);

                          
                          return FutureBuilder<List<MyjobRes>>(
                            future: jobsCompanyList.Myjob,
                            builder: (context, snapshot) {
                              final jobCompany = snapshot.data;

                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return Center(
                                  child: CircularProgressIndicator(),
                                );
                              } else if (snapshot.hasError) {
                                return Text("Error ${snapshot.error}");
                              } else if (snapshot.data!.isEmpty) {
                                return const SearchLoading(
                                    text: "No Jobs to display");
                              } else {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12.0),
                                  child: ListView.separated(
                                    itemCount: jobCompany!.length,
                                    physics: ScrollPhysics(),
                                    separatorBuilder: (context, index) =>
                                        SizedBox(height: 20.0),
                                    itemBuilder: (context, index) {
                                      final jobsCompany = jobCompany[index];
                                      return JobTaskPageuser(job: jobsCompany);
                                    },
                                  ),
                                );
                              }
                            },
                          );
                        },
                      ),
                    ),
                  ],
                );
              }
            },
          );
        },
      ),
    );
  }
}
