import 'package:fast_cached_network_image/fast_cached_network_image.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';
import 'package:http/http.dart';
import 'package:tida_partners/Bookings.dart';
import 'package:tida_partners/Push_notification_model.dart';
import 'package:tida_partners/firebase_options.dart';
import 'package:tida_partners/order_details.dart';
import 'package:tida_partners/utilss/SharedPref.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'login_screen.dart';

late final FirebaseMessaging _messaging;
PushNotificationModel? _notificationInfo;
late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
late AndroidNotificationChannel channel;
bool isFlutterLocalNotificationsInitialized = false;

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // await setupFlutterNotifications();
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  print('Handling a background message ${message.messageId}');
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FastCachedImageConfig.init(clearCacheAfter: const Duration(hours: 2));
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  if (!kIsWeb) {
    await setupFlutterNotifications();
  }
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  requestAndRegisterNotification();
  _messaging = FirebaseMessaging.instance;
  NotificationSettings settings = await _messaging.requestPermission(
      alert: true, badge: true, provisional: false, sound: true);
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  const initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');
  const DarwinInitializationSettings initializationSettingsDarwin =
      DarwinInitializationSettings();
  const InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
    iOS: initializationSettingsDarwin,
  );
  flutterLocalNotificationsPlugin.initialize(initializationSettings,
      onDidReceiveNotificationResponse: onDidReceiveNotificationResponse);

  if (settings.authorizationStatus == AuthorizationStatus.authorized) {
    String? token = await _messaging.getToken();
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null) {
        // final http.Response response =
        //     await http.get(Uri.parse(android.imageUrl ?? ""));
        // BigPictureStyleInformation bigPictureStyleInformation =
        //     BigPictureStyleInformation(ByteArrayAndroidBitmap.fromBase64String(
        //         base64Encode(response.bodyBytes)));

        flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                channelDescription: channel.description,
                color: Colors.blue,
                icon: "@mipmap/ic_launcher",
                importance: Importance.high,
                priority: Priority.high,
              ),
              iOS: const DarwinNotificationDetails()),
        );
      }
      PushNotificationModel pushNotificationModel = PushNotificationModel(
        title: message.notification?.title,
        body: message.notification?.body,
      );
      _notificationInfo = pushNotificationModel;
      totalnotifications++;
    });
    if (_notificationInfo != null) {
      Get.to(() => OrderDetails());
    }
  }
  await Preferences.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "Tida Partners",
      debugShowCheckedModeBanner: false,
      defaultTransition: Transition.rightToLeft,
      home: LoginScreen(),
    );
  }
}

int totalnotifications = 0;

void requestAndRegisterNotification() async {
  // _messaging = FirebaseMessaging.instance;
  // NotificationSettings settings = await _messaging.requestPermission(
  //     alert: true, badge: true, provisional: false, sound: true);
  // FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  // const initializationSettingsAndroid =
  //     AndroidInitializationSettings('@mipmap/ic_launcher');
  // const DarwinInitializationSettings initializationSettingsDarwin =
  //     DarwinInitializationSettings();
  // const InitializationSettings initializationSettings = InitializationSettings(
  //   android: initializationSettingsAndroid,
  //   iOS: initializationSettingsDarwin,
  // );
  // flutterLocalNotificationsPlugin.initialize(initializationSettings,
  //     onDidReceiveNotificationResponse: onDidReceiveNotificationResponse);

  // if (settings.authorizationStatus == AuthorizationStatus.authorized) {
  //   String? token = await _messaging.getToken();
  //   FirebaseMessaging.onMessage.listen((RemoteMessage message) {
  //     RemoteNotification? notification = message.notification;
  //     AndroidNotification? android = message.notification?.android;
  //     if (notification != null && android != null) {
  //       // final http.Response response =
  //       //     await http.get(Uri.parse(android.imageUrl ?? ""));
  //       // BigPictureStyleInformation bigPictureStyleInformation =
  //       //     BigPictureStyleInformation(ByteArrayAndroidBitmap.fromBase64String(
  //       //         base64Encode(response.bodyBytes)));

  //       flutterLocalNotificationsPlugin.show(
  //         notification.hashCode,
  //         notification.title,
  //         notification.body,
  //         NotificationDetails(
  //             android: AndroidNotificationDetails(
  //               channel.id,
  //               channel.name,
  //               channelDescription: channel.description,
  //               color: Colors.blue,
  //               icon: "@mipmap/ic_launcher",
  //               importance: Importance.high,
  //               priority: Priority.high,
  //             ),
  //             iOS: const DarwinNotificationDetails()),
  //       );
  //     }
  //     PushNotificationModel pushNotificationModel = PushNotificationModel(
  //       title: message.notification?.title,
  //       body: message.notification?.body,
  //     );
  //     _notificationInfo = pushNotificationModel;
  //     totalnotifications++;
  //   });
  //   if (_notificationInfo != null) {
  //     Get.to(() => OrderDetails());
  //   }
  // }
}

void onDidReceiveNotificationResponse(
    NotificationResponse notificationResponse) {
  final String? payload = notificationResponse.payload;
  debugPrint('notification payload: $payload');
  print(
      "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
  Get.to(() => Bookings());
}

Future<void> setupFlutterNotifications() async {
  if (isFlutterLocalNotificationsInitialized) {
    return;
  }

  FirebaseMessaging messaging = FirebaseMessaging.instance;

  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );

  channel = const AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    description:
        'This channel is used for important notifications.', // description
    importance: Importance.high,
  );

  flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  /// Create an Android Notification Channel.
  ///
  /// We use this channel in the `AndroidManifest.xml` file to override the
  /// default FCM channel to enable heads up notifications.
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  /// Update the iOS foreground notification presentation options to allow
  /// heads up notifications.
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
  isFlutterLocalNotificationsInitialized = true;
}
