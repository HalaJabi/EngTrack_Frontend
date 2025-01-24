import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:front/models/myjob-res.dart';
import 'package:front/models/stage_model.dart';
import 'package:front/views/common/app_bar.dart';
import 'package:front/views/common/drawer_widget.dart';
import 'package:front/views/common/screen_title.dart';
import 'package:front/views/common/task_drag_target%20copy.dart';
import 'package:front/views/common/task_drag_target.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';


class HomeScreencopy extends StatelessWidget {

    final MyjobRes? job;

  const HomeScreencopy({super.key, this.job});

  

 

  @override
  Widget build(BuildContext context) {
    
    List<Stage> stages = Stage.stages;

    return Scaffold(
appBar: PreferredSize(
            preferredSize: const Size.fromHeight(50),
            child: CustomAppBar(
              color: Color(0xFFFAF0E6),
              text: "Project Time Mangment",
              child: GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: const Icon(CupertinoIcons.arrow_left),
              ),
            ),
          ),


      
      backgroundColor: const Color(0xFFEEF2F5),
      body: LayoutBuilder(
        builder: (
          BuildContext context,
          BoxConstraints constraints,
        ) 

        {
            return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: _TabletLayout(
                  job:    job,
                constraints: constraints,
                stages: stages,
              ),
            );
        }
        
   
  
      ),
    );
  }
}










class _TabletLayout extends StatelessWidget {
   final MyjobRes? job;
  final BoxConstraints constraints;
  final List<Stage> stages;

  const _TabletLayout({super.key, this.job, required this.constraints, required this.stages});




  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20.0),
      child: Row(
        children: [
         
          const SizedBox(width: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            
              SizedBox(
                height: constraints.maxHeight * 0.8,
                child: TaskDragTargetcopy(
                  job: job  ,
                  stages: stages,
                  constraints: constraints,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }


 } 

   





