import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:front/views/common/app_bar.dart';
import 'package:front/views/common/drawer_widget.dart';
import 'package:front/views/pages/chat_1.dart';
import 'package:front/views/pages/chat_2.dart';


class ChatsPage extends StatefulWidget {
  const ChatsPage({Key? key}) : super(key: key);

  @override
  State<ChatsPage> createState() => _ChatsPage();
}

class _ChatsPage extends State<ChatsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.h),
child: CustomAppBar(
 text: "Chat",
  
   child: Padding(
     padding:  EdgeInsets.all(12.0.h),
     child:const  DrawerWidget(),
   ),
  
  

  
  
  ),

      ),
      body: Container(
          color: Color.fromRGBO(255,255,255,1),
          child: ListView(
            children: [
              InkWell(
                onTap: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) => chat_1()));
                },
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListTile(
                          leading: CircleAvatar(
                              radius: 30, backgroundColor: Colors.black),
                          title: Text('Hala',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold))),
                    ),
                    Divider(
                      color: Colors.black12,
                    )
                  ],
                ),
              ),
              InkWell(
                  onTap: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) => chat_2()));
                },
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListTile(
                          leading: CircleAvatar(
                              radius: 30, backgroundColor: Colors.blue),
                          title: Text('Beesan',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold))),
                    ),
                    Divider(
                      color: Colors.black12,
                    )
                  ],
                ),
              )
            ],
          )),
    );
  }
}
