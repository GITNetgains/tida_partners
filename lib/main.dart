import 'package:fast_cached_network_image/fast_cached_network_image.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';
import 'package:tida_partners/Push_notification_model.dart';
import 'package:tida_partners/order_details.dart';
import 'package:tida_partners/utilss/SharedPref.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'login_screen.dart';
Future _firebaseMessagingBackgroundHandler(RemoteMessage message) async
{
  print("Handling a background message: ${message.messageId}");
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FastCachedImageConfig.init(clearCacheAfter: const Duration(hours: 2));
   await Firebase.initializeApp();
   requestAndRegisterNotification();
  await Preferences.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      defaultTransition: Transition.rightToLeft,
      home: LoginScreen(),
    );
  }
}
int totalnotifications = 0;
  late final FirebaseMessaging _messaging;
  PushNotificationModel? _notificationInfo;
  void requestAndRegisterNotification() async {
    _messaging = FirebaseMessaging.instance;
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    NotificationSettings settings = await _messaging.requestPermission(
        alert: true, badge: true, provisional: false, sound: true);
    ;
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      String? token = await _messaging.getToken();
      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        PushNotificationModel pushNotificationModel = PushNotificationModel(
          title: message.notification?.title,
          body: message.notification?.body,
        );
        _notificationInfo = pushNotificationModel;
        totalnotifications++;
      });
      if (_notificationInfo != null) {
        Get.to(()=> OrderDetails());
      }
    }
  }