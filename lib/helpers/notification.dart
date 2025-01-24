import 'dart:convert';

import 'package:front/helpers/config.dart';
import 'package:front/models/request/not_req.dart';
import 'package:front/models/response/not_get_all.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Not_Helper {
  static http.Client client = http.Client();

  static Future<bool> create_not(NotReq not) async {
    final prefs = await SharedPreferences.getInstance();

    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };

    final url = Uri.http(Config.apiUrl, "/api/notifications/create");
    final response = await client.post(
      url,
      headers: requestHeaders,
      body: notReqToJson(not),
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  static Future<List<NotGetAll>> getNotificationsByUserId(String userId) async {
    final url = Uri.http(Config.apiUrl, "/api/notifications/user/$userId");
    final response = await client.get(url);
    print(response.statusCode);
    if (response.statusCode == 200) {
      List<dynamic> body = json.decode(response.body);
      List<NotGetAll> notifications =
          body.map((dynamic item) => NotGetAll.fromJson(item)).toList();

      return notifications;
    } else {
      throw Exception('Failed to load notifications');
    }
  }
}
