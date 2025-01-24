import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:front/controllers/job_provider.dart';

import 'package:front/models/response/jobs/jobs_response.dart';
import 'package:front/models/response/Ai_res.dart';

import 'package:front/views/common/app_bar.dart';

import 'package:front/views/pages/login_sig/search_page.dart';
import 'package:front/views/pages/category/virtical_Ai.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:provider/provider.dart';

class job_Ai_list extends StatelessWidget {
  const job_Ai_list({Key? key});

  @override
  Widget build(BuildContext context) {
    var jobsAiList = Provider.of<JobsNotifier>(context);

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.h),
        child: CustomAppBar(
          text: "Ai Jobs",
          child: GestureDetector(
            onTap: () => Get.back(),
            child: const Icon(CupertinoIcons.arrow_left),
          ),
        ),
      ),
      body: Consumer<JobsNotifier>(
        builder: (context, jobsNotifier, child) {
          jobsNotifier.getAijob();

          return FutureBuilder<List<AiRes>>(
            future: jobsAiList.Aijob,
            builder: (context, snapshot) {
              final jobAi = snapshot.data;
             
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Text("Error ${snapshot.error}");
              } else if (snapshot.data!.isEmpty) {
                return const SearchLoading(text: "No Jobs to display");
              } else {
              
          
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child:ListView.separated(
                    itemCount: jobAi!.length,
                  physics: ScrollPhysics(),
                separatorBuilder: (context, index) => SizedBox(height:20.0), // الفاصل بين كل عنصر
                    itemBuilder: (context, index) 
                    {
                      final jobsAi = jobAi[index];
                      return Vertical_Ai(job: jobsAi);
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