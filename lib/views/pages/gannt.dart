import 'package:flutter/material.dart';
import 'package:front/controllers/Task_provider.dart';
import 'package:front/helpers/Task_helper.dart';
import 'package:front/models/myjob-res.dart';
import 'package:front/models/task/GetAllTask-res.dart';
import 'package:gantt_chart/gantt_chart.dart';
import 'package:provider/provider.dart';

/*

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final scrollController = ScrollController();


  @override
  Widget build(BuildContext context) {
    
 return ChangeNotifierProvider(

      create: (_) => TaskNotifier(),
          child: Scaffold(
      appBar: AppBar(
        title: const Text('Plan'),
        backgroundColor: const Color(0xFFFAF0E6),
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(Icons.arrow_back),
        ),
      ),
       



      body: SingleChildScrollView(
        child: Column(
          children: [
           
            //const Divider(),
            GanttChartView(
              scrollPhysics: const BouncingScrollPhysics(),
              stickyAreaWeekBuilder: (context) {
                return const Text(
                  'Project Gantt Chart ',
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 16,
                  ),
                );
              },
              stickyAreaDayBuilder: (context) {
                return AnimatedBuilder(
                  animation: scrollController,
                  builder: (context, _) {
                    final pos = scrollController.positions.firstOrNull;
                    final currentOffset = pos?.pixels ?? 0;
                    final maxOffset =
                        pos?.maxScrollExtent ?? double.infinity;
                    return Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          onPressed: currentOffset > 0
                              ? () {
                                  scrollController.jumpTo(
                                      scrollController.offset - 50);
                                }
                              : null,
                          color: Colors.black,
                          icon: const Icon(
                            Icons.arrow_left,
                            size: 28,
                          ),
                        ),
                        const SizedBox(width: 8),
                        IconButton(
                          onPressed: currentOffset < maxOffset
                              ? () {
                                  scrollController.jumpTo(
                                      scrollController.offset + 50);
                                }
                              : null,
                          color: Colors.black,
                          icon: const Icon(
                            Icons.arrow_right,
                            size: 28,
                          ),
                        ),
                      ],
                    );
                  },
                );
              },
              scrollController: scrollController,
              maxDuration: const Duration(days: 30 * 2),
              startDate: DateTime(2022, 6, 7),
           
              eventHeight: 40,
              stickyAreaWidth: 200,
          
              startOfTheWeek: WeekDay.sunday,
              events: [
                GanttRelativeEvent(
                  relativeToStart: const Duration(days: 0),
                  duration: const Duration(days: 5),
                  displayName: 'Fake Event',
                ),
                GanttRelativeEvent(
                  relativeToStart: const Duration(days: 0),
                  duration: const Duration(days: 5),
                  displayName: '1) This is a very long event name',
                ),
                GanttRelativeEvent(
                  relativeToStart: const Duration(days: 1),
                  duration: const Duration(days: 6),
                  displayName: '2',
                ),
                GanttRelativeEvent(
                  relativeToStart: const Duration(days: 2),
                  duration: const Duration(days: 7),
                  displayName: '3',
                ),
                GanttRelativeEvent(
                  relativeToStart: const Duration(days: 3),
                  duration: const Duration(days: 8),
                  displayName: '4',
                ),
                GanttRelativeEvent(
                  relativeToStart: const Duration(days: 4),
                  duration: const Duration(days: 9),
                  displayName: '5',
                ),
                GanttRelativeEvent(
                  relativeToStart: const Duration(days: 5),
                  duration: const Duration(days: 10),
                  displayName: '6',
                ),
                GanttRelativeEvent(
                  relativeToStart: const Duration(days: 6),
                  duration: const Duration(days: 11),
                  displayName: '7',
                ),
                GanttRelativeEvent(
                  relativeToStart: const Duration(days: 7),
                  duration: const Duration(days: 12),
                  displayName: '8',
                ),
                GanttAbsoluteEvent(
                  displayName: 'Absoulte Date event',
                  startDate: DateTime(2022, 6, 7),
                  endDate: DateTime(2022, 6, 20),
                )
              ],
            ),
          ],
        ),
      ),
    )
    );
  }
}*/

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:front/controllers/Task_provider.dart';
import 'package:gantt_chart/gantt_chart.dart';
import 'package:provider/provider.dart';
/*
class gannt_chart extends StatefulWidget {
  final String? jobid;
  const gannt_chart({Key? key, this.jobid}) : super(key: key);

  @override
  State<gannt_chart> createState() => _gannt_chartState();
}

class _gannt_chartState extends State<gannt_chart> {
  final scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    DateTime currentDate = DateTime.now();

    return ChangeNotifierProvider(
      create: (_) => TaskNotifier(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Plan'),
          backgroundColor: const Color(0xFFFAF0E6),
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(Icons.arrow_back),
          ),
        ),
        body: FutureBuilder<List<GetAllTaskRes>>(
          future: TaskHelper.getAllTasks(widget.jobid ?? ""),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              List<GetAllTaskRes>? taskList = snapshot.data;
              if (taskList == null || taskList.isEmpty) {
                return Center(child: Text('No tasks found'));
              }

              List<GanttRelativeEvent> events = taskList.map((task) {
                Duration relativeStart = task.startDate != null
                    ? task.startDate!.difference(currentDate)
                    : Duration.zero;
                Duration duration = task.endDate != null && task.startDate != null
                    ? task.endDate!.difference(task.startDate!)
                    : Duration(days: 1);

                return GanttRelativeEvent(
                  relativeToStart: relativeStart,
                  duration: duration,
                  displayName: task.title,
               //   child: Icon(Icons.event),
                );
              }).toList();

              return SingleChildScrollView(
                child: Column(
                  children: [
                    GanttChartView(
                      scrollPhysics: const BouncingScrollPhysics(),
                      stickyAreaWeekBuilder: (context) {
                        List<Widget> weekLabels = [];
                        for (int i = 0; i < 5; i++) {
                          weekLabels.add(
                            Container(
                              width: 200 / 5,
                              alignment: Alignment.center,
                              child: Text(
                                'Week ${i + 1}',
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          );
                        }
                        return Row(children: weekLabels);
                      },
                      stickyAreaDayBuilder: (context) {
                        return AnimatedBuilder(
                          animation: scrollController,
                          builder: (context, _) {
                            final pos = scrollController.positions.firstOrNull;
                            final currentOffset = pos?.pixels ?? 0;
                            final maxOffset =
                                pos?.maxScrollExtent ?? double.infinity;
                            return Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                IconButton(
                                  onPressed: currentOffset > 0
                                      ? () {
                                          scrollController.jumpTo(
                                              scrollController.offset - 50);
                                        }
                                      : null,
                                  color: Colors.black,
                                  icon: const Icon(
                                    Icons.arrow_left,
                                    size: 28,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                IconButton(
                                  onPressed: currentOffset < maxOffset
                                      ? () {
                                          scrollController.jumpTo(
                                              scrollController.offset + 50);
                                        }
                                      : null,
                                  color: Colors.black,
                                  icon: const Icon(
                                    Icons.arrow_right,
                                    size: 28,
                                  ),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      scrollController: scrollController,
                      maxDuration: const Duration(days: 30),
                      startDate: currentDate,
                      eventHeight: 40,
                      stickyAreaWidth: 200,
                      startOfTheWeek: WeekDay.sunday,
                      events: events,
                    ),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }
}*/



