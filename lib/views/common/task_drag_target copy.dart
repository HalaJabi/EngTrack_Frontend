import 'package:flutter/material.dart';
import 'package:front/helpers/Task_helper.dart';
import 'package:front/helpers/UserManger.dart';
import 'package:front/models/myjob-res.dart';
import 'package:front/models/stage_model.dart';
import 'package:front/models/task/GetAllTask-res.dart';
import 'package:front/models/task_model.dart';
import 'package:front/views/pages/time/task_D%20copy.dart';
import 'package:front/views/pages/time/task_D.dart';
/*
class TaskDragTarget extends StatefulWidget {
  const TaskDragTarget({
    Key? key,
    required this.stages,
    required this.constraints,
    this.job,
  }) : super(key: key);

  final List<Stage> stages;
  final BoxConstraints constraints;
  final MyjobRes? job;

  @override
  State<TaskDragTarget> createState() => _TaskDragTargetState();
}

class _TaskDragTargetState extends State<agTarget> {
  @override
  void initState() {
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
            child: DragTarget<GetAllTaskRes>(
              builder: (context, candidateTasks, rejectedTasks) {
             
              },
              onAccept: (task) {
                setState(
                  () {
                    GetAllTaskRes newTask = task.copyWith(stage: stage);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _showtodoTasks() {
    return FutureBuilder<List<GetAllTaskRes>>(
      future: TaskHelper.getToDoTasksByJobId(widget.job!.id ?? ""),
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
                if (tasks != null) {
                  tasks.toDo = true;

                  tasks.underReview = false;
                  tasks.inProgress = false;
                  tasks.done = false;
                  return TaskCard(task: tasks);
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

  Widget _showinProgressTasks() {
    return FutureBuilder<List<GetAllTaskRes>>(
      future: TaskHelper.getinProgressTasksByJobId(widget.job!.id ?? ""),
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
                if (tasks != null) {

                   tasks.toDo = false;

                  tasks.underReview = false;
                  tasks.inProgress = true;
                  tasks.done = false;
                  return TaskCard(task: tasks);
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

  Widget _showunderReviewTasks() {
    return FutureBuilder<List<GetAllTaskRes>>(
      future: TaskHelper.getunderReviewTasksByJobId(widget.job!.id ?? ""),
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
                if (tasks != null) {

                   tasks.toDo = false;

                  tasks.underReview = true;
                  tasks.inProgress = false;
                  tasks.done = false;
                  return TaskCard(task: tasks);
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

  Widget _showdoneTasks() {
    return FutureBuilder<List<GetAllTaskRes>>(
      future: TaskHelper.getdoneTasksByJobId(widget.job!.id ?? ""),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // While the future is still loading, return a loading indicator or something else
          return CircularProgressIndicator();
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
                if (tasks != null) {
                   tasks.toDo = false;

                  tasks.underReview = false;
                  tasks.inProgress = false;
                  tasks.done = true;
                  return TaskCard(task: tasks);
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
}
*/
import 'package:flutter/material.dart';
import 'package:front/helpers/Task_helper.dart';
import 'package:front/models/myjob-res.dart';
import 'package:front/models/stage_model.dart';
import 'package:front/models/task/GetAllTask-res.dart';
import 'package:front/models/task_model.dart';
import 'package:front/views/pages/time/task_D.dart';
/*
class TaskDragTarget extends StatefulWidget {
  const TaskDragTarget({
    Key? key,
    required this.stages,
    required this.constraints,
    this.job,
  }) : super(key: key);

  final List<Stage> stages;
  final BoxConstraints constraints;
  final MyjobRes? job;

  @override
  State<TaskDragTarget> createState() => _TaskDragTargetState();
}

class _TaskDragTargetState extends State<TaskDragTarget> {
  @override
  void initState() {
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
            child: DragTarget<GetAllTaskRes>(
              builder: (context, candidateTasks, rejectedTasks) {
                return Container();

                /// _showTasksByStageName(stage.name);
              },
            ),
          ),


        ],
      ),
    );
  }

  Widget _showTasksByStageName(String stageName) {
    switch (stageName) {
      case 'To Do':
        return _showtodoTasks();
      case 'In Progress':
        return _showinProgressTasks();
      case 'Under Review':
        return _showunderReviewTasks();
      case 'Done':
        return _showdoneTasks();
      default:
        return Container();
    }
  }

  Widget _showtodoTasks() {
    return Container(
      child: FutureBuilder<List<GetAllTaskRes>>(
        future: TaskHelper.getToDoTasksByJobId(widget.job!.id ?? ""),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            List<GetAllTaskRes>? taskList = snapshot.data;
            return Expanded(
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: taskList!.length,
                itemBuilder: (context, index) {
                  final tasks = taskList[index];

                  tasks.toDo = true;
                  tasks.underReview = false;
                  tasks.inProgress = false;
                  tasks.done = false;
                  return TaskCard(task: tasks); ////TaskTile
                },
              ),
            );
          }
        },
      ),
    );
  }

  Widget _showinProgressTasks() {
    return FutureBuilder<List<GetAllTaskRes>>(
      future: TaskHelper.getinProgressTasksByJobId(widget.job!.id ?? ""),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          List<GetAllTaskRes>? taskList = snapshot.data;
          return Expanded(
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: taskList!.length,
              itemBuilder: (context, index) {
                final tasks = taskList[index];
                tasks.toDo = false;
                tasks.underReview = false;
                tasks.inProgress = true;
                tasks.done = false;
                return TaskCard(task: tasks);
              },
            ),
          );
        }
      },
    );
  }

  Widget _showunderReviewTasks() {
    return FutureBuilder<List<GetAllTaskRes>>(
      future: TaskHelper.getunderReviewTasksByJobId(widget.job!.id ?? ""),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          List<GetAllTaskRes>? taskList = snapshot.data;
          return Expanded(
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: taskList!.length,
              itemBuilder: (context, index) {
                final tasks = taskList[index];
                tasks.toDo = false;
                tasks.underReview = true;
                tasks.inProgress = false;
                tasks.done = false;
                return TaskCard(task: tasks);
              },
            ),
          );
        }
      },
    );
  }

  Widget _showdoneTasks() {
    return FutureBuilder<List<GetAllTaskRes>>(
      future: TaskHelper.getdoneTasksByJobId(widget.job!.id ?? ""),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          List<GetAllTaskRes>? taskList = snapshot.data;
          return Expanded(
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: taskList!.length,
              itemBuilder: (context, index) {
                final tasks = taskList[index];
                tasks.toDo = false;
                tasks.underReview = false;
                tasks.inProgress = false;
                tasks.done = true;
                return TaskCard(task: tasks);
              },
            ),
          );
        }
      },
    );
  }
}
*/
/*
import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';

import 'package:flutter/material.dart';

class TaskDragTarget extends StatefulWidget {
  const TaskDragTarget({
    Key? key,
    required this.stages,
    required this.constraints,
    this.job,
  }) : super(key: key);

  final List<Stage> stages;
  final BoxConstraints constraints;
  final MyjobRes? job;

  @override
  State<TaskDragTarget> createState() => _TaskDragTargetState();
}

class _TaskDragTargetState extends State<TaskDragTarget> {
  List<GetAllTaskRes> _tasks = [];

  @override
  void initState() {
    super.initState();
    _loadTasks();
  }

  Future<void> _loadTasks() async {
    // Load tasks for each stage
    for (Stage stage in widget.stages) {
      List<GetAllTaskRes> stageTasks = await _getTasksByStage(stage.id);
      setState(() {
        _tasks.addAll(stageTasks);
      });
    }
  }

  Future<List<GetAllTaskRes>> _getTasksByStage(String stageId) async {
    switch (stageId) {
      case 'toDo':
        return await TaskHelper.getToDoTasksByJobId(widget.job!.id ?? "");
      case 'inProgress':
        return await TaskHelper.getinProgressTasksByJobId(widget.job!.id ?? "");
      case 'underReview':
        return await TaskHelper.getunderReviewTasksByJobId(
            widget.job!.id ?? "");
      case 'done':
        return await TaskHelper.getdoneTasksByJobId(widget.job!.id ?? "");
      default:
        return [];
    }
  }

  void _onTaskAccepted(GetAllTaskRes task, String newStageId) {
    setState(() {

      switch (newStageId) {
        case 'toDo':
        TaskHelper.setTaskToDo(task.id);
          break;
        case 'inProgress':
         TaskHelper.setTaskInProgress(task.id);
          break;
        case 'underReview':
         TaskHelper.setTaskUnderReview(task.id);
          break;
        case 'done':
         TaskHelper.setTaskDone(task.id);
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        for (Stage stage in widget.stages)
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: 50.0), // تعديل المسافة حسب الحاجة
            child: SizedBox(
              width: widget.constraints.maxWidth / widget.stages.length,
              child: _buildDragTarget(stage, context),
            ),
          ),
      ],
    );
  }

 Widget _buildDragTarget(Stage stage, BuildContext context) {
  return Container(
    key: ValueKey(stage.id),
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
              style: Theme.of(context).textTheme.headline6!.copyWith(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        Divider(
          color: stage.color,
          height: 20,
          thickness: 2,
        ),
        Expanded(
          child: DragTarget<GetAllTaskRes>(
            onWillAccept: (task) {
              // أضف هنا الخطوط اللازمة لتحديد ما إذا كان بإمكان قبول المهمة
              return true;
            },
            onAccept: (task) {
              _onTaskAccepted(task, stage.id);
            },
            builder: (context, candidateData, rejectedData) {
              return _showTasksByStageId(stage.id);
            },
          ),
        ),
      ],
    ),
  );
}


  Widget _showTasksByStageId(String stageId) {
    List<GetAllTaskRes> tasks = _tasks.where((task) {
      switch (stageId) {
        case 'toDo':
          return task.toDo == true;
        case 'inProgress':
          return task.inProgress == true;
        case 'underReview':
          return task.underReview == true;
        case 'done':
          return task.done == true;
        default:
          return false;
      }
    }).toList();

    return ListView.builder(
      scrollDirection: Axis.vertical,
      itemCount: tasks.length,
      itemBuilder: (context, index) {
        final task = tasks[index];
        return Hero(
          // استخدام معرف المهمة كعلامة فريدة لكل عنصر Hero
          tag: 'task_${task.id}',
          child: TaskCard(task: task),
        );
      },
    );
  }
}
*/

