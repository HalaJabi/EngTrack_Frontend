import 'package:flutter/material.dart';
import 'package:front/constants/app_constants.dart';
import 'package:front/helpers/Task_helper.dart';
import 'package:front/models/task/AddTask-req.dart';
import 'package:front/models/task/GetAllTask-res.dart';
import 'package:front/models/task/GetTask-res.dart';

import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
/*
class TaskNotifier extends ChangeNotifier
{

    late Future<List<GetAllTaskRes>> TaskList;
  late Future<GetTaskRes> Task;

  
   void AddTask(AddTaskReq TaskData) {
  TaskHelper.addTask(TaskData).then((response) {
    if (!response) 
    {
      Get.snackbar(
        'Add Task Failed',
        "Failed to add task. Please check your credentials and try again.",
        colorText: Color(kLight.value),
        backgroundColor: Colors.red,
        icon: const Icon(Icons.add_alert),
      );
    }
  });


  
     getTask(String TaskId) {
    Task = TaskHelper.getTask(TaskId);
  }
  

  getAllTasks() {
    TaskList = TaskHelper.getAllTasks();
  }


}






}
*/
class TaskNotifier extends ChangeNotifier {
  late Future<List<GetAllTaskRes>> taskList;
  late Future<GetTaskRes> taskwithid;



  void addTask(AddTaskReq taskData) {
    TaskHelper.addTask(taskData).then((response) {
      if (!response) {
        Get.snackbar(
          'Add Task Failed',
          "Failed to add task. Please check your credentials and try again.",
          colorText: Color(kLight.value),
          backgroundColor: Colors.red,
          icon: const Icon(Icons.add_alert),
        );
      }
    });
  }



  
  /*void getTask(String TaskId) {
    task = TaskHelper.getTask(TaskId);
  }*/

  /* getAllTasks() {
    taskList = TaskHelper.getAllTasks();
  }*/
}