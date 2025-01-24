import 'package:chat_bubbles/bubbles/bubble_special_three.dart';
import 'package:flutter/material.dart';
import 'package:front/constants/app_constants.dart';

import 'package:front/models/chat_model.dart';
import 'package:front/constants/const.dart';


class chat_2 extends StatefulWidget {
  const chat_2({super.key});

  @override
  State<chat_2> createState() => _chat_2();
}

class _chat_2 extends State<chat_2> {
  @override
  Widget build(BuildContext context) {
    TextEditingController text = TextEditingController();
    String myname = 'chat_2';
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Color(kOrange.value),
          elevation: 0,
          title: Text('Chats',
              style: TextStyle(
                color: Color(0xFFffffff),
                fontWeight: FontWeight.bold,
              )),
          centerTitle: true),
      body: Container(
          color: Colors.white,
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: Chat1.length,
                  itemBuilder: (_, index) => BubbleSpecialThree(
                    isSender: Chat1[index].sender_name == myname ? true : false,
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
}
