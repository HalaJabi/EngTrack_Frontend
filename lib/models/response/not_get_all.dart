// To parse this JSON data, do
//
//     final notGetAll = notGetAllFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<NotGetAll> notGetAllFromJson(String str) => List<NotGetAll>.from(json.decode(str).map((x) => NotGetAll.fromJson(x)));

String notGetAllToJson(List<NotGetAll> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class NotGetAll {
    final String id;
    final String adminId;
    final String userId;
    final String adminName;
    final String userName;
    final String adminImage;
    final DateTime createdAt;
    final int v;

    NotGetAll({
        required this.id,
        required this.adminId,
        required this.userId,
        required this.adminName,
        required this.userName,
        required this.adminImage,
        required this.createdAt,
        required this.v,
    });

    factory NotGetAll.fromJson(Map<String, dynamic> json) => NotGetAll(
        id: json["_id"],
        adminId: json["adminId"],
        userId: json["userId"],
        adminName: json["adminName"],
        userName: json["userName"],
        adminImage: json["adminImage"],
        createdAt: DateTime.parse(json["createdAt"]),
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "adminId": adminId,
        "userId": userId,
        "adminName": adminName,
        "userName": userName,
        "adminImage": adminImage,
        "createdAt": createdAt.toIso8601String(),
        "__v": v,
    };
}