/*
                  GanttRelativeEvent(
                    relativeToStart: const Duration(days: 0),
                    duration: const Duration(days: 5),
                    displayName: 'Fake Event',
                  ),
                  GanttRelativeEvent(
                    relativeToStart: const Duration(days: 0),
                    duration: const Duration(days: 5),
                    displayName: '1) This is a very long event name',
                  ),
                  GanttRelativeEvent(
                    relativeToStart: const Duration(days: 1),
                    duration: const Duration(days: 6),
                    displayName: '2',
                  ),
                  GanttRelativeEvent(
                    relativeToStart: const Duration(days: 2),
                    duration: const Duration(days: 7),
                    displayName: '3',
                  ),
                  GanttRelativeEvent(
                    relativeToStart: const Duration(days: 3),
                    duration: const Duration(days: 8),
                    displayName: '4',
                  ),
                  GanttRelativeEvent(
                    relativeToStart: const Duration(days: 4),
                    duration: const Duration(days: 9),
                    displayName: '5',
                  ),
                  GanttRelativeEvent(
                    relativeToStart: const Duration(days: 5),
                    duration: const Duration(days: 10),
                    displayName: '6',
                  ),
                  GanttRelativeEvent(
                    relativeToStart: const Duration(days: 6),
                    duration: const Duration(days: 11),
                    displayName: '7',
                  ),
                  GanttRelativeEvent(
                    relativeToStart: const Duration(days: 7),
                    duration: const Duration(days: 12),
                    displayName: '8',
                  ),
                  GanttAbsoluteEvent(
                    displayName: 'Absolute Date event',
                    startDate: currentDate,
                    endDate: currentDate.add(const Duration(days: 13)),
                  )*/


