// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:get/get.dart';
//
//
// Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   print("Background Message: ${message.notification?.title}");
// }
//
// Future<void> setupFirebaseMessaging() async {
//   // FirebaseMessaging notificationSettings = FirebaseMessaging.instance;
//   // await notificationSettings.requestPermission();
//   // final fcmToken = await notificationSettings.getToken();
//   // print("token : $fcmToken");
//   // You may set the permission requests to "provisional" which allows the user to choose what type
// // of notifications they would like to receive once the user receives a notification.
//   final notificationSettings = await FirebaseMessaging.instance.requestPermission(provisional: true);
//
// // For apple platforms, ensure the APNS token is available before making any FCM plugin API calls
//   final apnsToken = await FirebaseMessaging.instance.getAPNSToken();
//   if (apnsToken != null) {
//     print("apnsToken: $apnsToken");
//   }
//
//   NotificationSettings settings = await messaging.requestPermission();
//   if (settings.authorizationStatus == AuthorizationStatus.authorized) {
//     print("User granted permission for notifications");
//   } else {
//     print("User denied notification permission");
//     return;
//   }
//
//
//   await messaging.subscribeToTopic('all');
//
//
//   FirebaseMessaging.onMessage.listen((RemoteMessage message) {
//     if (message.notification != null) {
//       Get.snackbar(
//         message.notification!.title ?? "New Notification",
//         message.notification!.body ?? "You have a new message",
//         snackPosition: SnackPosition.TOP,
//       );
//     }
//   });
//
//
//   FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
//     print("Notification Clicked: ${message.notification?.title}");
//
//   });
//
//
//   FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
// }




