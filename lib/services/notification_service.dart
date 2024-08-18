// import 'package:flutter/services.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:injectable/injectable.dart';

// final FlutterLocalNotificationsPlugin localNotif =
//     FlutterLocalNotificationsPlugin();

// const MethodChannel platform =
//     MethodChannel('dexterx.dev/flutter_local_notifications_example');

// class ReceivedNotification {
//   ReceivedNotification({
//     required this.id,
//     required this.title,
//     required this.body,
//     required this.payload,
//   });

//   final int id;
//   final String title;
//   final String body;
//   final String payload;
// }

// String? selectedNotificationPayload;

// @lazySingleton
// class NotificationService {
//   Future initialise() async {
//     var androidInit = AndroidInitializationSettings('ic_launcher');
//     var iosInit = IOSInitializationSettings();
//     var initializationSettings =
//         InitializationSettings(android: androidInit, iOS: iosInit);
//     localNotif.initialize(initializationSettings);
//     print('Notification Initialised');
//   }

//   Future<void> show(String message) async {
//     var androidNotif = AndroidNotificationDetails(
//       'your channel id',
//       'your channel name',
//       'your channel description',
//       importance: Importance.max,
//       priority: Priority.high,
//       ticker: 'ticker',
//     );
//     var iosNotif = IOSNotificationDetails();
//     var specificPlatform =
//         NotificationDetails(android: androidNotif, iOS: iosNotif);
//     await localNotif.show(
//       0,
//       message,
//       '',
//       specificPlatform,
//       payload: 'item x',
//     );
//   }
// }
