import 'package:connectycube_sdk/connectycube_calls.dart';
import 'package:connectycube_sdk/connectycube_pushnotifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:ownervet/services/firebaseCallback.dart';

///THIS ENTIRE PACKAGE IS FOR FLUTTER_LOCAL_NOTIFICATIONS SERVICES as Firebase doesn't show heads up notifications by default
class LocalNotificationService {
  ///declaring a notificationPlugin as static to easily access it without object
  ///notificationPlugin is used to initialize flutter_local_notifications package
  static final FlutterLocalNotificationsPlugin notificationsPlugin =
  FlutterLocalNotificationsPlugin();

  static void initialize(BuildContext context) {
    ///declaring notification plugin's initialization settings
    const InitializationSettings initializationSettings =

    ///as we are dealing with android for the time being hence only android is described
    ///default icon url can be anything[specified by the user]
    InitializationSettings(
        android: AndroidInitializationSettings("@drawable/default_avatar"),
        iOS: IOSInitializationSettings());

    ///onSelectNotification adds the tap functionality to foreground notifications
    notificationsPlugin.initialize(initializationSettings,
        onSelectNotification: (String? route) async {
          if (route != null) {
            Navigator.of(context).pushNamed(route);
          }
        });
  }

  static void display(RemoteMessage message) async {
    try {
      final id = DateTime.now().millisecondsSinceEpoch ~/ 1000;

      ///notification details is the MOST important criteria to set channel in flutter_local_notifications
      final NotificationDetails notificationDetails = NotificationDetails(
          android: AndroidNotificationDetails(
            FirebaseCallbacks.channel.id,
            FirebaseCallbacks.channel.name,

            importance: Importance.max,
            priority: Priority.high,
          ),
          iOS: const IOSNotificationDetails());

      await notificationsPlugin.show(
        id,
        "Incoming call",
        "",
        notificationDetails,

      );


    } on Exception catch (e) {
      print("Foreground channel error $e");
    }
  }
}
