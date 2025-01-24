// To parse this JSON data, do
//
//     final notRes = notResFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

NotRes notResFromJson(String str) => NotRes.fromJson(json.decode(str));

String notResToJson(NotRes data) => json.encode(data.toJson());

class NotRes {
    final String adminId;
    final String userId;
    final String adminName;
    final String userName;
    final String adminImage;
    final String id;
    final DateTime createdAt;
    final int v;

    NotRes({
        required this.adminId,
        required this.userId,
        required this.adminName,
        required this.userName,
        required this.adminImage,
        required this.id,
        required this.createdAt,
        required this.v,
    });

    factory NotRes.fromJson(Map<String, dynamic> json) => NotRes(
        adminId: json["adminId"] ??'',
        userId: json["userId"] ??'',
        adminName: json["adminName"] ??'',
        userName: json["userName"] ??'',
        adminImage: json["adminImage"] ??'',
        id: json["_id"] ??'',
        createdAt: DateTime.parse(json["createdAt"] ??''),
        v: json["__v"] ??'',
    );

    Map<String, dynamic> toJson() => {
        "adminId": adminId,
        "userId": userId,
        "adminName": adminName,
        "userName": userName,
        "adminImage": adminImage,
        "_id": id,
        "createdAt": createdAt.toIso8601String(),
        "__v": v,
    };
}
