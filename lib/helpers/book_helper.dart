import 'dart:convert';

import 'package:front/helpers/config.dart';
import 'package:front/models/request/bookmarks/bookmarks_model.dart';
import 'package:front/models/response/bookmarks/book_res.dart';
import 'package:http/http.dart' as http;

import 'package:shared_preferences/shared_preferences.dart';

import '../models/response/bookmarks/all_bookmarks.dart';

class BookMarkHelper {
  static http.Client client = http.Client();

// ADD BOOKMARKS
  static Future<List<dynamic>> addBookmarks(BookmarkReqResModel model) async {
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'token': 'Bearer $token',
    };

    final url = Uri.http(Config.apiUrl, Config.bookmarkUrl);
    final response = await client.post(url,
        headers: requestHeaders, body: jsonEncode(model.toJson()));

    print("add");
    print(response.statusCode);

    if (response.statusCode == 200) {
      final bookmarkId = bookMarkReqResFromJson(response.body).id;
      return [true, bookmarkId];
    } else {
      return [false];
    }
  }

  // DELETE BOOKMARKS
  static Future<bool> deleteBookmarks(String jobId) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'token': 'Bearer $token',
    };

    var url = Uri.http(Config.apiUrl, '${Config.bookmarkUrl}/$jobId');
    var response = await client.delete(
      url,
      headers: requestHeaders,
    );
    print("delete");
    print(response.statusCode);

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }




   static Future<List<AllBookmark>> getBookmarks() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    final requestHeaders = <String, String>{
      'Content-Type': 'application/json',
      'token': 'Bearer $token',
    };

    final url = Uri.http(Config.apiUrl, Config.bookmarkUrl);
    final response = await client.get(
      url,
      headers: requestHeaders,
    );

    if (response.statusCode == 200) {
      final bookmarks = allBookmarkFromJson(response.body);
      return bookmarks;
    } else {
      throw Exception('Failed to load bookmarks');
    }
  }

  
}
