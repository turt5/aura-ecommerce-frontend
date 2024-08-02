// import 'package:firebase_messaging/firebase_messaging.dart';

// class FirebaseNotification{
//   final _firebaseMessaging = FirebaseMessaging.instance;

//   Future<void> initNotifications() async {
//     await _firebaseMessaging.requestPermission();
//     // await _firebaseMessaging.setForegroundNotificationPresentationOptions(
//     //   alert: true,
//     //   badge: true,
//     //   sound: true,
//     // );

//     final fcmToken = await _firebaseMessaging.getToken();
//     print('FCM Token: $fcmToken');
//   }
// }