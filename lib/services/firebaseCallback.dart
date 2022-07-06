import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:ownervet/services/local_notifications_services.dart';


class FirebaseCallbacks {
  static const AndroidNotificationChannel channel = AndroidNotificationChannel(
    "rm", //channel ID
    "rm channel", //channel NAME
//channel DESCRIPTION
    importance: Importance.high,
  );

  static Future<void> backgroundHandler(RemoteMessage message) async {
    await Firebase.initializeApp();
   // print(message.data.toString());
   // print(message.notification!.title);
  }

  static Future<bool> init() async {
    await Firebase.initializeApp();
    await FirebaseMessaging.instance.requestPermission();
    FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
        alert: true, badge: true, sound: true);
    FirebaseMessaging.onBackgroundMessage(backgroundHandler);
    FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
        alert: true, badge: true, sound: true);
    await LocalNotificationService.notificationsPlugin
        .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
    return Future.value(true);
  }

  static void startHandlingNotifications(
      BuildContext context, Function(RemoteMessage?) onMessage) {
    // FirebaseMessaging.instance.getInitialMessage();
    ///gives you the message on which user taps
    ///and it opened the app from terminated state
    FirebaseMessaging.instance.getInitialMessage().then((message) {
      log('OnMessage initial message : $message');
     // _updateNotificationCount(context);
      onMessage(message);
    });

    ///forground work
    FirebaseMessaging.onMessage.listen((message) {
      log('OnMessage Listen : $message');
    //  _updateNotificationCount(context);
      onMessage(message);
    });

    ///When the app is in background but opened and user taps
    ///on the notification
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      print(message.sentTime);
      //_updateNotificationCount(context);
      onMessage(message);
    });

    // FirebaseMessaging.onBackgroundMessage.listen();
  }


}
