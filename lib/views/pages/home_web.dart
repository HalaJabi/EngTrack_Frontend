import 'package:flutter/material.dart';
import 'package:front/constants/app_constants.dart';
import 'package:front/views/pages/time/Project.dart';
import 'package:front/views/pages/chatpage.dart';
import 'package:front/views/pages/homepage.dart';
import 'package:front/views/pages/profile/profile_eng.dart';

class home_web extends StatefulWidget {
  const home_web({Key? key}) : super(key: key);

@override
  _home_webState createState() => _home_webState();
}

class _home_webState extends State<home_web> {

  final List<Widget> _screens = [
     HomePage(),
        HomePage(),
      ChatsPage(),
   
     // MyHomePage(),
       ProfilePage(),
      HomePage(),


  ];

  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      
      
      bottomNavigationBar:  MediaQuery.of(context).size.width < 640?
      BottomNavigationBar(
          currentIndex: _selectedIndex,
          unselectedItemColor: Colors.grey,
          selectedItemColor: Color(kOrange.value),
          // called when one tab is selected
          onTap: (int index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          // bottom tab items
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(
                icon: Icon(Icons.post_add), label: 'Post'),
            BottomNavigationBarItem(
                icon: Icon(Icons.chat), label: 'Chat'),
            BottomNavigationBarItem(
                icon: Icon(Icons.task), label: 'Project'),
                BottomNavigationBarItem(
                icon: Icon(Icons.account_circle), label: 'Profile')
          ]):null,
      body: Row(
        children: [
          if (MediaQuery.of(context).size.width >= 640)
          NavigationRail(
            onDestinationSelected: (int index) {
              setState(() {
                _selectedIndex = index;
              });
            },
            selectedIndex: _selectedIndex,
            destinations: const [
              NavigationRailDestination(
                  icon: Icon(Icons.home), label: Text('Home')),
              NavigationRailDestination(
                  icon: Icon(Icons.post_add), label: Text('Post')),
              NavigationRailDestination(
                  icon: Icon(Icons.chat), label: Text('Chat')),
              NavigationRailDestination(
                  icon: Icon(Icons.task), label: Text('Project')),
                   NavigationRailDestination(
                  icon: Icon(Icons.account_circle), label: Text('Profile')),
            ],

            labelType: NavigationRailLabelType.all,
            selectedLabelTextStyle: const TextStyle(
              color: Colors.teal,
            ),

            unselectedLabelTextStyle: const TextStyle(),
            // Called when one tab is selected
            leading: Column(
              children: const [
                SizedBox(
                  height: 8,
                ),
                CircleAvatar(
                  radius: 20,
                  child: Icon(Icons.person),
                ),
              ],
            ),

          ),
          Expanded(child: _screens[_selectedIndex])
        ],
      ),

    );
  }
}