import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:front/constants/app_constants.dart';
import 'package:front/helpers/config.dart';
import 'package:front/models/task/AddTask-req.dart';
import 'package:front/models/task/GetAllTask-res.dart';
import 'package:front/models/task/GetTask-res.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class TaskHelper {
  static http.Client client = http.Client();

  static Future<bool> addTask(AddTaskReq taskData) async {
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'token': 'Bearer $token',
    };

    final url = Uri.http(Config.apiUrl, Config.AddTask);
    final response = await client.post(
      url,
      headers: requestHeaders,
      body: addTaskReqToJson(taskData),
    );

    // Check if the response was successful and return true, otherwise return false
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  static Future<GetTaskRes> getTask(String TaskId) async {
    //try {
    final requestHeaders = <String, String>{
      'Content-Type': 'application/json',
    };

    final url = Uri.http(Config.apiUrl, "${Config.GetTaskid}/$TaskId");
    print(url);
    final response = await client.get(
      url,
      headers: requestHeaders,
    );

    //print("halala ${response.statusCode}");

    if (response.statusCode == 200) {
      var task = getTaskResFromJson(response.body);
      //  print("bbessanm855");
      return task;
    } else {
      throw Exception('Failed to get a task');
    }
  }

  static Future<List<GetAllTaskRes>> getAllTasks(String jobid) async {
    try {
      final requestHeaders = <String, String>{
        'Content-Type': 'application/json',
      };

      //  final url = Uri.http(Config.apiUrl, '/api/Task?jobid=$jobid');
      final url = Uri.parse('http://${Config.apiUrl}/api/Task?jobid=$jobid');

      final response = await client.get(
        url,
        headers: requestHeaders,
      );

      if (response.statusCode == 200) {
        final tasksList = getAllTaskResFromJson(response.body);
        return tasksList;
      } else {
        throw Exception('Failed to get the tasks');
      }
    } catch (e) {
      throw Exception('Error occurred while getting tasks: $e');
    }
  }

  static Future<List<GetAllTaskRes>> getAllTasksbymem(String memid) async {
    try {
      final requestHeaders = <String, String>{
        'Content-Type': 'application/json',
      };

      final url =
          Uri.parse('http://${Config.apiUrl}/api/Task/member?memberId=$memid');
      final response = await client.get(
        url,
        headers: requestHeaders,
      );

      if (response.statusCode == 200) {
        final tasksList = getAllTaskResFromJson(response.body);
        return tasksList;
      } else {
        throw Exception('Failed to get the tasks');
      }
    } catch (e) {
      throw Exception('Error occurred while getting tasks: $e');
    }
  }

  /* static Future<List<GetAllTaskRes>> getAllTasksbymem(String memid) async {
    try {
      final requestHeaders = <String, String>{
        'Content-Type': 'application/json',
      };

      //  final url = Uri.http(Config.apiUrl, '/api/Task?jobid=$jobid');
      final url =
          Uri.parse('http://${Config.apiUrl}/api/Task/member?memberId=$memid');
      print("hhhalaa");

      final response = await client.get(
        url,
        headers: requestHeaders,
      );

      if (response.statusCode == 200) {
        final tasksList = getAllTaskResFromJson(response.body);
        print("halaaa retal${tasksList.length}");

        return tasksList;
      } else {
        throw Exception('Failed to get the tasks');
      }
    } catch (e) {
      throw Exception('Error occurred while getting tasks: $e');
    }
  }*/

