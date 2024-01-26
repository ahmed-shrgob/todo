import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class LocalNotificationService {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> init() async {
    // Initialize native android notification
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    // Initialize native Ios Notifications
    // const DarwinInitializationSettings initializationSettingsIOS =
    //     DarwinInitializationSettings();

    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
      // iOS: initializationSettingsIOS,
    );

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
    );
    tz.initializeTimeZones();
  }

  void showNotificationAndroid() async {
    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
      '20hhhd',
      'to do',
      channelDescription: 'Channel Description',
      importance: Importance.max,
      priority: Priority.high,
      icon: '@mipmap/ic_launcher',
      channelShowBadge: false,
    );

    int notification_id = 2;
    const NotificationDetails notificationDetails =
        NotificationDetails(android: androidNotificationDetails);

    await flutterLocalNotificationsPlugin.show(
        notification_id, "bbbbb", "aaaa", notificationDetails,
        payload: 'Not present');
  }

  void tzShow({required int id,required String title,required String body,required DateTime time}) async {
    const AndroidNotificationDetails androidNotificationDetailss =
        AndroidNotificationDetails(
      '20hhhdeee',
      'to do',
      channelDescription: 'Channel Description',
      importance: Importance.max,
      priority: Priority.max,
      icon: '@mipmap/ic_launcher',
      channelShowBadge: false,
    );

    await flutterLocalNotificationsPlugin.zonedSchedule(
        id,
        title,
        body,
        tz.TZDateTime.from(time, tz.local),
        // tz.TZDateTime.now(tz.local).add(Duration(seconds: 3)),
        NotificationDetails(android: androidNotificationDetailss),
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
            payload: 'Not present',
            // androidAllowWhileIdle: true
            );
  }

}
