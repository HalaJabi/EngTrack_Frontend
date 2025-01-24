import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:front/constants/app_constants.dart';
import 'package:front/helpers/jop_helper.dart';
import 'package:front/models/response/jobs/jobs_response.dart';
import 'package:front/views/common/app_style.dart';
import 'package:front/views/common/custom_field.dart';
import 'package:front/views/common/job_title.dart';
import 'package:front/views/common/reusable_text.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController search = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(






      appBar: AppBar(
        backgroundColor:   Color(0xFFFAF0E6),
        iconTheme: IconThemeData(color: Color(kDark.value)),
        title: CustomField(
          color:  Color(0xFFFAF0E6),
          hintText: 'Search for a job',
        
   
          
          controller: search,
          onEditingComplete: () {
            setState(() {});
          },
          suffixIcon: GestureDetector(
            onTap: () {
              setState(() {});
            },
            child: const Icon(Icons.search),
          ),
        ),
        elevation: 0,
      ),








      body: search.text.isNotEmpty
          ? Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.0.w, vertical: 12.h),
              child: FutureBuilder<List<JobsResponse>>(
                future: JobsHelper.searchJobs(search.text),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Text('Error ${snapshot.error}');
                  }
                   else if (snapshot.data!.isEmpty) {
                    return const SearchLoading(text: 'Job not found');
                  } 
                  else {
                    final jobs = snapshot.data;
                    return ListView.builder(
                      itemCount: jobs!.length,
                      itemBuilder: (context, index) {
                        final job = jobs[index];
                        return VerticalTileWidget(job: job);
                      },
                    );
                  }
                },
              ),
            )
          : const SearchLoading(
              text: 'Start Searching For Jobs',
            ),
    );
  }
}

class SearchLoading extends StatelessWidget {
  const SearchLoading({super.key, required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(padding: EdgeInsets.all(20.h),


    child: Column(mainAxisAlignment: MainAxisAlignment.center,
    children: [


  //Image.asset("assets/images/search.png"),
    ReusableText(
                      text:text ,
                      style: appstyle(22, Color(kDark.value), FontWeight.w600),
                    ),
    ],
    
    
    
    
    ),
    
    
    );
  }
}






