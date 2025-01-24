/*

import 'package:flutter/material.dart';

import 'package:front/constants/size_config.dart';
import 'package:front/models/GetAllTask-res.dart';
import 'package:front/views/common/sig_user.dart';
import 'package:google_fonts/google_fonts.dart';
/*
class TaskTile extends StatelessWidget {
  //const TaskTile({required this.task});

  //final GetAllTaskRes task;

  @override
  Widget build(BuildContext context) {
   

    return Container(
      padding:
          EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
      width: SizeConfig.screenWidth,
      margin: EdgeInsets.only(bottom: getProportionateScreenHeight(12)),
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              //  if (task.title != null)
                  Text(
             "halaa" ,  //    task.title!,
                    style: GoogleFonts.lato(
                      textStyle: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                SizedBox(
                  height: 12,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.alarm,
                      color: Colors.grey[200],
                      size: 18,
                    ),
                    SizedBox(width: 4),
                    Text(
                      "time",
                      style: GoogleFonts.lato(
                        textStyle:
                            TextStyle(fontSize: 13, color: Colors.grey[100]),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12),
               // if (task.note != null)
                  Text(
                "hhh",  //  task.note!,
                    style: GoogleFonts.lato(
                      textStyle:
                          TextStyle(fontSize: 15, color: Colors.grey[100]),
                    ),
                  ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10),
            height: 60,
            width: 0.5,
            color: Colors.grey[200]!.withOpacity(0.7),
          ),
        ]),
      ),
    );
  }
}

*/

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TaskTile extends StatelessWidget {


  final GetAllTaskRes task;
  const TaskTile({required this.task});
  @override
  Widget build(BuildContext context) {



  





    // حجم الويدجيت الأب الذي يحتوي على TaskTile
    final Size parentSize = MediaQuery.of(context).size;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: parentSize.width * 0.05), // تحديد التباعد الأفقي بنسبة من حجم الويدجيت الأب
      width: parentSize.width,
      margin: EdgeInsets.only(bottom: parentSize.height * 0.02), // تحديد التباعد العمودي بنسبة من حجم الويدجيت الأب
      child: Container(
        padding: EdgeInsets.all(parentSize.width * 0.04), // تحديد التباعد الداخلي بنسبة من حجم الويدجيت الأب
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(parentSize.width * 0.04), // تحديد شكل الحواف بنسبة من حجم الويدجيت الأب
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                     task.title,
                    style: GoogleFonts.lato(
                      textStyle: TextStyle(
                        fontSize: parentSize.width * 0.044, // تحديد حجم النص بنسبة من حجم الويدجيت الأب
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(height: parentSize.height * 0.015),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.alarm,
                        color: Colors.grey[200],
                        size: parentSize.width * 0.04, // تحديد حجم الأيقونة بنسبة من حجم الويدجيت الأب
                      ),
                      SizedBox(width: parentSize.width * 0.01),
                      Text(
                         task.startDate.toString(),
                        style: GoogleFonts.lato(
                          textStyle: TextStyle(
                            fontSize: parentSize.width * 0.033,
                            color: Colors.grey[100],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: parentSize.height * 0.015),
                  Text(
                   task.note,
                    style: GoogleFonts.lato(
                      textStyle: TextStyle(
                        fontSize: parentSize.width * 0.04,
                        color: Colors.grey[100],
                      ),
                    ),
                  ),




/*
   EducationDropdownsignup(
                      
                      controller: _skillController,
                    ),
*/



                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: parentSize.width * 0.027),
              height: parentSize.height * 0.094, // تحديد الارتفاع بنسبة من حجم الويدجيت الأب
              width: parentSize.width * 0.002, // تحديد العرض بنسبة من حجم الويدجيت الأب
              color: Colors.grey[200]!.withOpacity(0.7),
            ),
          ],
        ),
      ),
    );
  }
}
*/


import 'package:flutter/material.dart';
import 'package:front/helpers/jop_helper.dart';
import 'package:front/views/common/drop_down_member.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:flutter/material.dart';

import 'package:front/constants/size_config.dart';
import 'package:front/models/task/GetAllTask-res.dart';
import 'package:front/views/common/sig_user.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TaskTile extends StatelessWidget {
  final GetAllTaskRes task;

  const TaskTile({required this.task});

  @override
  Widget build(BuildContext context) {
    // Get the size of the parent widget
    TextEditingController _memberController = TextEditingController();

    final Future<List<String>> member_to = JobsHelper.getMembersByJobId(task.jobid);

    final Size parentSize = MediaQuery.of(context).size;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: parentSize.width * 0.05),
      width: parentSize.width,
      margin: EdgeInsets.only(bottom: parentSize.height * 0.02),
      child: Container(
        padding: EdgeInsets.all(parentSize.width * 0.04),
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(parentSize.width * 0.04),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    task.title,
                    style: GoogleFonts.lato(
                      textStyle: TextStyle(
                        fontSize: parentSize.width * 0.044,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(height: parentSize.height * 0.015),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.alarm,
                        color: Colors.grey[200],
                        size: parentSize.width * 0.04,
                      ),
                      SizedBox(width: parentSize.width * 0.01),
                      Text(
                        task.startDate.toString(),
                        style: GoogleFonts.lato(
                          textStyle: TextStyle(
                            fontSize: parentSize.width * 0.033,
                            color: Colors.grey[100],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: parentSize.height * 0.015),
                  Text(
                    task.note,
                    style: GoogleFonts.lato(
                      textStyle: TextStyle(
                        fontSize: parentSize.width * 0.04,
                        color: Colors.grey[100],
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: MemberDropdown(
                     
                      _memberController,member_to ,task.id
                    ), // Replace with your MemberDropdown widget
                  ),
                ],
              ),
            ),
            Container(
              margin:
                  EdgeInsets.symmetric(horizontal: parentSize.width * 0.027),
              height: parentSize.height * 0.094,
              width: parentSize.width * 0.002,
              color: Colors.grey[200]!.withOpacity(0.7),
            ),
          ],
        ),
      ),
    );
  }
}
