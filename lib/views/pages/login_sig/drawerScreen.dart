import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:front/constants/app_constants.dart';
import 'package:front/controllers/login_provider.dart';
import 'package:front/controllers/zoomprovider.dart';
import 'package:front/views/common/app_style.dart';
import 'package:front/views/common/reusable_text.dart';
import 'package:front/views/common/width_spacer.dart';
import 'package:provider/provider.dart';

class DrawerScreen extends StatefulWidget {
  const DrawerScreen({required this.indexSetter, Key? key}) : super(key: key);
  final ValueSetter<int> indexSetter;

  @override
  _DrawerScreenState createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  late Future<bool> _isAdminFuture;
  late Future<bool> _isUserFuture;

  @override
  void initState() {
    super.initState();
    _isAdminFuture =
        Provider.of<LoginNotifier>(context, listen: false).getIsAdmin();
_isUserFuture =
        Provider.of<LoginNotifier>(context, listen: false).getIsUser();

  }

@override
Widget build(BuildContext context) {
  return FutureBuilder(
    future: Future.wait([_isAdminFuture, _isUserFuture]),
    builder: (context, AsyncSnapshot<List<bool>> snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return CircularProgressIndicator(); // Display loading indicator while waiting
      } else if (snapshot.hasError) {
        return Text('Error: ${snapshot.error}'); // Handle error case
      } else if (!snapshot.hasData || snapshot.data!.length < 2) {
        return Text('Data not available'); // Handle no data case
      } else {
        final isAdmin = snapshot.data![0];
        final isUser = snapshot.data![1];
        return buildDrawer(isAdmin, isUser);
      }
    },
  );
}





Widget buildDrawer(bool isAdmin, bool isUser) {
  return Consumer<ZoomNotifier>(
    builder: (context, zoomNotifier, child) {





       if (isAdmin) {
          return GestureDetector(
            onDoubleTap: () {
              ZoomDrawer.of(context)!.toggle();
            },
            child: Scaffold(
              backgroundColor: Color(kDarkBlue.value),
              body: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
     
                  drawerItem(
                    Icons.create,
                    'My Posts',
                    0,
                    zoomNotifier.currentIndex == 0
                        ? Color(k4.value)
                        : Color(kOrange.value),
                  ),
               
                  drawerItem(
                    Icons.chat,
                    'Chat',
                    1,
                    zoomNotifier.currentIndex == 1
                        ? Color(k4.value)
                        : Color(kOrange.value),
                  ),
                  drawerItem(
                    Icons.work,
                    'Project',
                    2,
                    zoomNotifier.currentIndex == 2
                        ? Color(k4.value)
                        : Color(kOrange.value),
                  ),
                
                 
                    drawerItem(
                      Icons.account_circle,
                      'Profile',
                      3,
                      zoomNotifier.currentIndex == 3
                          ? Color(k4.value)
                          : Color(kOrange.value),
                    ),
                     drawerItem(
                    Icons.list,
                    'Applicants',
                    4,
                    zoomNotifier.currentIndex == 4
                        ? Color(k4.value)
                        : Color(kOrange.value),
                  ),
                 
         
              
                ],
              ),
            ),
          );
        }




        else if(isUser)
        {




  return GestureDetector(
            onDoubleTap: () {
              ZoomDrawer.of(context)!.toggle();
            },
            child: Scaffold(
              backgroundColor: Color(kDarkBlue.value),
              body: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                    drawerItem(
                    Icons.create,
                    'Create Project',
                    0,
                    zoomNotifier.currentIndex == 0
                        ? Color(k4.value)
                        : Color(kOrange.value),
                  ),
                  drawerItem(
                    Icons.chat,
                    'Chat',
                    1,
                    zoomNotifier.currentIndex == 1
                        ? Color(k4.value)
                        : Color(kOrange.value),
                  ),
                  drawerItem(
                    Icons.work,
                    'Project',
                    2,
                    zoomNotifier.currentIndex == 2
                        ? Color(k4.value)
                        : Color(kOrange.value),
                  ),
                 drawerItem(
                      Icons.account_circle,
                      'Profile',
                      3,
                      zoomNotifier.currentIndex == 3
                          ? Color(k4.value)
                          : Color(kOrange.value),
                    )
                 ,
               
                ],
              ),
            ),
          );
        }
        else {



          
            return GestureDetector(
            onDoubleTap: () {
              ZoomDrawer.of(context)!.toggle();
            },
            child: Scaffold(
              backgroundColor: Color(kDarkBlue.value),
              body: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  drawerItem(
                    Icons.home,
                    'Home',
                    0,
                    zoomNotifier.currentIndex == 0
                        ? Color(k4.value)
                        : Color(kOrange.value),
                  ),
                  drawerItem(
                    Icons.chat,
                    'Chat',
                    1,
                    zoomNotifier.currentIndex == 1
                        ? Color(k4.value)
                        : Color(kOrange.value),
                  ),
                  drawerItem(
                    Icons.work,
                    'Project',
                    2,
                    zoomNotifier.currentIndex == 2
                        ? Color(k4.value)
                        : Color(kOrange.value),
                  ),
                  drawerItem(
                    Icons.save,
                    'Save',
                    3,
                    zoomNotifier.currentIndex == 3
                        ? Color(k4.value)
                        : Color(kOrange.value),
                  ),
                 
                    drawerItem(
                      Icons.account_circle,
                      'Profile',
                      4,
                      zoomNotifier.currentIndex == 4
                          ? Color(k4.value)
                          : Color(kOrange.value),
                    )
                 ,
               
                ],
              ),
            ),
          );

        }
     },
  );
}


  Widget drawerItem(IconData icon, String text, int index, Color color) {
    return GestureDetector(
      onTap: () {
        widget.indexSetter(index);
      },
      child: Container(
        margin: EdgeInsets.only(left: 20.w, bottom: 40.h),
        child: Row(
          children: [
            Icon(
              icon,
              color: color,
            ),
            const WidthSpacer(
              width: 12,
            ),
            ReusableText(
              text: text,
              style: appstyle(12, color, FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
