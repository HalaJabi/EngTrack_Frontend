/*import 'package:flutter/material.dart';
import 'package:front/constants/app_constants.dart';
import 'package:front/constants/theme.dart';
import 'package:front/views/common/button.dart';
import 'package:front/views/common/input_field.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class AddTaskPage extends StatefulWidget {
  @override
  _AddTaskPageState createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();

  DateTime _selectedDate = DateTime.now();
  String _startTime = DateFormat('hh:mm a').format(DateTime.now()).toString();
  String? _endTime = "9:30 AM";

  int? _selectedRemind; // = null;
  List<int> remindList = [5, 10, 15, 20];

  String? _selectedRepeat; // = null;
  List<String> repeatList = ['None', 'Daily', 'Weekly', 'Monthly'];

  @override
  Widget build(BuildContext context) {
    // _selectedRemind = 5;
    // _selectedRepeat = 'None';
    return Scaffold(
      backgroundColor: context.theme.backgroundColor,
      appBar: _appBar(),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Add Task",
                style: headingTextStyle,
              ),
              SizedBox(height: 8),
              InputField(
                title: "Title",
                hint: "Enter title here.",
                controller: _titleController,
              ),
              InputField(
                title: "Note",
                hint: "Enter note here.",
                controller: _noteController,
              ),
              Row(
                children: [
                  Expanded(
                    child: InputField(
                      title: "Start Date",
                      hint: DateFormat.yMd().format(_selectedDate),
                      widget: IconButton(
                        icon: Icon(
                          Icons.calendar_month_sharp,
                          color: Colors.grey,
                        ),
                        onPressed: () {
                          _getDateFromUser();
                        },
                      ),
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: InputField(
                      title: "End Date",
                      hint: DateFormat.yMd().format(_selectedDate),
                      widget: IconButton(
                        icon: Icon(
                          Icons.calendar_month_sharp,
                          color: Colors.grey,
                        ),
                        onPressed: () {
                          _getDateFromUser();
                        },
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: InputField(
                      title: "End Time",
                      hint: _endTime,
                      widget: IconButton(
                        icon: Icon(
                          Icons.alarm,
                          color: Colors.grey,
                        ),
                        onPressed: () {
                          _getTimeFromUser(isStartTime: false);
                        },
                      ),
                    ),
                  ),
                ],
              ),

              // InputField(
              //   title: "Remind",
              //   hint: "$_selectedRemind minutes early",
              //   widget: Row(
              //     children: [
              //       DropdownButton<String>(
              //         icon: Icon(
              //           Icons.keyboard_arrow_down,
              //           color: Colors.grey,
              //         ),
              //         iconSize: 32,
              //         elevation: 4,
              //         style: subTitleTextStle,
              //         underline: Container(height: 0),
              //         onChanged: (String? newValue) {
              //           setState(() {
              //             _selectedRemind = int.parse(newValue!);
              //           });
              //         },
              //         items: remindList
              //             .map<DropdownMenuItem<String>>((int value) {
              //           return DropdownMenuItem<String>(
              //             value: value.toString(),
              //             child: Text(value.toString()),
              //           );
              //         }).toList(),
              //       ),
              //       SizedBox(width: 6),
              //     ],
              //   ),
              // ),
              // InputField(
              //   title: "Repeat",
              //   hint: _selectedRepeat,
              //   widget: Row(
              //     children: [
              //       Container(
              //         child: DropdownButton<String>(
              //           dropdownColor: Colors.blueGrey,
              //           icon: Icon(
              //             Icons.keyboard_arrow_down,
              //             color: Colors.grey,
              //           ),
              //           iconSize: 32,
              //           elevation: 4,
              //           style: subTitleTextStle,
              //           underline: Container(
              //             height: 6,
              //           ),
              //           onChanged: (String? newValue) {
              //             setState(() {
              //               _selectedRepeat = newValue;
              //             });
              //           },
              //           items: repeatList
              //               .map<DropdownMenuItem<String>>((String value) {
              //             return DropdownMenuItem<String>(
              //               value: value,
              //               child: Text(
              //                 value,
              //                 style: TextStyle(color: Colors.white),
              //               ),
              //             );
              //           }).toList(),
              //         ),
              //       ),
              //       SizedBox(width: 6),
              //     ],
              //   ),
              // ),

              SizedBox(height: 18.0),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  MyButton(
                    label: "Create Task",
                    onTap: () {
                      _validateInputs();
                    },
                  ),
                ],
              ),
              SizedBox(height: 30.0),
            ],
          ),
        ),
      ),
    );
  }

  _validateInputs() {
    if (_titleController.text.isNotEmpty && _noteController.text.isNotEmpty) {
      Get.back();
    } else if (_titleController.text.isEmpty ||
        _noteController.text.isEmpty) {
     /* Get.snackbar(
        "Required",
        "All fields are required.",
        snackPosition: SnackPosition.TOP,
      );*/
        Get.snackbar( "Required",
        "All fields are required.",
          colorText: Color(kLight.value),
          backgroundColor: Colors.red,
          icon: const Icon(Icons.add_alert)); 
                                
    } else {
      print("Something went wrong");
    }
  }

  _appBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: context.theme.backgroundColor,
      leading: GestureDetector(
        onTap: () {
          Get.back();
        },
        child: Icon(Icons.arrow_back_ios, size: 24, color: primaryClr),
      ),
      actions: const [
       
        SizedBox(width: 20),
      ],
    );
  }

  double toDouble(TimeOfDay myTime) => myTime.hour + myTime.minute / 60.0;

  _getTimeFromUser({required bool isStartTime}) async {
    var _pickedTime = await _showTimePicker();
    if (_pickedTime != null) {
      String? _formattedTime = _pickedTime.format(context);
      setState(() {
        if (isStartTime) {
          _startTime = _formattedTime!;
        } else {
          _endTime = _formattedTime!;
        }
      });
    }
  }

  _showTimePicker() async {
    return showTimePicker(
      initialTime: TimeOfDay.now(),
      context: context,
    );
  }

  _getDateFromUser() async {
    final DateTime? _pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (_pickedDate != null) {
      setState(() {
        _selectedDate = _pickedDate;
      });
    }
  }
}

