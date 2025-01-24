import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:http/http.dart' as http;
import 'package:googleapis_auth/auth_io.dart' as auth;
//import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:googleapis/servicecontrol/v1.dart' as servicecontrol;
import 'package:provider/provider.dart';

///notification

class PushNotificationService {
  Future<void> initNotifications() async {}

  static Future<String> getAccessToken() async {
    final serviceAccountJson = {
      "type": "service_account",
      "project_id": "final-eng-track",
      "private_key_id": "175bbb166eff6582da557cad761cdd0216fecf12",
      "private_key":
          "-----BEGIN PRIVATE KEY-----\nMIIEvAIBADANBgkqhkiG9w0BAQEFAASCBKYwggSiAgEAAoIBAQC6mlM19X6T1D8o\nfF9b4PPYl58tD/FlAlD0n+wvuJsIGGyt9Bekpu54CLZX50vrb6OADyA31VI/rIVr\nqCIdykHqhd8z+XgiwsEkOHbJGvhOvRAtflrXweoj8K1AzzN5HmSO645V48Lbecqx\nDy4RGeb2XmwDM/hiSFWwH77EFm/7AsOZ5KYqeUqG9jbGGTfK0VFFpSshaMJJz1uR\nyuQ6QzqjbSumxXCfziqjYNvCu/hFV5v1QHohPGDlIDMFTGUgebH57Mryd826+0M3\n1/soHzMiw4PjMJOZ9ssWb9L0LGMXA5WwWC6s91hBf5T19IfpNkPng24Z698LMo9L\n7lgPNMDZAgMBAAECggEAIWScn3tfO3UwGD6pkfefq5L2mUnRGRJhCmXUDnYqyDgW\nusqDsKNu6WwltXVe0LMZv0D1swgpv9tPxQRBlrMrOJzcZKCwLwhLKAAywaph5TVQ\nP9Pszc+V5vibCI4L2BDoTes5fYVUyZHyA92DkOvhuRUMn0YdnPj03J/Rs6WQRIrb\nEPa6ZyQIHF3w+9FBVx1Q8YJiHfwPzyZodcL2F9xboHaTeToaClJfens906xmdy58\n75xyTM06qzLEErtn38zfZfdh91WLTfKVfvgK0sb5ft7szbeQegSJH2igp06A0qCM\n1Vo86un4seZJCZDivlMKCqAvsfCQJVczsWM+BvrJQQKBgQD7/1rB10m9prANz157\neT/zaudHJVFUzv4X3dwrMpSCRelCVi4PikQ4pNFdxwIiKK7okyGm9OkKEmIHFZXo\nYZ/g/mPn/AxLAsBwdfgPIkJQOZYFe3BLTMFd4xmRH+EBn3qXkPCGaT/ycUXJibGP\nDiY8MEMBrIUTABnLbAq7KZlciwKBgQC9kRHZ5NtlwFw4d42+lKcxhn/+hQmBfdMx\noCAOtY4p8Nm9qbPyRoMYewI2wpMylb2Q2Vvm4OXcZuF2NOAqbV8/SJIkpkchjVFz\nB23aUwH8+httXYcLf2QoT+/s9ooRds6BT8vXpmdXPCqJxGe5TzyNLh9eaTR1plo6\nFSxFAxnQqwKBgAQQdUVFFKJjatl+K7bwGLDzW3GRT4N/pyd5Y5CqyyxitkVkoG+N\nulXzipDpocYtQ8zqepN3xb5s13nnxjguQubdE31tWkFndPUbYfnUgp9KnnnOKNx+\nC2xZOlNV4UomaVLCeq6gSfC+FPMQLnXxM3qrCJmhT7Ajw0a9olqsbBXLAoGARTHY\n5EJHW2LVxr7M/I3iYY+I1OzWxW+aUXjzeqsG04RY1oRFbOAUJjFwY3Curj4+Tcsp\nYqMhBEyBa9ZtJM97fuwMfFg9ip+85VIG5TR7e04ICOmky6uacaSMHWD4kNtfEZCB\nBZx2CD+r/1Gz0s57ecUmKh4YygEI2j60RBSXrbUCgYBnRdwHGtavJZDpVQL474Ox\nRQCN/w7YuLIhjE6ZtEYUZ7bAdEcjIaK4U64FqOaOrZgH8DE00p4TdY9jt//5Y2SJ\nHVG3iP7OUQ0bq2NSM1mL+EDHoRmFyu2HOx6ZDMxv02wrkqJOs4byeWpSeoirBpge\nV9r9Kg+sdZO80QFao63eBQ==\n-----END PRIVATE KEY-----\n",
      "client_email": "notification@final-eng-track.iam.gserviceaccount.com",
      "client_id": "111974731685673557896",
      "auth_uri": "https://accounts.google.com/o/oauth2/auth",
      "token_uri": "https://oauth2.googleapis.com/token",
      "auth_provider_x509_cert_url":
          "https://www.googleapis.com/oauth2/v1/certs",
      "client_x509_cert_url":
          "https://www.googleapis.com/robot/v1/metadata/x509/notification%40final-eng-track.iam.gserviceaccount.com",
      "universe_domain": "googleapis.com"
    };
    

    List<String> scopes = [
      "https://www.googleapis.com/auth/firebase.messaging"

    ];

    http.Client client = await auth.clientViaServiceAccount(
        auth.ServiceAccountCredentials.fromJson(serviceAccountJson), scopes);

    auth.AccessCredentials credentials =
        await auth.obtainAccessCredentialsViaServiceAccount(
            auth.ServiceAccountCredentials.fromJson(serviceAccountJson),
            scopes,
            client);

    client.close();

    return credentials.accessToken.data;
  }

  static sendNotificationToSelectedDriver(String deviceToken,String title1,String body1 ) async {
    final String serverAccessTokenKey = await getAccessToken();
    String endpointFirebaseCloudMessaging =
        'https://fcm.googleapis.com/v1/projects/final-eng-track/messages:send'; // تأكد من تصحيح الرابط

    final Map<String, dynamic> message = {
      'message': {
        'token': deviceToken,
        'notification': {
          'title':" $title1",
          'body': "$body1"
        },
      }
    };

    final http.Response response = await http.post(
      Uri.parse(endpointFirebaseCloudMessaging),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $serverAccessTokenKey'
      },
      body: jsonEncode(message),
    );
    print("halaaaaaaaaaaaa");

    print(response.statusCode);

    if (response.statusCode == 200) {
      print('Notification sent successfully');
    } else {
      print('Failed to send notification: ${response.body}');
    }
  }
}
