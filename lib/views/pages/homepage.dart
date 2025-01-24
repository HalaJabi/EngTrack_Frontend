import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:front/constants/app_constants.dart';
import 'package:front/controllers/job_provider.dart';
import 'package:front/helpers/UserManger.dart';
import 'package:front/helpers/jop_helper.dart';
import 'package:front/helpers/notification.dart';
import 'package:front/models/response/jobs/jobs_response.dart';
import 'package:front/models/response/not_get_all.dart';
import 'package:front/models/response/not_res.dart';
import 'package:front/views/common/app_bar.dart';
import 'package:front/views/common/app_style.dart';
//import 'package:front/views/common/app_style.dart';
import 'package:front/views/common/drawer_widget.dart';
import 'package:front/views/common/heading_categories.dart';
import 'package:front/views/common/heading_widget.dart';
import 'package:front/views/common/height_spacer.dart';
import 'package:front/views/common/horizantal_shimmer.dart';
import 'package:front/views/common/horizonatal_title_2.dart';
import 'package:front/views/common/pro_title.dart';
import 'package:front/views/common/search.dart';
import 'package:front/views/common/horizontal_tile.dart';
import 'package:front/views/common/vertical_shimmer.dart';
import 'package:front/views/common/virtical_title.dart';
import 'package:front/views/pages/category/configuration.dart';
import 'package:front/views/pages/category/job_Ai_list.dart';
import 'package:front/views/pages/category/job_Backend_list.dart';
import 'package:front/views/pages/category/job_Frontend_list.dart';
import 'package:front/views/pages/category/job_mobile_list.dart';
import 'package:front/views/pages/JopPage.dart';
import 'package:front/views/pages/job_list.dart';
import 'package:front/views/pages/login_sig/search_page.dart';
import 'package:front/views/pages/notification.dart';

import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:provider/provider.dart';
//import 'package:flutter_screenutil/flutter_screenutil.dart';
/*
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= 600;

  bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < 600;

  @override
  Widget build(BuildContext context) {
    if (isMobile(context)) {
      return Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(50.h),
            child: CustomAppBar(
              actions: [
                /*   Padding(
                padding: EdgeInsets.all(12.h),
                child:
const CircleAvatar(//profile image
                  radius: 20,
                  backgroundImage: AssetImage("assets/images/user1.png"),
                ),
              )*/
              ],
              child: Padding(
                padding: EdgeInsets.all(12.0.h),
                child: const DrawerWidget(),
              ),
            ),
          ),

          //body

          body: Consumer<JobsNotifier>(
            builder: (context, jobsNotifier, child) {
              jobsNotifier.getJobs();
             // jobsNotifier.getRecent();
            jobsNotifier.getpros();



              return SafeArea(
                  child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //    HeightSpacer(size: 10),

                      //       Text(""),
                      //      style: appstyle(40,Color(),Font)
                      //HeghitSpacer(Size:40)

                      HeightSpacer(size: 10),

                      SearchWidget(
                        onTap: () {
                          Get.to(() => SearchPage()); //search page
                        },
                      ),

                      HeightSpacer(size: 30), // from here the page start
                      // popular jobs
                      HeadingWidget(
                        text: "Jobs",
                        onTap: () {
                          Get.to(() => const JobListPage());
                        },
                      ),
//

                      const HeightSpacer(size: 15),
                      SizedBox(
                          height: height * 0.28,
                          child: FutureBuilder(
                              future: jobsNotifier.jobList,
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return const HorizantalShimmer();
                                } else if (snapshot.hasError) {
                                  return Text("Error ${snapshot.error}");
                                } else {
                                  final jobs = snapshot.data;

                                  return ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: jobs!.length,
                                      itemBuilder: (context, index) {
                                        final job = jobs[index];
                                        return JobHorizontalTile(
                                          onTap: () {},
                                          job: job,
                                        );
                                      });
                                } //ooo
                              })),

                      const HeightSpacer(size: 20),
                      HeadingWidget(
                        text: 'Project',
                        onTap: () {},
                      ),
                    

                     const HeightSpacer(size: 15),
                      SizedBox(
                          height: height * 0.28,
                          child: FutureBuilder(
                              future: jobsNotifier.proList,
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return const HorizantalShimmer();
                                } else if (snapshot.hasError) {
                                  return Text("Error ${snapshot.error}");
                                } else {
                                  final pros = snapshot.data;

                                  return ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: pros!.length,
                                      itemBuilder: (context, index) {
                                        final project = pros[index];

                                    return proHorizontalTile(
                                          onTap: () {},
                                          pro: project,
                                        );





                                      });
                                } //ooo
                              })),

                    
                    ],
                  ),
                ),
              ));
            },
          ));
    }

    return Container();
  }
}
*/

