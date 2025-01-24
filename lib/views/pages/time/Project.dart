/*import 'package:flutter/material.dart';
import 'package:front/views/pages/Task_Page.dart';
import 'package:front/views/pages/time/Home_task.dart';
import 'package:front/views/pages/time/home_screen_todo_list.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}
class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;
  final List<Widget> _screens = [
   ,
     Tasks(),
    HomeScreen(),
    ProjectScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    //  appBar: AppBar(
    //title: Text('Projects'),
    //  ),
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.assignment, color: Colors.orange),
            label: 'My Project',  
          ),  
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today, color: Colors.orange),
            label: 'Calendar',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.timeline, color: Colors.orange),
            label: 'Timeline',
          ),
       
           BottomNavigationBarItem(
            icon: Icon(Icons.table_chart, color: Colors.orange),
            label: 'Table',
          ),
        ],
        selectedItemColor: Colors.orange,
        unselectedItemColor: Colors.grey, 
        showUnselectedLabels: true,
        selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold, color: Colors.orange), 
        unselectedLabelStyle: TextStyle(fontWeight: FontWeight.normal, color: Colors.grey),
      ),
    );
  }
}

class TableScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Table Screen'),
    );
  }
}

class CalendarScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Calendar Screen'),
    );
  }
}

class TimelineScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Timeline Screen'),
    );
  }
}

class ProjectScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('My Project Screen'),
    );
  }
}*/