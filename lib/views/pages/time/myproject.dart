import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:front/views/common/app_bar.dart';
import 'package:front/views/common/drawer_widget.dart';

class myproject extends StatefulWidget {
  const myproject({super.key});

  @override
  State<myproject> createState() => _myprojectState();
}

class _myprojectState extends State<myproject> {
  @override
  Widget build(BuildContext context) {
     return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.h),
        child: CustomAppBar(
          text: "MyProject",
          child: Padding(
            padding: EdgeInsets.all(12.0.h),
            child: const DrawerWidget(),
          ),
        ),
      ),
    );
  }
}