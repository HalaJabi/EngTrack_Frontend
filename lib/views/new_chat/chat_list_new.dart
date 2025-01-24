// as home screen

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:front/constants/app_constants.dart';
import 'package:front/constants/chat_api.dart';
import 'package:front/helpers/UserManger.dart';
import 'package:front/helpers/config.dart';
import 'package:front/models/chatm.dart';

import 'package:front/views/common/drawer_widget.dart';

import 'package:front/views/new_chat/chat_user_card.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:front/constants/app_constants.dart';
import 'package:front/helpers/UserManger.dart';
import 'package:front/helpers/config.dart';
import 'package:front/models/chatm.dart';

import 'package:front/views/common/drawer_widget.dart';
import 'package:front/views/new_chat/chat_user_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:front/constants/app_constants.dart';
import 'package:front/helpers/UserManger.dart';
import 'package:front/helpers/config.dart';
import 'package:front/models/chatm.dart';

import 'package:front/views/common/drawer_widget.dart';
import 'package:front/views/new_chat/chat_user_card.dart';

class chat_list extends StatefulWidget {
  @override
  _chat_listState createState() => _chat_listState();
}

class _chat_listState extends State<chat_list> {
  Future<String> getAllDataAsString() async {
    // استرجاع مرجع لجميع البيانات في Firestore
    QuerySnapshot<Map<String, dynamic>> snapshot =
        await FirebaseFirestore.instance.collection('chats').get();

    // إنشاء متغير لتخزين البيانات كنص
    String dataAsString = '';

    // تحويل كل سجل في الاستعلام إلى نص وإضافته إلى المتغير
    snapshot.docs.forEach((doc) {
      dataAsString +=
          doc.data().toString() + '\n'; // يمكنك تعديل هذا النمط حسب احتياجاتك
    });

    return dataAsString;
  }

  void HALAL() async {
    // استدعاء الدالة للحصول على البيانات كنص
    String data = await getAllDataAsString();
    print(data);
  }

  List<ChatUser> list = [];

  final List<ChatUser> searchList = [];

