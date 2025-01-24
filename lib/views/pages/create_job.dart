import 'package:flutter/material.dart';
import 'package:front/constants/app_constants.dart';
import 'package:front/helpers/UserManger.dart';
import 'package:front/views/common/app_bar.dart';
import 'package:front/views/common/custom_btn.dart';
import 'package:front/views/common/drawer_widget.dart';
import 'package:front/views/pages/quiz/Add-quiz.dart';
import 'package:front/views/pages/test1.dart';
import 'package:get/get.dart';

class ImagePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: CustomAppBar(
          color: Color(0xFFFAF0E6),
          text: "Create Job",
          child: GestureDetector(
            onTap: () {
              Get.back();
            },
            child: Padding(
              padding: EdgeInsets.all(12.0),
              child: const DrawerWidget(),
            ),
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: AssetImage(
                      'assets/images/job.png'), // يجب استبدالها بمسار الصورة الفعلي
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 20), // المسافة بين الصورة والزر
            // الزر
            CustomButton(
              width: 200,
              height: 50,
              color: Color(kOrange.value),
              onTap: () {
                Get.to(CreateJob());
              },
              text: "Create Job",
            ),
            SizedBox(height: 20),






   
            Text(
              'You Can Create New Job',
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