/*
import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';

class TaskDragTarget extends StatefulWidget {
  const TaskDragTarget({
    Key? key,
    required this.stages,
    required this.constraints,
    this.job,
  }) : super(key: key);

  final List<Stage> stages;
  final BoxConstraints constraints;
  final MyjobRes? job;

  @override
  State<TaskDragTarget> createState() => _TaskDragTargetState();
}

class _TaskDragTargetState extends State<TaskDragTarget> {
  List<GetAllTaskRes> _tasks = [];

  @override
  void initState() {
    super.initState();
    _loadTasks();
  }

  Future<void> _loadTasks() async {
    // Load tasks for each stage
    for (Stage stage in widget.stages) {
      List<GetAllTaskRes> stageTasks = await _getTasksByStage(stage.id);
      setState(() {
        _tasks.addAll(stageTasks);
      });
    }
  }

  Future<List<GetAllTaskRes>> _getTasksByStage(String stageId) async {
    switch (stageId) {
      case 'toDo':
        return await TaskHelper.getToDoTasksByJobId(widget.job!.id ?? "");
      case 'inProgress':
        return await TaskHelper.getinProgressTasksByJobId(widget.job!.id ?? "");
      case 'underReview':
        return await TaskHelper.getunderReviewTasksByJobId(
            widget.job!.id ?? "");
      case 'done':
        return await TaskHelper.getdoneTasksByJobId(widget.job!.id ?? "");
      default:
        return [];
    }
  }

  /*void _onTaskAccepted(GetAllTaskRes task, String newStageId) {
    setState(() {
      switch (newStageId) {
        case 'toDo':
          TaskHelper.setTaskToDo(task.id);
          break;
        case 'inProgress':
          TaskHelper.setTaskInProgress(task.id);
          break;
        case 'underReview':
          TaskHelper.setTaskUnderReview(task.id);
          break;
        case 'done':
          TaskHelper.setTaskDone(task.id);
          break;
      }
      _tasks.remove(task); // Remove the task from its previous stage
      _tasks.add(task); // Add the task to the new stage
    });
  }*/

  void _onTaskAccepted(GetAllTaskRes task, String newStageId) {
  setState(() {
    switch (newStageId) {
      case 'toDo':
        TaskHelper.setTaskToDo(task.id);
        break;
      case 'inProgress':
        TaskHelper.setTaskInProgress(task.id);
        break;
      case 'underReview':
        TaskHelper.setTaskUnderReview(task.id);
        break;
      case 'done':
        TaskHelper.setTaskDone(task.id);
        break;
    }
      _tasks.remove(task);
     
    _loadTasks(); // Reload tasks after moving the task to a new stage
  });
}


  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        for (Stage stage in widget.stages)
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: 50.0), // تعديل المسافة حسب الحاجة
            child: SizedBox(
              width: widget.constraints.maxWidth / widget.stages.length,
              child: _buildDragTarget(stage, context),
            ),
          ),
      ],
    );
  }

  Widget _buildDragTarget(Stage stage, BuildContext context) {
    return Container(
      key: ValueKey(stage.id),
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
                    .headline6!
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
            child: DragTarget<GetAllTaskRes>(
              onWillAccept: (task) {
                // أضف هنا الخطوط اللازمة لتحديد ما إذا كان بإمكان قبول المهمة
                return true;
              },
              onAccept: (task) {
                _onTaskAccepted(task, stage.id);
              },
              builder: (context, candidateData, rejectedData) {
                return _showTasksByStageId(stage.id);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _showTasksByStageId(String stageId) {
    List<GetAllTaskRes> tasks = _tasks.where((task) {
      switch (stageId) {
        case 'toDo':
          return task.toDo == true;
        case 'inProgress':
          return task.inProgress == true;
        case 'underReview':
          return task.underReview == true;
        case 'done':
          return task.done == true;
        default:
          return false;
      }
    }).toList();

    return ListView.builder(
      scrollDirection: Axis.vertical,
      itemCount: tasks.length,
      itemBuilder: (context, index) {
        final task = tasks[index];
        return Hero(
          // استخدام معرف المهمة كعلامة فريدة لكل عنصر Hero
          tag: 'task_${task.id}',
          child: TaskCard(task: task),
        );
      },
    );
  }
}
*/




class TaskDragTargetcopy extends StatefulWidget {
  const TaskDragTargetcopy({
    Key? key,
    required this.stages,
    required this.constraints,
    this.job,
  }) : super(key: key);

  final List<Stage> stages;
  final BoxConstraints constraints;
  final MyjobRes? job;

  @override
  State<TaskDragTargetcopy> createState() => _TaskDragTargetcopyState();
}

class _TaskDragTargetcopyState extends State<TaskDragTargetcopy> {
  List<GetAllTaskRes> _tasks = [];

  @override
  void initState() {
    super.initState();
    _loadTasks();
  }

  Future<void> _loadTasks() async {
    // Load tasks for each stage
    List<GetAllTaskRes> allTasks = [];
    for (Stage stage in widget.stages) {
      List<GetAllTaskRes> stageTasks = await _getTasksByStage(stage.id);
      allTasks.addAll(stageTasks);
    }
    setState(() {
      _tasks = allTasks;
    });
  }

  Future<List<GetAllTaskRes>> _getTasksByStage(String stageId) async {
    switch (stageId) {
      case 'toDo':
        return await TaskHelper.getToDoTasksBymember(UserManager.userId ?? "");
      case 'inProgress':
        return await TaskHelper.getinProgressTasksBymem(UserManager.userId?? "");
      case 'underReview':
        return await TaskHelper.getunderReviewTasksBymem(
            UserManager.userId ?? "");
      case 'done':
        return await TaskHelper.getdoneTasksBymem(UserManager.userId ?? "");
      default:
        return [];
    }
  }

  void _onTaskAccepted(GetAllTaskRes task, String newStageId) {
    setState(() {
      switch (newStageId) {
        case 'toDo':
          TaskHelper.setTaskToDo(task.id);
          task.toDo = true;
          task.inProgress = false;
          task.underReview = false;
          task.done = false;
          break;
        case 'inProgress':
          TaskHelper.setTaskInProgress(task.id);
          task.toDo = false;
          task.inProgress = true;
          task.underReview = false;
          task.done = false;
          break;
        case 'underReview':
          TaskHelper.setTaskUnderReview(task.id);
          task.toDo = false;
          task.inProgress = false;
          task.underReview = true;
          task.done = false;
          break;
        case 'done':
          TaskHelper.setTaskDone(task.id);
          task.toDo = false;
          task.inProgress = false;
          task.underReview = false;
          task.done = true;
          break;
      }
      _tasks = List.from(_tasks)..remove(task)..add(task);  // تعديل المهام
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        for (Stage stage in widget.stages)
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal:100.0),
            child: SizedBox(
              width: widget.constraints.maxWidth / widget.stages.length,
              child: _buildDragTarget(stage, context),
            ),
          ),
      ],
    );
  }

  Widget _buildDragTarget(Stage stage, BuildContext context) {
    return Container(
      key: ValueKey(stage.id),
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
                    .headline6!
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
            child: DragTarget<GetAllTaskRes>(
              onWillAccept: (task) {
                return true;
              },
              onAccept: (task) {
                _onTaskAccepted(task, stage.id);
              },
              builder: (context, candidateData, rejectedData) {
                return _showTasksByStageId(stage.id);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _showTasksByStageId(String stageId) {
    List<GetAllTaskRes> tasks = _tasks.where((task) {
      switch (stageId) {
        case 'toDo':
          return task.toDo == true;
        case 'inProgress':
          return task.inProgress == true;
        case 'underReview':
          return task.underReview == true;
        case 'done':
          return task.done == true;
        default:
          return false;
      }
    }).toList();

    return ListView.builder(
      scrollDirection: Axis.vertical,
      itemCount: tasks.length,
      itemBuilder: (context, index) {
        final task = tasks[index];
        return Hero(
          tag: 'task_${task.id}',
          child: TaskCard_copy(task: task),
        );
      },
    );
  }
}


















