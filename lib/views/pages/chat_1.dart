import 'package:chat_bubbles/bubbles/bubble_special_three.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:front/constants/app_constants.dart';

import 'package:front/models/chat_model.dart';
import 'package:front/constants/const.dart';
import 'package:front/views/common/app_bar.dart';
import 'package:front/views/common/drawer_widget.dart';

class chat_1 extends StatefulWidget {
  const chat_1({Key? key}) : super(key: key);

  @override
  State<chat_1> createState() => _chat_1();
}

class _chat_1 extends State<chat_1> {
  bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= 600;

  bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < 600;

  @override
  Widget build(BuildContext context) {
    TextEditingController text = TextEditingController();

    String myname = 'chat_1';
    

    if (isMobile(context)) {
      return Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(50.h),
            child: CustomAppBar(
              text: "Chats",
           child: Padding(
                padding: EdgeInsets.all(12.0.h),
                child: const DrawerWidget(),
              ),
            ),
          ),








          
        body: Container(
            color: Colors.white,
            child: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: Chat1.length,
                    itemBuilder: (_, index) => BubbleSpecialThree(
                      isSender:
                          Chat1[index].sender_name == myname ? true : false,
                      text: Chat1[index].text.toString(),
                      color: Chat1[index].sender_name == myname
                          ? Colors.black26
                          : Colors.blueAccent,
                      tail: true,
                      textStyle: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ),
                Container(
                    padding: EdgeInsets.all(15),
                    color: Color(kOrange.value),
                    height: 100,
                    child: Row(
                      children: [
                        Expanded(
                            child: TextField(
                          controller: text,
                          style: TextStyle(color: Colors.white),
                        )),
                        IconButton(
                            onPressed: () {
                              setState(() {
                                Chat1.add(model_chat(text.text, myname));
                                text.text = "";
                              });
                            },
                            icon: Icon(
                              Icons.send,
                              color: Colors.white,
                            ))
                      ],
                    ))
              ],
            )),
      );
    }

   return Container();



  }
}