  bool isSearching = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(),
        backgroundColor: Color(k5.value),
        elevation: 0,
        automaticallyImplyLeading: false,
        leadingWidth: 70.w,
        centerTitle: true,
        leading: const DrawerWidget(),
        title: isSearching
            ? TextField(
                decoration: const InputDecoration(
                    border: InputBorder.none, hintText: 'Name, Email, ...'),
                autofocus: true,
                style: const TextStyle(fontSize: 17, letterSpacing: 0.5),
                //when search text changes then updated search list
                onChanged: (val) {
                  //search logic
                  searchList.clear();

                  for (var i in list) {
                    if (i.name.toLowerCase().contains(val.toLowerCase()) ||
                        i.email.toLowerCase().contains(val.toLowerCase())) {
                      searchList.add(i);
                      setState(() {
                        searchList;
                      });
                    }
                  }
                },
              )
            : const Text('Chats'),
        actions: [
          //search user button
          IconButton(
              onPressed: () {
                setState(() {
                  isSearching = !isSearching;
                });
              },
              icon: Icon(Icons.search)),
        ],
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: FloatingActionButton(
            onPressed: () {}, child: const Icon(Icons.add_comment_rounded)),
      ),
      body: StreamBuilder(
        stream: Config.firestore.collection('users').snapshots(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
            case ConnectionState.none:
              return const Center(child: CircularProgressIndicator());
            case ConnectionState.active:
            case ConnectionState.done:
              final data = snapshot.data?.docs;

              HALAL();

              list =
                  data?.map((e) => ChatUser.fromJson(e.data())).toList() ?? [];

              if (list.isNotEmpty) {
                return ListView.builder(
                  itemCount: isSearching ? searchList.length : list.length,
                  padding: EdgeInsets.only(top: height * .02),
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return CardUserChat(
                        user: isSearching ? searchList[index] : list[index]);
                  },
                );
              } else {
                return const Center(
                    child: Text(
                  'No Connection Found!',
                  style: TextStyle(fontSize: 20),
                ));
              }
          }
        },
      ),
    );
  }
}
/*

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:front/constants/app_constants.dart';
import 'package:front/constants/chat_api.dart';
import 'package:front/helpers/UserManger.dart';
import 'package:front/helpers/config.dart';
import 'package:front/models/chatm.dart';
import 'package:front/views/common/drawer_widget.dart';
import 'package:front/views/new_chat/chat_user_card.dart';

class chat_list extends StatefulWidget {
  @override
  _chat_listState createState() => _chat_listState();
}

class _chat_listState extends State<chat_list> {
  List<ChatUser> list = [];
  final List<ChatUser> searchList = [];
  bool isSearching = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(),
        backgroundColor: Color(k5.value),
        elevation: 0,
        automaticallyImplyLeading: false,
        leadingWidth: 70.w,
        centerTitle: true,
        leading: const DrawerWidget(),
        title: isSearching
            ? TextField(
                decoration: const InputDecoration(
                    border: InputBorder.none, hintText: 'Name, Email, ...'),
                autofocus: true,
                style: const TextStyle(fontSize: 17, letterSpacing: 0.5),
                //when search text changes then updated search list
                onChanged: (val) {
                  //search logic
                  searchList.clear();

                  for (var i in list) {
                    if (i.name.toLowerCase().contains(val.toLowerCase()) ||
                        i.email.toLowerCase().contains(val.toLowerCase())) {
                      searchList.add(i);
                      setState(() {
                        searchList;
                      });
                    }
                  }
                },
              )
            : const Text('Chats'),
        actions: [
          //search user button
          IconButton(
              onPressed: () {
                setState(() {
                  isSearching = !isSearching;
                });
              },
              icon: Icon(Icons.search)),
        ],
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: FloatingActionButton(
            onPressed: () {}, child: const Icon(Icons.add_comment_rounded)),
      ),
      body: StreamBuilder(
        stream: Config.firestore.collection('users').snapshots(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
            case ConnectionState.none:
              return const Center(child: CircularProgressIndicator());
            case ConnectionState.active:
            case ConnectionState.done:
              final data = snapshot.data?.docs;

              if (data != null) {
                list.clear(); // Clear the list before adding the filtered users
                for (var e in data) {
                  ChatUser user = ChatUser.fromJson(e.data());
                  String chatId = APIs.getConversationID(user.id);
                  print(chatId);
                  // Check if the chat exists between the current user and this user
                  Config.firestore
                      .collection('chats')
                      .doc(chatId)
                      .get()
                      .then((doc) {
                    if (doc.exists) {
                      setState(() {
                        list.add(user);
                      });
                    }
                  });
                }
              }

              if (list.isNotEmpty) {
                return ListView.builder(
                  itemCount: isSearching ? searchList.length : list.length,
                  padding: EdgeInsets.only(top: height * .02),
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return CardUserChat(
                        user: isSearching ? searchList[index] : list[index]);
                  },
                );
              } else {
                return const Center(
                    child: Text(
                  'No Connection Found!',
                  style: TextStyle(fontSize: 20),
                ));
              }
          }
        },
      ),
    );
  }
}
*/
/*
class chat_list extends StatefulWidget {
  @override
  _chat_listState createState() => _chat_listState();
}

class _chat_listState extends State<chat_list> {
  List<ChatUser> list = [];
  final List<ChatUser> searchList = [];
  bool isSearching = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(),
        backgroundColor: Color(k5.value),
        elevation: 0,
        automaticallyImplyLeading: false,
        leadingWidth: 70.w,
        centerTitle: true,
        leading: const DrawerWidget(),
        title: isSearching
            ? TextField(
                decoration: const InputDecoration(
                    border: InputBorder.none, hintText: 'Name, Email, ...'),
                autofocus: true,
                style: const TextStyle(fontSize: 17, letterSpacing: 0.5),
                //when search text changes then updated search list
                onChanged: (val) {
                  //search logic
                  searchList.clear();

                  for (var i in list) {
                    if (i.name.toLowerCase().contains(val.toLowerCase()) ||
                        i.email.toLowerCase().contains(val.toLowerCase())) {
                      searchList.add(i);
                      setState(() {
                        searchList;
                      });
                    }
                  }
                },
              )
            : const Text('Chats'),
        actions: [
          //search user button
          IconButton(
              onPressed: () {
                setState(() {
                  isSearching = !isSearching;
                });
              },
              icon: Icon(Icons.search)),
        ],
      ),
    
      body: StreamBuilder(
        stream: Config.firestore.collection('users').snapshots(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
            case ConnectionState.none:
              return const Center(child: CircularProgressIndicator());
            case ConnectionState.active:
            case ConnectionState.done:
              final data = snapshot.data?.docs;

              if (data != null) {
                list.clear(); // Clear the list before adding the filtered users
                for (var e in data) {
                  ChatUser user = ChatUser.fromJson(e.data());
                  String chatId = APIs.getConversationID(user.id);
                  print(chatId);
                  // Check if the chat exists between the current user and this user
                  Config.firestore
                      .collection('chats')
                      .doc(chatId)
                      .get()
                      .then((doc) {
                    if (doc.exists) {
                      setState(() {
                        list.add(user);
                      });
                    }
                  });
                }
              }

              print(list.length);
              if (list.isNotEmpty) {
                return ListView.builder(
                  itemCount: isSearching ? searchList.length : list.length,
                  padding: EdgeInsets.only(top: 20.w),
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return CardUserChat(
                        user: isSearching ? searchList[index] : list[index]);
                  },
                );
              } else {
                return const Center(
                    child: Text(
                  'No Connection Found!',
                  style: TextStyle(fontSize: 20),
                ));
              }
          }
        },
      ),
    );
  }
}
*/