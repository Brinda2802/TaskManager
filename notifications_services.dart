import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:googleapis_auth/auth_io.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

// class NotificationService {
//   static Future<void> sendPushMessage(String title, String body) async {
//     String serverToken = 'AIzaSyCje8L1B5DTqo7Z9m45BZguLXVrWlioSlM';
//
//     try {
//       await http.post(
//         Uri.parse('https://fcm.googleapis.com/fcm/send'),
//         headers: {
//           'Content-Type': 'application/json',
//           'Authorization': 'key=$serverToken',
//         },
//         body: jsonEncode({
//           'to': '/topics/all',
//           'notification': {
//             'title': title,
//             'body': body,
//           },
//         }),
//       );
//     } catch (e) {
//       print("Error sending notification: $e");
//     }
//   }
// }

// class NotificationService {
//   static Future<void> sendPushMessage(String title, String body) async {
//     String serverToken = 'd3Mz5nfYT0uLZXkMJMtum_:APA91bEZixOQ9X7HTX5bJpkHjTDIw-wHsUhD9kd7EKzvtpFu4yPfoOBpbWbR18KWw6ARD59UlEJtm1_GuzWXNwbEgwwkh2j1qFFLj2vtmeAoTiQe_Jx-wqo';
//
//     try {
//       await http.post(
//         Uri.parse('https://fcm.googleapis.com/fcm/send'),
//         headers: {
//           'Content-Type': 'application/json',
//           'Authorization': 'key=$serverToken',
//         },
//         body: jsonEncode({
//           'to': '/topics/all',
//           'notification': {
//             'title': title,
//             'body': body,
//           },
//         }),
//       );
//     } catch (e) {
//       print("Error sending notification: $e");
//     }
//   }
// }





// class NotificationService {
//
//
//
//   static Future<void> sendPushMessage(String title, String body) async {
//     final String projectId = "taskapp-ea984";
//
//     try {
//       final String accessToken = await _getAccessToken();
//       await http.post(
//         Uri.parse('https://fcm.googleapis.com/v1/projects/$projectId/messages:send'),
//         headers: {
//           'Content-Type': 'application/json',
//           'Authorization': 'Bearer $accessToken',
//         },
//         body: jsonEncode({
//           "message": {
//             "topic": "all",
//             "notification": {
//               "title": title,
//               "body": body,
//             }
//           }
//         }),
//       );
//       print("✅ Push notification sent: $title");
//     } catch (e) {
//       print("❌ Error sending notification: $e");
//     }
//   }
//
//   static Future<String> _getAccessToken() async {
//
//     final serviceAccount = await rootBundle.loadString('assets/s_account.json');
//     final credentials = ServiceAccountCredentials.fromJson(serviceAccount);
//
//
//     final client = await clientViaServiceAccount(
//         credentials,
//         ['https://www.googleapis.com/auth/firebase.messaging']
//     );
//
//     return (await client.credentials).accessToken.data;
//   }
//
// }



import 'dart:convert';
import 'dart:io';
import 'package:googleapis_auth/googleapis_auth.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart' show rootBundle;

// Path to the service account JSON file
const String serviceAccountPath = "assets/tasklist_saccounts.json";







Future<String> getAccessToken() async {
  final String jsonString = await rootBundle.loadString(serviceAccountPath);
  final Map<String, dynamic> jsonCredentials = json.decode(jsonString);

  final credentials = ServiceAccountCredentials.fromJson(jsonCredentials);

  final client = await clientViaServiceAccount(
    credentials,
    ['https://www.googleapis.com/auth/firebase.messaging'], // ✅ Correct scope
  );


  return client.credentials.accessToken.data;
}




Future<void> sendPushMessage(String title, String body) async {
  final String accessToken = await getAccessToken();
  const String projectId = "taskapp-ea984"; // Replace with your Firebase project ID

  final response = await http.post(
    Uri.parse('https://fcm.googleapis.com/v1/projects/$projectId/messages:send'),
    headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken',
    },
    body: jsonEncode({
      "message": {
        "topic": "all",
        "notification": {
          "title": title,
          "body": body,
        }
      }
    }),
  );

  if (response.statusCode == 200) {
    print("✅ Push notification sent successfully!");
  } else {
    print("❌ Failed to send notification: ${response.body}");
  }
}