*/
import 'package:flutter/material.dart';
import 'package:front/constants/app_constants.dart';
import 'package:front/constants/theme.dart';
import 'package:front/controllers/Task_provider.dart';
import 'package:front/helpers/jop_helper.dart';
import 'package:front/models/task/AddTask-req.dart';

import 'package:front/views/common/button.dart';
import 'package:front/views/common/input_field.dart';
import 'package:front/views/pages/homepage.dart';
import 'package:front/views/pages/time/Home_task.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class AddTaskPage extends StatefulWidget {

    final String jobid;

  

  const AddTaskPage( {super.key, required this.jobid});



  @override
  _AddTaskPageState createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();
  DateTime _selectedStartDate = DateTime.now();
  DateTime _selectedEndDate = DateTime.now();



  String _startTime = DateFormat('hh:mm a').format(DateTime.now()).toString();
  String? _endTime = "9:30 AM";

  int? _selectedRemind; // = null;
  List<int> remindList = [5, 10, 15, 20];

  //String? _selectedRepeat; // = null;
  //List<String> repeatList = ['None', 'Daily', 'Weekly', 'Monthly'];
 @override
  void dispose() {

    _titleController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.backgroundColor,
      appBar: _appBar(),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Add Task",
                style: headingTextStyle,
              ),
              SizedBox(height: 8),
              InputField(
                title: "Title",
                hint: "Enter title here.",
                controller: _titleController,
              ),
              InputField(
                title: "Note",
                hint: "Enter note here.",
                controller: _noteController,
              ),
              Row(
                children: [
                  Expanded(
                    child: InputField(
                      title: "Start Date",
                      hint: DateFormat.yMd().format(_selectedStartDate),
                      widget: IconButton(
                        icon: Icon(
                          Icons.calendar_today,
                          color: Colors.grey,
                        ),
                        onPressed: () {
                          _getStartDateFromUser();
                        },
                      ),
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: InputField(
                      title: "End Date",
                      hint: DateFormat.yMd().format(_selectedEndDate),
                      widget: IconButton(
                        icon: Icon(
                          Icons.calendar_today,
                          color: Colors.grey,
                        ),
                        onPressed: () {
                          _getEndDateFromUser();
                        },
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: InputField(
                      title: "End Time",
                      hint: _endTime,
                      widget: IconButton(
                        icon: Icon(
                          Icons.alarm,
                          color: Colors.grey,
                        ),
                        onPressed: () {
                          _getTimeFromUser(isStartTime: false);
                        },
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 18.0),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  MyButton(
                    label: "Create Task",
                    onTap: () {
                      _validateInputs();
                    },
                  ),
                ],
              ),
              SizedBox(height: 30.0),
            ],
          ),
        ),
      ),
    );
  }
_validateInputs() {
  if (_titleController.text.isNotEmpty && _noteController.text.isNotEmpty) {
    AddTaskReq model = AddTaskReq( 
      jobid:widget.jobid ,         
      title: _titleController.text,
      note: _noteController.text,
      startDate: _selectedStartDate.toString(),
      endDate: _selectedEndDate.toString(),
      endTime: _endTime!,
    );
    TaskNotifier notifier = TaskNotifier();

     notifier.addTask(model); 



        
   Get.off(Tasks(jobid: widget.jobid));

  }  

  
  else if (_titleController.text.isEmpty || _noteController.text.isEmpty) {
    Get.snackbar(
      "Required",
      "All fields are required.",
      colorText: Color(kLight.value),
      backgroundColor: Colors.red,
      icon: const Icon(Icons.add_alert),
    ); 
  } else {
    print("Something went wrong");
  }
}


  _appBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: context.theme.backgroundColor,
      leading: GestureDetector(
        onTap: () {
          Get.back();
        
        },
        child: Icon(Icons.arrow_back_ios, size: 24, color: primaryClr),
      ),
      actions: const [
        SizedBox(width: 20),
      ],
    );
  }

  double toDouble(TimeOfDay myTime) => myTime.hour + myTime.minute / 60.0;

  _getTimeFromUser({required bool isStartTime}) async {
    var _pickedTime = await _showTimePicker();
    if (_pickedTime != null) {
      String? _formattedTime = _pickedTime.format(context);
      setState(() {
        if (isStartTime) {
          _startTime = _formattedTime!;
        } else {
          _endTime = _formattedTime!;
        }
      });
    }
  }

  _showTimePicker() async {
    return showTimePicker(
      initialTime: TimeOfDay.now(),
      context: context,
    );
  }

  _getStartDateFromUser() async {
    final DateTime? _pickedStartDate = await showDatePicker(
      context: context,
      initialDate: _selectedStartDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (_pickedStartDate != null) {
      setState(() {
        _selectedStartDate = _pickedStartDate;
      });
    }
  }

  _getEndDateFromUser() async {
    final DateTime? _pickedEndDate = await showDatePicker(
      context: context,
      initialDate: _selectedEndDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (_pickedEndDate != null) {
      setState(() {
        _selectedEndDate = _pickedEndDate;
      });
    }
  }
}