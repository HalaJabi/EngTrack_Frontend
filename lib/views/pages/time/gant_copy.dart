
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:front/controllers/Task_provider.dart';
import 'package:front/helpers/Task_helper.dart';
import 'package:front/helpers/UserManger.dart';
import 'package:front/models/task/GetAllTask-res.dart';
import 'package:gantt_chart/gantt_chart.dart';
import 'package:provider/provider.dart';

class gannt_chart_copy extends StatefulWidget {
  final String? jobid;
  const gannt_chart_copy({Key? key, this.jobid}) : super(key: key);

  @override
  State<gannt_chart_copy> createState() => _gannt_chart_copyState();
}

class _gannt_chart_copyState extends State<gannt_chart_copy> {
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
          future: TaskHelper.getAllTasksbymem(UserManager.userId ?? ""),
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
