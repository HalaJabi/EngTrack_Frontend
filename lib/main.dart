import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:front/constants/app_constants.dart';
import 'package:front/constants/firebase_api.dart';
import 'package:front/controllers/book_provider.dart';
import 'package:front/controllers/chat_provider.dart';
import 'package:front/controllers/image_provider.dart';
import 'package:front/controllers/job_provider.dart';
import 'package:front/controllers/login_provider.dart';
import 'package:front/controllers/onboarding_provider.dart';
import 'package:front/controllers/profile_provider.dart';
import 'package:front/controllers/quiz_provider.dart';
import 'package:front/controllers/signup_provider.dart';
import 'package:front/controllers/zoomprovider.dart';
import 'package:front/firebase_options.dart';
import 'package:front/mainscreen.dart';
import 'package:front/views/common/task_tile.dart';
import 'package:front/views/new_chat/chat_list_new.dart';
import 'package:front/views/pages/gannt.dart';

import 'package:front/views/pages/login_sig/login.dart';
import 'package:front/views/pages/login_sig/onboarding_screen.dart';

import 'package:front/views/pages/quiz/Add-quiz.dart';
import 'package:front/views/pages/quiz/eng_quiz.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

Widget defaultHome = const OnBoardingScreen();

//late Size mq;



void main() async {
  WidgetsFlutterBinding.ensureInitialized(); 
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

 final _firebaseMessaging = FirebaseMessaging.instance;
 await _firebaseMessaging.requestPermission();
    final fCMToken = await _firebaseMessaging.getToken();
    print(fCMToken);

    

  final SharedPreferences prefs = await SharedPreferences.getInstance();

  final entrypoint = prefs.getBool('entrypoint') ?? false;
  final loggedIn = prefs.getBool('loggedIn') ?? false;

  if (entrypoint || loggedIn) {
    defaultHome = const MainScreen();
  } else {
    defaultHome = const OnBoardingScreen();
  }

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<OnBoardNotifier>(
            create: (context) => OnBoardNotifier()),
        ChangeNotifierProvider(create: (context) => LoginNotifier()),
        ChangeNotifierProvider(create: (context) => SignUpNotifier()),
        ChangeNotifierProvider<ZoomNotifier>(
            create: (context) => ZoomNotifier()),
        ChangeNotifierProvider(create: (context) => ImageUpoader()),
        ChangeNotifierProvider(create: (context) => BookMarkNotifier()),
        ChangeNotifierProvider(create: (context) => ProfileNotifier()),
        ChangeNotifierProvider(create: (context) => JobsNotifier()),
        ChangeNotifierProvider(create: (context) => ChatNotifier()),
        ChangeNotifierProvider(create: (context) => QuizzNotifier()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //  mq = MediaQuery.of(context).size;
    return ScreenUtilInit(
      useInheritedMediaQuery: true,
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'EngTrack',
          theme: ThemeData(
            scaffoldBackgroundColor: Color(kLight.value),
            iconTheme: IconThemeData(color: Color(kDark.value)),
            primarySwatch: Colors.grey,
          ),
          home: defaultHome, //const gannt_chart(),// //
        );
      },
    );
  }
}
