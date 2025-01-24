import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:front/constants/app_constants.dart';

import 'package:front/models/chatm.dart';
import 'package:front/views/new_chat/chatScreen.dart';
import 'package:front/main.dart';


class CardUserChat extends StatefulWidget {
  final ChatUser user;
  const CardUserChat({Key? key, required this.user}) : super(key: key);

  @override
  State<CardUserChat> createState() => _CardUserChatState();
}

class _CardUserChatState extends State<CardUserChat> {
  late Size mq;
  @override
  Widget build(BuildContext context) {
 mq = const Size(0, 0);
//mq = MediaQuery.of(context).size;
    
    return Card(
      margin: EdgeInsets.symmetric(horizontal: mq.width, vertical: 4),
      elevation: 0.5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: InkWell(
        onTap: () {
Navigator.push(context,MaterialPageRoute(builder: (_)=>ChatScreen(user: widget.user,)));


        },
        child: ListTile(

          leading:
        
          
          
          ClipRRect(
            borderRadius: BorderRadius.circular(30),

            child: 
            CachedNetworkImage(
                width:50,
                                         height:50,
                    imageUrl: widget.user.image,
            
                  //  placeholder: (context, url) => CircularProgressIndicator(),
                    errorWidget: (context, url, error) => CircleAvatar(
              child: Icon(Icons.person),
            ),
                 ),
          ),








          
          title: Text(
            widget.user.name,
            style: TextStyle(color: kDark),
          ),
      /*    subtitle: Text(
            widget.user.about,
            
            maxLines: 1,
          ),
*/



          trailing:
          Container(width: 15,height: 15,decoration: BoxDecoration(color: Colors.greenAccent.shade400,
          borderRadius: BorderRadius.circular(10)),)
        ),
      ),
    );
  }
}
