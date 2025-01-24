import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:front/constants/app_constants.dart';
import 'package:front/constants/theme.dart';
import 'package:front/controllers/Task_provider.dart';
import 'package:front/helpers/Task_helper.dart';
import 'package:front/helpers/jop_helper.dart';
import 'package:front/models/task/GetAllTask-res.dart';

import 'package:front/views/common/app_bar.dart';
import 'package:front/views/common/app_style.dart';
import 'package:front/views/common/button.dart';
import 'package:front/views/common/drawer_widget.dart';
import 'package:front/views/common/task_tile.dart';
import 'package:front/views/pages/time/add_task_page.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
/*
class Tasks extends StatefulWidget {
  final String? jobid;

  const Tasks({this.jobid});

  @override
  TasksState createState() => TasksState();
}

class TasksState extends State<Tasks> {
  DateTime _selectedDate = DateTime.parse(DateTime.now().toString());
  late var notifyHelper;
  bool animate = false;
  double left = 630;
  double top = 900;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    /*_timer = Timer(Duration(milliseconds: 500), () {
      setState(() {
        animate = true;
        left = 30;
        top = top / 3;
      });
    }); */
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => TaskNotifier(),
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: CustomAppBar(
            color: Color(0xFFFAF0E6),
            text: "Tasks",
            child:AppBar(
              
      elevation: 0,
      backgroundColor: context.theme.backgroundColor,
      leading: GestureDetector(
        
        onTap: () {
          Get.back();
        },
        child: Icon(Icons.arrow_back_ios, size: 24),
        
      ),
      actions: const [
        SizedBox(width: 20),
      ],
    )
          ),
        ),
        backgroundColor: Theme.of(context).backgroundColor,
        body: Column(
          children: [
            _addTaskBar(),
            SizedBox(height: 12),
            _showTasks(),
          ],
        ),
      ),
    );
  }

  Widget _addTaskBar() {
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                DateFormat.yMMMMd().format(DateTime.now()),
                style: subHeadingTextStyle,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Today",
                style: headingTextStyle,
              ),
            ],
          ),
          MyButton(
            label: "+ Add Task",
            onTap: () async {
              await Get.to(AddTaskPage(
                jobid: widget.jobid ?? "",
              ));
            },
          ),
        ],
      ),
    );
  }

  Widget _showTasks() {
    
    return FutureBuilder<List<GetAllTaskRes>>(
      future: TaskHelper.getAllTasks(widget.jobid ?? ""),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // While the future is still loading, return a loading indicator or something else
          return CircularProgressIndicator(); // for example
        } else if (snapshot.hasError) {
          // If there's an error with the future, handle it here
          return Text('Error: ${snapshot.error}');
        } else {
          // Once the future is completed, you can access its value using snapshot.data
          List<GetAllTaskRes>? taskList = snapshot.data;

          // Now you can use taskList like a regular List
          return Expanded(
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: taskList!.length,
              itemBuilder: (context, index) {
                final tasks = taskList[index];

                JobsHelper.addtask(widget.jobid ?? "", tasks.id);

                if (tasks != null) {
                  return TaskTile(task: tasks);
                } else {
                  return Container();
                }
              },
            ),
          );
        }
      },
    );
  }

  Widget _noTaskMsg() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
            child: Text(
              "You do not have any tasks yet!",
              textAlign: TextAlign.center,
              style: appstyle(22, Color(kDark.value), FontWeight.w600),
            ),
          ),
          SizedBox(height: 80),
        ],
      ),
    );
  }
}*/
/*

class Tasks extends StatefulWidget {
  final String? jobid;

  const Tasks({this.jobid});

  @override
  TasksState createState() => TasksState();
}

class TasksState extends State<Tasks> {
  DateTime _selectedDate = DateTime.parse(DateTime.now().toString());
  late var notifyHelper;
  bool animate = false;
  double left = 630;
  double top = 900;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    // Initialize any required data or state
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => TaskNotifier(),
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: CustomAppBar(
            color: Color(0xFFFAF0E6),
            text: "Tasks",
            child: AppBar(
              elevation: 0,
              backgroundColor: context.theme.backgroundColor,
              leading: GestureDetector(
                onTap: () {

                  Get.back();
                      Get.back();
                },
                child: Icon(Icons.arrow_back_ios, size: 24),
              ),
              actions: const [
                SizedBox(width: 20),
       
              ],
            ),
          ),
        ),
        backgroundColor: Theme.of(context).backgroundColor,
        body: Column(
          children: [
            _addTaskBar(),
            SizedBox(height: 12),
            _showTasks(),
          ],
        ),
      ),
    );
  }

  Widget _addTaskBar() {
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                DateFormat.yMMMMd().format(DateTime.now()),
                style: subHeadingTextStyle,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Today",
                style: headingTextStyle,
              ),
            ],
          ),
          MyButton(
            label: "+ Add Task",
            onTap: () async {
              await Get.to(AddTaskPage(
                jobid: widget.jobid ?? "",
              ));
            },
          ),
        ],
      ),
    );
  }

  Widget _showTasks() {
    return Expanded(
      child: FutureBuilder<List<GetAllTaskRes>>(
        future: TaskHelper.getAllTasks(widget.jobid ?? ""),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            List<GetAllTaskRes>? taskList = snapshot.data;
            if (taskList == null || taskList.isEmpty) {
              return _noTaskMsg();
            }
            return ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: taskList.length,
              itemBuilder: (context, index) {
                final tasks = taskList[index];
                JobsHelper.addtask(widget.jobid ?? "", tasks.id);
                return TaskTile(task: tasks);
              },
            );
          }
        },
      ),
    );
  }

  Widget _noTaskMsg() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
            child: Text(
              "You do not have any tasks yet!",
              textAlign: TextAlign.center,
              style: appstyle(22, Color(kDark.value), FontWeight.w600),
            ),
          ),
          SizedBox(height: 80),
        ],
      ),
    );
  }
}


*/




