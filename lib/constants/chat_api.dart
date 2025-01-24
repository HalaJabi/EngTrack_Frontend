import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:front/controllers/login_provider.dart';
import 'package:front/helpers/UserManger.dart';
import 'package:front/helpers/auth_helper.dart';
import 'package:front/helpers/config.dart';
import 'package:front/models/chatm.dart';
import 'package:front/models/msg_model.dart';
import 'package:front/models/profile_model.dart';
import 'package:front/models/response/auth/login_res_model.dart';
import 'package:front/views/new_chat/chatScreen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class APIs {
  static String getConversationID(String id1) {
    String userId2 =
        UserManager.userId; // هنا يمكنك الوصول إلى userId2 داخل الدالة الثابتة
    return userId2.hashCode <= id1.hashCode
        ? '${userId2}_$id1'
        : '${id1}_$userId2';
  }

  // for getting all messages of a specific conversation from firestore database
  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllMessages(
      ChatUser user) {
    return Config.firestore
        .collection('chats/${getConversationID(user.id)}/messages/')
        // .orderBy('sent', descending: true)
        .snapshots();
  }

  // for sending message

  static Future<void> sendMessage(
      ChatUser chatUser, String msg, Type type) async {
    String userId1 = UserManager.userId;
    //message sending time (also used as id)
    final time = DateTime.now().millisecondsSinceEpoch.toString();

    //message to send
    final Message message = Message(
        toId: chatUser.id,
        msg: msg,
        read: '',
        type: type,
        fromId: userId1,
        sent: time);

    final ref = Config.firestore
        .collection('chats/${getConversationID(chatUser.id)}/messages/');
    await ref.doc(time).set(message.toJson());
  }

  //update read status of message
  static Future<void> updateMessageReadStatus(Message message) async {
    Config.firestore
        .collection('chats/${getConversationID(message.fromId)}/messages/')
        .doc(message.sent)
        .update({'read': DateTime.now().millisecondsSinceEpoch.toString()});
  }

  static Future<void> sendChatImage(ChatUser chatUser, File file) async {
    //getting image file extension
    final ext = file.path.split('.').last;

    //storage file ref with path
    final ref = FirebaseStorage.instance.ref().child(
        'images/${getConversationID(chatUser.id)}/${DateTime.now().millisecondsSinceEpoch}.$ext');

    //uploading image
    await ref
        .putFile(file, SettableMetadata(contentType: 'image/$ext'))
        .then((p0) {
      log('Data Transferred: ${p0.bytesTransferred / 1000} kb');
    });

    //updating image in firestore database
    final imageUrl = await ref.getDownloadURL();
    await sendMessage(chatUser, imageUrl, Type.image);
  }
}
