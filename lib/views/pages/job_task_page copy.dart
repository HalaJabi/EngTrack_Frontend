

/*
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:front/helpers/Task_helper.dart';
import 'package:front/helpers/UserManger.dart';
import 'package:front/helpers/auth_helper.dart';
import 'package:front/helpers/jop_helper.dart';
import 'package:front/models/myjob-res.dart';
import 'package:front/models/response/auth/user.dart';
import 'package:front/views/pages/gannt.dart';
import 'package:front/views/pages/homepage.dart';

import 'package:front/views/pages/time/Home_task.dart'; 
import 'package:front/views/pages/time/gant_copy.dart';

import 'package:front/views/pages/time/home_screen_todo_list%20copy.dart';
import 'package:front/views/pages/time/home_screen_todo_list.dart';
import 'package:get/get.dart';

class JobTaskPageuser extends StatefulWidget {
  const JobTaskPageuser({required this.job, this.onTap, Key? key})
      : super(key: key);

  final MyjobRes? job;
  final void Function()? onTap;

  @override
  _JobTaskPageuserState createState() => _JobTaskPageuserState();
}

class _JobTaskPageuserState extends State<JobTaskPageuser> {
  String count='';
    String result='';
 
   
 
  @override
  Widget build(BuildContext context) {
     double countNumber = double.tryParse(count) ?? 0;
    double resultNumber = double.tryParse(result) ?? 0;

    double resultDivision = (resultNumber / countNumber) * 100;

    return GestureDetector(
      onTap: () {
        setState(() {});
        widget.onTap?.call();
      },
      child: Container(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Stack(
                children: [
                  Container(
                    height: 200,
                    width: 350,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Color.fromARGB(255, 255, 225, 208),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FutureBuilder<List<String>>(
                          future: JobsHelper.getMembersByJobId(widget.job!.id),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return CircularProgressIndicator();
                            } else if (snapshot.hasError) {
                              return Text('Error: ${snapshot.error}');
                            } else if (snapshot.hasData) {
                              final List<String> members = snapshot.data!;
                              return Row(
                                children: members.map((memberId) {
                                  return FutureBuilder<UserModel?>(
                                    future: AuthHelper.getUserById(memberId),
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        return CircularProgressIndicator();
                                      } else if (snapshot.hasError) {
                                        return Text('Error: ${snapshot.error}');
                                      } else if (snapshot.hasData) {
                                        final UserModel user = snapshot.data!;
                                        return Row(
                                          children: [
                                            Padding(
                                              padding:
                                                  EdgeInsets.only(left: 10),
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(25),
                                                child: CircleAvatar(
                                                  backgroundColor: Colors.amber,
                                                  radius: 20,
                                                  foregroundImage: NetworkImage(
                                                      user.profile ?? ''),
                                                ),
                                              ),
                                            ),
                                          ],
                                        );
                                      } else {
                                        return SizedBox();
                                      }
                                    },
                                  );
                                }).toList(),
                              );
                            } else {
                              return SizedBox();
                            }
                          },
                        ),
                        Spacer(),
                    Padding(
  padding: EdgeInsets.only(top: 10),
  child: Container(
    height: 40,
    width: 40, // Adjusted width to match the height for a circle
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      border: Border.all(
        color: Color.fromARGB(255, 255, 255, 255),
        width: 2,
      ),
    ),
   
    child: Center(
      child: Text(
        '${resultDivision}', // Replace with the actual text you want to display
        style: TextStyle(
          color: Colors.black, // Adjust the text color if needed
          fontSize: 14, // Adjust the font size if needed
        ),
      ),
    ),
  ),
),

                      ],
                    ),
                  ),
                  Positioned(
                    top: 100, // Adjust as needed
                    child: Padding(
                      padding: EdgeInsets.only(top: 30),
                      child: Container(
                        height: 25,
                        width: 80,
                        color: Color.fromARGB(255, 255, 225, 208),
                        child: Center(
                          child: FutureBuilder<String>(
                            future: TaskHelper.countTasksByJob(widget.job!.id),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return CircularProgressIndicator();
                              } else if (snapshot.hasError) {
                                return Text('Error: ${snapshot.error}');
                              } else {
                                count = snapshot.data ?? '0';

                                return FutureBuilder<String>(
                                  future: TaskHelper.countDoneTasksByJob(
                                      widget.job!.id),
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return CircularProgressIndicator();
                                    } else if (snapshot.hasError) {
                                      return Text('Error: ${snapshot.error}');
                                    } else {
                                       result = snapshot.data ?? '0';
                                      return Text('$result / $count Tasks');
                                    }
                                  },
                                );
                              }
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 10,
                    right: 110,
                    child: FloatingActionButton(
                      onPressed: () {
                        Get.to(() => HomeScreencopy(job: widget.job));
                      },
                      backgroundColor: Colors.white,
                      mini: true,
                      child: Icon(Icons.manage_history),
                    ),
                  ),
                  Positioned(
                    bottom: 10,
                    right: 60,
                    child: FloatingActionButton(
                      onPressed: () {
                        Get.to(() => gannt_chart_copy(jobid: widget.job!.id));
                      },
                      backgroundColor: Colors.white,
                      mini: true,
                      child: Icon(CupertinoIcons.chart_bar),
                    ),
                  ),
                ],
              ),
            ),
            if (widget.job!.title != null)
              Text(
                '${widget.job!.title}',
                style: TextStyle(
                  color: Color.fromARGB(255, 255, 255, 255),
                  fontSize: 20,
                ),
              ),
            if (widget.job!.period != null)
              Text(
                '${widget.job!.period}',
                style: TextStyle(
                  color: Color.fromARGB(255, 255, 255, 255),
                  fontSize: 15,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
*/

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:front/helpers/Task_helper.dart';
import 'package:front/helpers/UserManger.dart';
import 'package:front/helpers/auth_helper.dart';
import 'package:front/helpers/jop_helper.dart';
import 'package:front/models/myjob-res.dart';
import 'package:front/models/response/auth/user.dart';
import 'package:front/views/pages/gannt.dart';
import 'package:front/views/pages/homepage.dart';