import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:front/constants/app_constants.dart';
import 'package:front/constants/theme.dart';
import 'package:front/controllers/Task_provider.dart';
import 'package:front/helpers/Task_helper.dart';
import 'package:front/helpers/jop_helper.dart';
import 'package:front/models/task/GetAllTask-res.dart';
import 'package:front/views/common/app_bar.dart';
import 'package:front/views/common/app_style.dart';
import 'package:front/views/common/button.dart';
import 'package:front/views/common/drawer_widget.dart';
import 'package:front/views/common/task_tile.dart';
import 'package:front/views/pages/time/add_task_page.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class Tasks extends StatefulWidget {
  final String? jobid;

  const Tasks({this.jobid});

  @override
  TasksState createState() => TasksState();
}

class TasksState extends State<Tasks> {
  DateTime _selectedDate = DateTime.parse(DateTime.now().toString());
  late var notifyHelper;
  bool animate = false;
  double left = 630;
  double top = 900;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    // Initialize any required data or state
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => TaskNotifier(),
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: CustomAppBar(
            color: Color(0xFFFAF0E6),
            text: "Tasks",
            child: AppBar(
              elevation: 0,
              backgroundColor: context.theme.backgroundColor,
              leading: GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: Icon(Icons.arrow_back_ios, size: 24),
              ),
              actions: const [
                SizedBox(width: 20),
              ],
            ),
          ),
        ),
        backgroundColor: Theme.of(context).backgroundColor,
        body: Column(
          children: [
            _addTaskBar(),
            SizedBox(height: 12),
            _showTasks(),
          ],
        ),
      ),
    );
  }

  Widget _addTaskBar() {
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                DateFormat.yMMMMd().format(DateTime.now()),
                style: subHeadingTextStyle,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Today",
                style: headingTextStyle,
              ),
            ],
          ),
          MyButton(
            label: "+ Add Task",
            onTap: () async {
              await Get.to(AddTaskPage(
                jobid: widget.jobid ?? "",
              ));
            },
          ),
        ],
      ),
    );
  }

  Widget _showTasks() {
    return Expanded(
      child: FutureBuilder<List<GetAllTaskRes>>(
        future: TaskHelper.getAllTasks(widget.jobid ?? ""),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            List<GetAllTaskRes>? taskList = snapshot.data;
            if (taskList == null || taskList.isEmpty) {
              return _noTaskMsg();
            }
            return ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: taskList.length,
              itemBuilder: (context, index) {
                final tasks = taskList[index];
                JobsHelper.addtask(widget.jobid ?? "", tasks.id);
                return TaskTile(task: tasks);
              },
            );
          }
        },
      ),
    );
  }

  Widget _noTaskMsg() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
            child: Text(
              "You do not have any tasks yet!",
              textAlign: TextAlign.center,
              style: appstyle(22, Color(kDark.value), FontWeight.w600),
            ),
          ),
          SizedBox(height: 80),
        ],
      ),
    );
  }
}