import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:front/controllers/Task_provider.dart';
import 'package:gantt_chart/gantt_chart.dart';
import 'package:provider/provider.dart';
/*
class gannt_chart extends StatefulWidget {
  final String? jobid;
  const gannt_chart({Key? key, this.jobid}) : super(key: key);

  @override
  State<gannt_chart> createState() => _gannt_chartState();
}

class _gannt_chartState extends State<gannt_chart> {
  final scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    DateTime currentDate = DateTime.now();

    return ChangeNotifierProvider(
      create: (_) => TaskNotifier(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Plan'),
          backgroundColor: const Color(0xFFFAF0E6),
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(Icons.arrow_back),
          ),
        ),
        body: FutureBuilder<List<GetAllTaskRes>>(
          future: TaskHelper.getAllTasks(widget.jobid ?? ""),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              List<GetAllTaskRes>? taskList = snapshot.data;
              if (taskList == null || taskList.isEmpty) {
                return Center(child: Text('No tasks found'));
              }

              List<GanttRelativeEvent> events = taskList.map((task) {
                Duration relativeStart = task.startDate != null
                    ? task.startDate!.difference(currentDate)
                    : Duration.zero;
                Duration duration = task.endDate != null && task.startDate != null
                    ? task.endDate!.difference(task.startDate!)
                    : Duration(days: 1);

                return GanttRelativeEvent(
                  relativeToStart: relativeStart,
                  duration: duration,
                  displayName: task.title,
                );
              }).toList();

              return SingleChildScrollView(
                child: Column(
                  children: [
                    const Text(
                      'Project Gantt Chart',
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 16,
                      ),
                    ),
                    GanttChartView(
                      scrollPhysics: const BouncingScrollPhysics(),
                      stickyAreaDayBuilder: (context) {
                        return AnimatedBuilder(
                          animation: scrollController,
                          builder: (context, _) {
                            final pos = scrollController.positions.firstOrNull;
                            final currentOffset = pos?.pixels ?? 0;
                            final maxOffset =
                                pos?.maxScrollExtent ?? double.infinity;
                            return Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                IconButton(
                                  onPressed: currentOffset > 0
                                      ? () {
                                          scrollController.jumpTo(
                                              scrollController.offset - 50);
                                        }
                                      : null,
                                  color: Colors.black,
                                  icon: const Icon(
                                    Icons.arrow_left,
                                    size: 28,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                IconButton(
                                  onPressed: currentOffset < maxOffset
                                      ? () {
                                          scrollController.jumpTo(
                                              scrollController.offset + 50);
                                        }
                                      : null,
                                  color: Colors.black,
                                  icon: const Icon(
                                    Icons.arrow_right,
                                    size: 28,
                                  ),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      scrollController: scrollController,
                      maxDuration: const Duration(days: 30),
                      startDate: currentDate,
                      eventHeight: 40,
                      stickyAreaWidth: 200,
                      startOfTheWeek: WeekDay.sunday,
                      events: events,
                    ),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
*/

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:front/controllers/Task_provider.dart';
import 'package:gantt_chart/gantt_chart.dart';
import 'package:provider/provider.dart';

class gannt_chart extends StatefulWidget {
  final String? jobid;
  const gannt_chart({Key? key, this.jobid}) : super(key: key);

  @override
  State<gannt_chart> createState() => _gannt_chartState();
}

class _gannt_chartState extends State<gannt_chart> {
  final scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    DateTime currentDate = DateTime.now();

    return ChangeNotifierProvider(
      create: (_) => TaskNotifier(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Plan'),
          backgroundColor: const Color(0xFFFAF0E6),
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(Icons.arrow_back),
          ),
        ),
        body: FutureBuilder<List<GetAllTaskRes>>(
          future: TaskHelper.getAllTasks(widget.jobid ?? ""),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              List<GetAllTaskRes>? taskList = snapshot.data;
              if (taskList == null || taskList.isEmpty) {
                return Center(child: Text('No tasks found'));
              }

              List<GanttRelativeEvent> events = taskList.map((task) {
                Duration relativeStart = task.startDate != null
                    ? task.startDate!.difference(currentDate)
                    : Duration.zero;
                Duration duration = task.endDate != null && task.startDate != null
                    ? task.endDate!.difference(task.startDate!)
                    : Duration(days: 1);

                int durationInDays = duration.inDays;

                return GanttRelativeEvent(
                  relativeToStart: relativeStart,
                  duration: duration,
                  displayName: '${task.title} (${durationInDays} days)',
                );
              }).toList();

              return SingleChildScrollView(
                child: Column(
                  children: [
                    const Text(
                      'Project Gantt Chart',
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 16,
                      ),
                    ),
                    GanttChartView(
                      scrollPhysics: const BouncingScrollPhysics(),
                      stickyAreaDayBuilder: (context) {
                        return AnimatedBuilder(
                          animation: scrollController,
                          builder: (context, _) {
                            final pos = scrollController.positions.firstOrNull;
                            final currentOffset = pos?.pixels ?? 0;
                            final maxOffset =
                                pos?.maxScrollExtent ?? double.infinity;
                            return Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                IconButton(
                                  onPressed: currentOffset > 0
                                      ? () {
                                          scrollController.jumpTo(
                                              scrollController.offset - 50);
                                        }
                                      : null,
                                  color: Colors.black,
                                  icon: const Icon(
                                    Icons.arrow_left,
                                    size: 28,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                IconButton(
                                  onPressed: currentOffset < maxOffset
                                      ? () {
                                          scrollController.jumpTo(
                                              scrollController.offset + 50);
                                        }
                                      : null,
                                  color: Colors.black,
                                  icon: const Icon(
                                    Icons.arrow_right,
                                    size: 28,
                                  ),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      scrollController: scrollController,
                      maxDuration: const Duration(days: 30),
                      startDate: currentDate,
                      eventHeight: 40,
                      stickyAreaWidth: 200,
                      startOfTheWeek: WeekDay.sunday,
                      events: events,
                    ),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