class HomePage extends StatefulWidget {
  const HomePage({Key? key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //late ProfileRes? userData ;

  bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= 600;

  bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < 600;

  @override
  Widget build(BuildContext context) {
    if (isMobile(context)) {
      return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(50.h),
          child: CustomAppBar(
            child: Padding(
              padding: EdgeInsets.all(12.0.h),
              child: const DrawerWidget(),
            ),
            actions: [
              IconButton(
                icon: Icon(
                  Icons.notifications_active_outlined,
                  size: 30,
                ), // استبدل بـ الأيقونة التي تريد إضافتها
                onPressed: () async {
               

/*
 List<NotGetAll> notifications = await Not_Helper.getNotificationsByUserId(UserManager.userId);




    // Iterate over each notification and print it
  for (var notification in notifications) {
    // Convert the current notification to a NotRes object
    NotGetAll notRes = NotGetAll.fromJson(notification.toJson());
     Get.to(() =>  Not_Screen(notRes));
//Get.to(Not_Screen(notRes));


 
      // You can process each notification as needed here
    }*/
     List<NotGetAll> notifications = await Not_Helper.getNotificationsByUserId(UserManager.userId);
    // Navigate to Not_Screen with the list of notifications
    Get.to(() => Not_Screen(notifications));
               
                },
              ),
            ],
          ),
        ),
        body: Consumer<JobsNotifier>(
          builder: (context, jobsNotifier, child) {
            jobsNotifier.getJobs();
            // jobsNotifier.getRecent();
            jobsNotifier.getpros();

            return SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      HeightSpacer(size: 10),
                      SearchWidget(
                        onTap: () {
                          Get.to(() => SearchPage());
                        },
                      ),
                      HeightSpacer(size: 30),
                      HeadingWidget_categories(
                        text: 'Top Categories',
                      ),
                      HeightSpacer(size: 30),
                      Container(
                        height: 120,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: categories.length,
                          itemBuilder: (context, index) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    switch (index) {
                                      case 0:
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                job_web_list(),
                                          ),
                                        );
                                        break;
                                      case 1:
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                job_Frontend_list(),
                                          ),
                                        );
                                        break;
                                      case 2:
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                job_Backend_list(),
                                          ),
                                        );
                                        break;
                                      case 3:
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => job_Ai_list(),
                                          ),
                                        );
                                        break;
                                      default:
                                        break;
                                    }
                                  },
                                  child: Container(
                                    child: Column(
                                      children: [
                                        Container(
                                          padding: EdgeInsets.all(15),
                                          margin: EdgeInsets.only(left: 15),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            boxShadow: shadowList,
                                            //borderRadius: BorderRadius.circular(10),
                                          ),
                                          child: Image.asset(
                                            categories[index]['iconPath'],
                                            height: 50,
                                            width: 50,
                                          ),
                                        ),
                                        Text(
                                          categories[index]['name'],
                                          style: appstyle(
                                              13,
                                              Color(kDark.value),
                                              FontWeight.w500),
                                        ),
                                        //    SizedBox(height: 20),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                      Divider(
                        thickness: 1,
                        color: Colors.blueGrey[200],
                      ),
                      HeightSpacer(size: 30),
                      HeadingWidget(
                        text: "Jobs",
                        onTap: () {
                          Get.to(() => const JobListPage());
                        },
                      ),
                      HeightSpacer(size: 15),
                      SizedBox(
                        height: height * 0.28,
                        child: FutureBuilder(
                          future: jobsNotifier.jobList,
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const HorizantalShimmer();
                            } else if (snapshot.hasError) {
                              return Text("Error ${snapshot.error}");
                            } else {
                              final jobs = snapshot.data;

                              return ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: jobs!.length,
                                itemBuilder: (context, index) {
                                  final job = jobs[index];
                                  return JobHorizontalTile(
                                    onTap: () {},
                                    job: job,
                                  );
                                },
                              );
                            }
                          },
                        ),
                      ),
                      HeightSpacer(size: 20),
                      HeadingWidget(
                        text: 'Recent',
                        onTap: () {},
                      ),
                      HeightSpacer(size: 15),
                      SizedBox(
                        height: height * 0.28,
                        child: 

/*
                       FutureBuilder<List<JobsResponse>>(
  future: JobsHelper.getRecent2(),
  builder: (context, snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return const VerticalShimmer(); // عندما يكون التحميل قيد التنفيذ
    } else if (snapshot.hasError) {
      return Text('Error ${snapshot.error}'); // في حالة حدوث خطأ
    } else {
      final jobsList = snapshot.data!;

      return ListView.builder(
        itemCount: jobsList.length,
        itemBuilder: (context, index) {
          final job = jobsList[index];

          return VerticalTile(
            onTap: () {
              Get.to(() => JobPage(title: job.company, id: job.id));
            },
            job: job,
          );
        },
      );
    }
  },
),
 */


FutureBuilder<List<JobsResponse>>(
  future: JobsHelper.getRecent2(),
  builder: (context, snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return const VerticalShimmer(); // عندما يكون التحميل قيد التنفيذ
    } else if (snapshot.hasError) {
      return Text('Error ${snapshot.error}'); // في حالة حدوث خطأ
    } else {
      final jobsList = snapshot.data!;

      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0), // تعيين المسافة العمودية بين العناصر
        child: ListView.builder(
          itemCount: jobsList.length,
          itemBuilder: (context, index) {
            final job = jobsList[index];

            return Padding(
              padding: const EdgeInsets.only(bottom: 10.0), // مسافة بين كل عنصر والتالي
              child: VerticalTile(
                onTap: () {
                  Get.to(() => JobPage(title: job.company, id: job.id));
                },
                job: job,
              ),
            );
          },
        ),
      );
    }
  },
),

                        
                     /*     FutureBuilder(
                      future: JobsHelper.getRecent2(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const VerticalShimmer();
                        } else if (snapshot.hasError) {
                          return Text('Error ${snapshot.error}');
                        } else {
                          final jobs = snapshot.data;
                          return VerticalTile(
                            onTap: () {
                              Get.to(
                                () =>
                                    JobPage(title: jobs!.company, id: jobs.id),
                              );
                            },
                            job: jobs,
                          );
                        }
                      },
                    ),
                      
                        */
                        /* FutureBuilder(
                          future: jobsNotifier.proList,
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const HorizantalShimmer();
                            } else if (snapshot.hasError) {
                              return Text("Error ${snapshot.error}");
                            } else {
                              final pros = snapshot.data;

                              return ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: pros!.length,
                                itemBuilder: (context, index) {
                                  final project = pros[index];
                                  return proHorizontalTile(
                                    onTap: () {},
                                    pro: project,
                                  );
                                },
                              );
                            }
                          },
                        ),*/
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      );
    }

    return Container();
  }
}