/*  static Future<void> addMember(String memberName, String taskId) async {
    final requestHeaders = <String, String>{
      'Content-Type': 'application/json',
    };

    final url = Uri.parse('http://${Config.apiUrl}/api/Task/addMember');
    print(url);

    final response = await client.post(
      url,
      headers: requestHeaders,
      body: jsonEncode({'taskId': taskId, 'memberName': memberName}),
    );

    print(response.statusCode);
    if (response.statusCode == 200) {
      Get.snackbar(
        'member added',
        "",
        colorText: Color(kLight.value),
        backgroundColor: Colors.green,
        icon: const Icon(Icons.add_alert),
      );
    } else {
      Get.snackbar(
        'faild to add member',
        "",
        colorText: Color(kLight.value),
        backgroundColor: Colors.red,
        icon: const Icon(Icons.add_alert),
      );
    }
  }
*/

  static Future<bool> addMember(String taskId, String memberName) async {
    try {
      final requestHeaders = <String, String>{
        'Content-Type': 'application/json',
      };

      final url = Uri.http(Config.apiUrl, "${Config.task}$taskId/addMember");
      final body = jsonEncode({"memberName": memberName});

      final response = await client.put(
        url,
        headers: requestHeaders,
        body: body,
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e, s) {
      debugPrint('Error Occurred: -------------- $e ---------------');
      debugPrintStack(stackTrace: s);
      return false;
    }
  }

  static Future<String> countTasksByJob(String jobId) async {
    try {
      final url = Uri.parse('http://${Config.apiUrl}/api/Task/count/$jobId');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final responseData = response.body;
        final parsedData = json.decode(responseData); // Parse JSON data
        final taskCount = parsedData['taskCount']; // Extract task count
        return taskCount.toString(); // Return task count as string
      } else {
        throw Exception('Failed to load data');
      }
    } catch (error) {
      throw error;
    }
  }

  static Future<List<GetAllTaskRes>> getToDoTasksByJobId(String jobid) async {
    try {
      final requestHeaders = <String, String>{
        'Content-Type': 'application/json',
      };

      final url = Uri.parse('http://${Config.apiUrl}/api/Task/todo/$jobid');

      final response = await client.get(
        url,
        headers: requestHeaders,
      );

      if (response.statusCode == 200) {
        final tasksList = getAllTaskResFromJson(response.body);
        print("todo${tasksList.length}");
        return tasksList;
      } else {
        throw Exception('Failed to get the tasks');
      }
    } catch (e) {
      throw Exception('Error occurred while getting tasks: $e');
    }
  }

  static Future<List<GetAllTaskRes>> getToDoTasksBymember(String memid) async {
    try {
      final requestHeaders = <String, String>{
        'Content-Type': 'application/json',
      };

      final url =
          Uri.parse('http://${Config.apiUrl}/api/Task/todo/member/$memid');

      final response = await client.get(
        url,
        headers: requestHeaders,
      );

      if (response.statusCode == 200) {
        final tasksList = getAllTaskResFromJson(response.body);
        print("todo${tasksList.length}");
        return tasksList;
      } else {
        throw Exception('Failed to get the tasks');
      }
    } catch (e) {
      throw Exception('Error occurred while getting tasks: $e');
    }
  }

  static Future<List<GetAllTaskRes>> getinProgressTasksByJobId(
      String jobid) async {
    try {
      final requestHeaders = <String, String>{
        'Content-Type': 'application/json',
      };

      final url =
          Uri.parse('http://${Config.apiUrl}/api/Task/inProgress/$jobid');

      final response = await client.get(
        url,
        headers: requestHeaders,
      );

      if (response.statusCode == 200) {
        final tasksList = getAllTaskResFromJson(response.body);
        print("inpro${tasksList.length}");
        return tasksList;
      } else {
        throw Exception('Failed to get the tasks');
      }
    } catch (e) {
      throw Exception('Error occurred while getting tasks: $e');
    }
  }

  static Future<List<GetAllTaskRes>> getinProgressTasksBymem(
      String memid) async {
    try {
      final requestHeaders = <String, String>{
        'Content-Type': 'application/json',
      };

      final url = Uri.parse(
          'http://${Config.apiUrl}/api/Task/inProgress/member/$memid');

      final response = await client.get(
        url,
        headers: requestHeaders,
      );

      if (response.statusCode == 200) {
        final tasksList = getAllTaskResFromJson(response.body);
        print("inpro${tasksList.length}");
        return tasksList;
      } else {
        throw Exception('Failed to get the tasks');
      }
    } catch (e) {
      throw Exception('Error occurred while getting tasks: $e');
    }
  }

  static Future<List<GetAllTaskRes>> getunderReviewTasksByJobId(
      String jobid) async {
    try {
      final requestHeaders = <String, String>{
        'Content-Type': 'application/json',
      };

      final url =
          Uri.parse('http://${Config.apiUrl}/api/Task/underReview/$jobid');

      final response = await client.get(
        url,
        headers: requestHeaders,
      );

      if (response.statusCode == 200) {
        final tasksList = getAllTaskResFromJson(response.body);
        print("under${tasksList.length}");
        return tasksList;
      } else {
        throw Exception('Failed to get the tasks');
      }
    } catch (e) {
      throw Exception('Error occurred while getting tasks: $e');
    }
  }

  static Future<List<GetAllTaskRes>> getunderReviewTasksBymem(
      String memid) async {
    try {
      final requestHeaders = <String, String>{
        'Content-Type': 'application/json',
      };

      final url = Uri.parse(
          'http://${Config.apiUrl}/api/Task/underReview/member/$memid');

      final response = await client.get(
        url,
        headers: requestHeaders,
      );

      if (response.statusCode == 200) {
        final tasksList = getAllTaskResFromJson(response.body);
        print("under${tasksList.length}");
        return tasksList;
      } else {
        throw Exception('Failed to get the tasks');
      }
    } catch (e) {
      throw Exception('Error occurred while getting tasks: $e');
    }
  }

  static Future<List<GetAllTaskRes>> getdoneTasksByJobId(String jobid) async {
    try {
      final requestHeaders = <String, String>{
        'Content-Type': 'application/json',
      };

      final url = Uri.parse('http://${Config.apiUrl}/api/Task/done/$jobid');

      final response = await client.get(
        url,
        headers: requestHeaders,
      );

      if (response.statusCode == 200) {
        final tasksList = getAllTaskResFromJson(response.body);
        print("done${tasksList.length}");
        return tasksList;
      } else {
        throw Exception('Failed to get the tasks');
      }
    } catch (e) {
      throw Exception('Error occurred while getting tasks: $e');
    }
  }

  static Future<List<GetAllTaskRes>> getdoneTasksBymem(String memid) async {
    try {
      final requestHeaders = <String, String>{
        'Content-Type': 'application/json',
      };

      final url =
          Uri.parse('http://${Config.apiUrl}/api/Task/done/member/$memid');

      final response = await client.get(
        url,
        headers: requestHeaders,
      );

      if (response.statusCode == 200) {
        final tasksList = getAllTaskResFromJson(response.body);
        print("done${tasksList.length}");
        return tasksList;
      } else {
        throw Exception('Failed to get the tasks');
      }
    } catch (e) {
      throw Exception('Error occurred while getting tasks: $e');
    }
  }

  static Future<void> setTaskToDo(String taskId) async {
    try {
      final response = await http.put(
        Uri.parse('http://${Config.apiUrl}/api/Task/setTodo/$taskId'),
      );

      print(response.statusCode);

      if (response.statusCode != 200) {
        throw Exception('Failed to set task to TODO');
      }
    } catch (e) {
      throw Exception('Failed to set task to TODO: $e');
    }
  }

  static Future<void> setTaskInProgress(String taskId) async {
    try {
      final response = await http.put(
        Uri.parse('http://${Config.apiUrl}/api/Task/setInProgress/$taskId'),
      );
      print(response.statusCode);
      if (response.statusCode != 200) {
        throw Exception('Failed to set task to InProgress');
      }
    } catch (e) {
      throw Exception('Failed to set task to InProgress: $e');
    }
  }

  static Future<void> setTaskUnderReview(String taskId) async {
    try {
      final response = await http.put(
        Uri.parse('http://${Config.apiUrl}/api/Task/setUnderReview/$taskId'),
      );
      print(response.statusCode);
      if (response.statusCode != 200) {
        throw Exception('Failed to set task to UnderReview');
      }
    } catch (e) {
      throw Exception('Failed to set task to UnderReview: $e');
    }
  }

  static Future<void> setTaskDone(String taskId) async {
    try {
      final response = await http.put(
        Uri.parse('http://${Config.apiUrl}/api/Task/setDone/$taskId'),
      );
      print(response.statusCode);
      if (response.statusCode != 200) {
        throw Exception('Failed to set task to Done');
      }
    } catch (e) {
      throw Exception('Failed to set task to Done: $e');
    }
  }

  static Future<String> countDoneTasksByJob(String jobid) async {
    final url = Uri.parse('http://${Config.apiUrl}/api/Task/done/count/$jobid');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final responseData = response.body;
      final parsedData = json.decode(responseData);
      final doneTaskCount = parsedData['doneTaskCount'];
      print(doneTaskCount.toString());
      return doneTaskCount.toString();
    } else {
      throw Exception('Failed to load data');
    }
  }
}