import 'package:front/views/pages/time/Home_task.dart';
import 'package:front/views/pages/time/gant_copy.dart';

import 'package:front/views/pages/time/home_screen_todo_list%20copy.dart';
import 'package:front/views/pages/time/home_screen_todo_list.dart';
import 'package:get/get.dart';

class JobTaskPageuser extends StatefulWidget {
  const JobTaskPageuser({required this.job, this.onTap, Key? key})
      : super(key: key);

  final MyjobRes? job;
  final void Function()? onTap;

  @override
  _JobTaskPageuserState createState() => _JobTaskPageuserState();
}

class _JobTaskPageuserState extends State<JobTaskPageuser> {
  String count = '';
  String result = '';

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {});
        widget.onTap?.call();
      },
      child: Container(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Stack(
                children: [
                  Container(
                    height: 200,
                    width: 350,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Color.fromARGB(255, 255, 225, 208),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FutureBuilder<List<String>>(
                          future: JobsHelper.getMembersByJobId(widget.job!.id),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return CircularProgressIndicator();
                            } else if (snapshot.hasError) {
                              return Text('Error: ${snapshot.error}');
                            } else if (snapshot.hasData) {
                              final List<String> members = snapshot.data!;
                              return Row(
                                children: members.map((memberId) {
                                  return FutureBuilder<UserModel?>(
                                    future: AuthHelper.getUserById(memberId),
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        return CircularProgressIndicator();
                                      } else if (snapshot.hasError) {
                                        return Text('Error: ${snapshot.error}');
                                      } else if (snapshot.hasData) {
                                        final UserModel user = snapshot.data!;
                                        return Column(
                                       
                                          children: [
                                            Row(
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.only(left: 10),
                                                  child: ClipRRect(
                                                    borderRadius: BorderRadius.circular(25),
                                                    child: CircleAvatar(
                                                      backgroundColor: Colors.amber,
                                                      radius: 20,
                                                      foregroundImage: NetworkImage(
                                                          user.profile ?? ''),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            
                                              
                                            ),

   SizedBox(height: 20), 
                                              Text(
                '${widget.job!.title}',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                ),
              ),
                                          ],
                                        );
                                      } else {
                                        return SizedBox();
                                      }
                                    },
                                  );
                                }).toList(),
                              );
                            } else {
                              return SizedBox();
                            }
                          },
                        ),
                        Spacer(),
                        Padding(
                          padding: EdgeInsets.only(top: 10),
                          child: FutureBuilder<Map<String, String>>(
                            future: _fetchTaskCounts(widget.job!.id),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState == ConnectionState.waiting) {
                                return CircularProgressIndicator();
                              } else if (snapshot.hasError) {
                                return Text('Error: ${snapshot.error}');
                              } else if (snapshot.hasData) {
                                final countData = snapshot.data!;
                                final double countNumber = double.tryParse(countData['count']!) ?? 0;
                                final double resultNumber = double.tryParse(countData['result']!) ?? 0;
                                final double resultDivision = (countNumber != 0) ? (resultNumber / countNumber) * 100 : 0;

                                return Container(
                                  height: 60,
                                  width: 60,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: Color.fromARGB(255, 255, 255, 255),
                                      width: 2,
                                    ),
                                  ),
                                  child: Center(
                                    child: Text(
                                      '${resultDivision.toStringAsFixed(1)}%',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                );
                              } else {
                                return SizedBox();
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),

    

                  Positioned(
                    top: 100,
                    child: Padding(
                      padding: EdgeInsets.only(top: 30),
                      child: Container(
                        height: 25,
                        width: 80,
                        color: Color.fromARGB(255, 255, 225, 208),
                        child: Center(
                          child: FutureBuilder<Map<String, String>>(
                            future: _fetchTaskCounts(widget.job!.id),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState == ConnectionState.waiting) {
                                return CircularProgressIndicator();
                              } else if (snapshot.hasError) {
                                return Text('Error: ${snapshot.error}');
                              } else if (snapshot.hasData) {
                                final countData = snapshot.data!;
                                count = countData['count']!;
                                result = countData['result']!;

                                return Text('$result / $count Tasks');
                              } else {
                                return SizedBox();
                              }
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 10,
                    right: 110,
                    child: FloatingActionButton(
                      onPressed: () {
                        Get.to(() => HomeScreencopy(job: widget.job));
                      },
                      backgroundColor: Colors.white,
                      mini: true,
                      child: Icon(Icons.manage_history),
                    ),
                  ),
                  Positioned(
                    bottom: 10,
                    right: 60,
                    child: FloatingActionButton(
                      onPressed: () {
                        Get.to(() => gannt_chart_copy(jobid: widget.job!.id));
                      },
                      backgroundColor: Colors.white,
                      mini: true,
                      child: Icon(CupertinoIcons.chart_bar),
                    ),
                  ),
                ],
              ),
            ),
          
       
          ],
        ),
      ),
    );
  }

  Future<Map<String, String>> _fetchTaskCounts(String jobId) async {
    final count = await TaskHelper.countTasksByJob(jobId);
    final result = await TaskHelper.countDoneTasksByJob(jobId);
    return {'count': count, 'result': result};
  }
}
