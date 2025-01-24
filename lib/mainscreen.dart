import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:front/constants/app_constants.dart';
import 'package:front/controllers/login_provider.dart';
import 'package:front/controllers/zoomprovider.dart';
import 'package:front/views/new_chat/chat_list_new.dart';
import 'package:front/views/pages/MyJopList.dart';
import 'package:front/views/pages/Task_Page%20copy.dart';
import 'package:front/views/pages/Task_Page.dart';
import 'package:front/views/pages/bookmark.dart';
import 'package:front/views/pages/chat/chat_list.dart';
import 'package:front/views/pages/create_job.dart';
import 'package:front/views/pages/create_project.dart';
import 'package:front/views/pages/home_web.dart';
import 'package:front/views/pages/homepage.dart';
import 'package:front/views/pages/login_sig/drawerScreen.dart';
import 'package:front/views/pages/profile/profile_company.dart';
import 'package:front/views/pages/profile/profile_eng.dart';
import 'package:front/views/pages/profile/profile_user.dart';
import 'package:front/views/pages/recruitment_data_widget.dart';
import 'package:front/views/pages/time/Project.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= 600;

  bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < 600;

  @override
  Widget build(BuildContext context) {
    if (isMobile(context)) {
      return Consumer<ZoomNotifier>(
        builder: (context, zoomNotifier, child) {
          return ZoomDrawer(
            menuScreen: DrawerScreen(
              indexSetter: (index) {
                zoomNotifier.currentIndex = index;
              },
            ),
            mainScreen: FutureBuilder<Widget>(
              future: currentScreen(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else {
                  return snapshot.data ?? Container();
                }
              },
            ),
            borderRadius: 20,
            showShadow: true,
            angle: 0.0,
            slideWidth: 273,
            menuBackgroundColor: Color(kOrange.value),
          );
        },
      );
    } else if (isDesktop(context)) {
      return const home_web();
    }

    return Container();
  }

  Future<Widget> currentScreen() async {
    final zoomNotifier = Provider.of<ZoomNotifier>(context);
    var loginNotifier = Provider.of<LoginNotifier>(context);
    bool isAdmin = await loginNotifier.getIsAdmin();
    bool user = await loginNotifier.getIsUser();

    if (isAdmin) {
      switch (zoomNotifier.currentIndex) {
        case 0:
          return const MyJopList_company();

        case 1:
          return chat_list();

        case 2:
          return JobswithTask();
        case 3:
          return const company_profile();
        case 4:
          return RecruitmentDataWidget();
        default:
          return MyJopList_company();
      }
    } else if (user) {
      switch (zoomNotifier.currentIndex) {
        case 0:
          return create_1();
        case 1:
          return chat_list();
        case 2:
          return JobswithTask();

        case 3:
          return const user_profile();
        default:
          return create_1();
      }
    } else {
      switch (zoomNotifier.currentIndex) {
        case 0:
          return const HomePage();

        case 1:
          return chat_list();

        case 2:
          return JobswithTaskuser();

        case 3:
          return const BookMarkPage();

        case 4:
          return const ProfilePage();

        default:
          return const HomePage();
      }
    }
  }
}
