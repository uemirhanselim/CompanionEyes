import 'dart:convert';
import 'package:companioneyes/src/local/local_storage.dart';
import 'package:companioneyes/src/utils/local_storage_keys.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:googleapis_auth/auth_io.dart' as auth;

class PushNotificationsService {
  Future<String> _getAccessToken() async {
    final String response = await rootBundle.loadString('assets/json/ce.json');
    final serviceAccountJson = await json.decode(response);

    List<String> scopes = [
      "https://www.googleapis.com/auth/userinfo.email",
      "https://www.googleapis.com/auth/firebase.database",
      "https://www.googleapis.com/auth/firebase.messaging"
    ];

    http.Client client = await auth.clientViaServiceAccount(
      auth.ServiceAccountCredentials.fromJson(serviceAccountJson),
      scopes,
    );

    // Obtain the access token
    auth.AccessCredentials credentials =
        await auth.obtainAccessCredentialsViaServiceAccount(
            auth.ServiceAccountCredentials.fromJson(serviceAccountJson),
            scopes,
            client);

    // Close the HTTP client
    client.close();

    // Return the access token
    return credentials.accessToken.data;
  }

  Future<void> sendFCMMessage(
      {required String receieverFCMToken, required String roomId, required String definition}) async {
    final String serverKey = await _getAccessToken(); // Your FCM server key
    print("FCM KEY: $serverKey");
    const String fcmEndpoint =
        'https://fcm.googleapis.com/v1/projects/companioneyes/messages:send';
    final currentFCMToken =
        LocalStorageService.instance.getString(LocalStorageKeys.fcmToken);
    print("fcmkey : $currentFCMToken");
    final Map<String, dynamic> message = {
      'message': {
        'token':
            receieverFCMToken, // Token of the device you want to send the message to
        'notification': {
          'body': 'Requested Volunteer: $definition',
          'title': 'Incoming Call',
        },
        'data': {
          'current_user_fcm_token': currentFCMToken,
          'room_id': roomId,
        },
      }
    };

    final http.Response response = await http.post(
      Uri.parse(fcmEndpoint),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $serverKey',
      },
      body: jsonEncode(message),
    );

    if (response.statusCode == 200) {
      print('FCM message sent successfully');
    } else {
      print('Failed to send FCM message: ${response.statusCode}');
    }
  }
}
