import 'dart:io';

import 'package:android_std/contents/BarcodScanContent.dart';
import 'package:android_std/models/UserModel.dart';
import 'package:android_std/page/kit.dart';
import 'package:flutter/material.dart';
import 'package:android_std/utils/login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:provider/provider.dart';

void main() async{

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  AwesomeNotifications().initialize(
      null,
      [
        NotificationChannel(
            channelKey: 'basic_channel',
            channelName: 'Basic notifications',
            channelDescription: 'Notification channel for basic tests',
            defaultColor: Color(0xFF9D50DD),
            ledColor: Colors.white
        )
      ]
  );
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  runApp(MyApp());

}
class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => UserModel()),
      ],
      child:  MaterialApp(initialRoute: "/", routes: {
        "/": (context) => Login(),
        "/Kit": (context) => Kit(),
        "/BarcodScanContent": (context) => BarcodScanContent(),

      }),
    );
  }
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print("Handling a background message: ${message.messageId}");
  //firebase push notification
  AwesomeNotifications().createNotificationFromJsonData(message.data);
}

class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}

