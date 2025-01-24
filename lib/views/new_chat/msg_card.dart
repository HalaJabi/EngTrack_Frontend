import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/material.dart';
import 'package:front/constants/app_constants.dart';
import 'package:front/constants/chat_api.dart';
import 'package:front/main.dart';

import 'package:front/models/chatm.dart';
import 'package:front/models/msg_model.dart';
import 'package:front/views/new_chat/mydate.dart';
class msg_card extends StatefulWidget {
  final Message message;
  final  ChatUser user;
  const msg_card({super.key, required this.message, required this.user});

  @override
  State<msg_card> createState() => _msg_cardState();
}

class _msg_cardState extends State<msg_card> {

  @override
  Widget build(BuildContext context) {
  


  
    return  widget.user.id== widget.message.fromId?_greenMessage() :_blueMessage()  ; }

    Widget _blueMessage() {


        //update last read message if sender and receiver are different
    if (widget.message.read.isEmpty) {
      APIs.updateMessageReadStatus(widget.message);
    }
   return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        //message content
        Flexible(
          child: Container(
            padding: EdgeInsets.all(widget.message.type == Type.image
                ? width * .03
                :width * .04),
            margin: EdgeInsets.symmetric(
                horizontal: width * .04, vertical: height * .01),
            decoration: BoxDecoration(
                color: const Color.fromARGB(255, 221, 245, 255),
                border: Border.all(color: Colors.lightBlue),
                //making borders curved
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                    bottomRight: Radius.circular(30))),
            child: widget.message.type == Type.text
                ?
                //show text
                Text(
                    widget.message.msg,
                    style: const TextStyle(fontSize: 15, color: Colors.black87),
                  )
                :
                //show image
                ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: CachedNetworkImage(
                      imageUrl: widget.message.msg,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: CircularProgressIndicator(strokeWidth: 2),
                      ),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.image, size: 70),
                    ),
                  ),
          ),
        ),

        //message time
        Padding(
          padding: EdgeInsets.only(right:width * .04),
          child: Text(
          MyDateUtil.getFormattedTime(context: context, time: widget.message.sent),
            style: const TextStyle(fontSize: 13, color: Colors.black54),
          ),
        ),
      ],
    );
    }
      Widget _greenMessage() {
      return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [



           //message time
        Row(
         children: [
            //for adding some space
            SizedBox(width: width * .04),

            //double tick blue icon for message read
if (widget.message.read.isNotEmpty)
const Icon(Icons.done_all_rounded,color: Colors.blue,size: 20,),


         //   if (widget.message.read.isNotEmpty)
              const Icon(Icons.done_all_rounded, color: Colors.blue, size: 20),

            //for adding some space
            const SizedBox(width: 2),

            //sent time
            Text(

           MyDateUtil.getFormattedTime(context: context, time: widget.message.sent),
              style: const TextStyle(fontSize: 13, color: Colors.black54),
           ),
          ],
        ),
        //message content
        Flexible(
          child: Container(
            padding: EdgeInsets.all(widget.message.type == Type.image
                ?width * .03
                : width * .04),
            margin: EdgeInsets.symmetric(
                horizontal:width * .04, vertical: height * .01),
            decoration: BoxDecoration(
                color: const Color.fromARGB(255, 218, 255, 176),
                border: Border.all(color: Colors.lightGreen),
                //making borders curved
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                    bottomLeft: Radius.circular(30))),
            child: widget.message.type == Type.text
                ?
                //show text
                Text(
                    widget.message.msg,
                    style: const TextStyle(fontSize: 15, color: Colors.black87),
                  )
                :
                //show image
                ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: CachedNetworkImage(
                      imageUrl: widget.message.msg,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: CircularProgressIndicator(strokeWidth: 2),
                      ),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.image, size: 70),
                    ),
                  ),
          ),
        ),

     
      ],
    );
    }
 
}
