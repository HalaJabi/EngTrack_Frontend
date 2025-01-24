// To parse this JSON data, do
//
//     final notReq = notReqFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

NotReq notReqFromJson(String str) => NotReq.fromJson(json.decode(str));

String notReqToJson(NotReq data) => json.encode(data.toJson());

class NotReq {
    final String adminId;
    final String userId;
    final String adminName;
    final String userName;
    final String adminImage;

    NotReq({
        required this.adminId,
        required this.userId,
        required this.adminName,
        required this.userName,
        required this.adminImage,
    });

    factory NotReq.fromJson(Map<String, dynamic> json) => NotReq(
        adminId: json["adminId"],
        userId: json["userId"],
        adminName: json["adminName"],
        userName: json["userName"],
        adminImage: json["adminImage"],
    );

    Map<String, dynamic> toJson() => {
        "adminId": adminId,
        "userId": userId,
        "adminName": adminName,
        "userName": userName,
        "adminImage": adminImage,
    };
}
