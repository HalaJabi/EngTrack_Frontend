import 'package:front/helpers/config.dart';
import 'package:front/models/request/quiz_req.dart';
import 'package:front/models/response/getquiz.dart';
import 'package:front/models/response/jobs/get_job.dart';
import 'package:front/models/response/quiz_res.dart';
import 'package:front/views/pages/MyJopList.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class QuizHelper {
  static http.Client client = http.Client();

  static Future<bool> createquiz(QuizReq quizData) async {
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'token': 'Bearer $token',
    };

    final url = Uri.http(Config.apiUrl, Config.quiz);
    final response = await client.post(
      url,
      headers: requestHeaders,
      body: quizReqToJson(quizData),
    );
    print(response.statusCode);

    if (response.statusCode == 200) {
  
      return true;
    } else {
      return false;
    }
  }

  static Future<GetQuiz> getQuiz(String jobId) async {
    final requestHeaders = <String, String>{
      'Content-Type': 'application/json',
    };

    final url = Uri.http(Config.apiUrl, "${Config.Get_quiz}/$jobId");

    final response = await client.get(
      url,
      headers: requestHeaders,
    );
    print(response.statusCode);
    print(jobId);

    if (response.statusCode == 200) {
      var quiz = getQuizFromJson(response.body);

      return quiz;
    } else {
      throw Exception('Failed to get a job halalaaa');
    }
  }
}
