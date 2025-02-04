import 'package:flutter/material.dart';
import 'package:front/models/stage_model.dart';
import 'package:front/models/task_model.dart';
import 'package:front/views/pages/time/task_D.dart';
/*
class Timeline_Page extends StatefulWidget {
  const Timeline_Page({
    Key? key,
    required this.stages,
    required this.constraints,
  }) : super(key: key);

  final List<Stage> stages;
  final BoxConstraints constraints;

  @override
  State<Timeline_Page> createState() => _Timeline_PageState();
}

class _Timeline_PageState extends State<Timeline_Page> {
  late List<Task> tasks;

  @override
  void initState() {
    tasks = Task.tasks;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        for (Stage stage in widget.stages)
          (widget.constraints.maxWidth > 1200)
              ? Expanded(child: _buildDragTarget(stage, context))
              : _buildDragTarget(stage, context),
      ],
    );
  }








  Container _buildDragTarget(Stage stage, BuildContext context) {



    
    List<Task> stageTasks = tasks.where((task) => task.stage == stage).toList();

    return Container(
      margin: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  color: stage.color,
                  borderRadius: BorderRadius.circular(5.0),
                ),
              ),
              const SizedBox(width: 10),
              Text(
                stage.name,
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          Divider(
            color: stage.color,
            height: 20,
            thickness: 2,
          ),
          Expanded(
            child: DragTarget<Task>(
              builder: (context, candidateTasks, rejectedTasks) {
                return Container(
                  width: 300,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: ListView.builder(
                    shrinkWrap: true,
                    controller: ScrollController(),
                    itemCount: stageTasks.length,
                    itemBuilder: (context, index) {
                      return TaskCard(task: stageTasks[index]);
                    },
                  ),
                );
              },
              onAccept: (task) {
                setState(
                  () {
                    Task newTask = task.copyWith(stage: stage);
                    tasks = List.from(tasks)
                      ..remove(task)
                      ..add(newTask);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
*/