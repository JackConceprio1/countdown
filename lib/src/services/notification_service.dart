import 'package:countdownplus/src/models/eventmodel.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:countdownplus/src/services/database_service.dart';

class NotificationService {
  final DatabaseService _databaseService = DatabaseService();

  static final NotificationService _instance = NotificationService._internal();
  factory NotificationService() => _instance;

  late FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin;

  NotificationService._internal() {
    initializeNotifications();
  }

  Future<void> initializeNotifications() async {
    tz.initializeTimeZones();

    _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    final initializationSettings = const InitializationSettings(
      android: AndroidInitializationSettings('@mipmap/ic_launcher'),
      iOS: DarwinInitializationSettings(),
    );

    try {
      await _flutterLocalNotificationsPlugin.initialize(initializationSettings);
    } catch (e) {
      print('Failed to initialize notifications: $e');
    }
  }

  Future<void> countdownNotification() async {
    await _flutterLocalNotificationsPlugin.cancel(0);
    final events = await _databaseService.getSingleEvent();

    if (events.isNotEmpty) {
      EventModel event = events[0];
      final notificationTime = tz.TZDateTime(
        tz.local,
        DateTime.now().year,
        DateTime.now().month,
        DateTime.now().day + 1, // Next day
        8,
        30,
      );
      final daysRemaining = event.startDate.difference(DateTime.now()).inDays;

      final androidPlatformChannelSpecifics = const AndroidNotificationDetails(
        'channel_id',
        'channel_name',
        importance: Importance.max,
        priority: Priority.high,
        playSound: true,
        enableVibration: true,
        enableLights: true,
      );
      final iOSPlatformChannelSpecifics = const DarwinNotificationDetails();
      final platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics,
      );

      _flutterLocalNotificationsPlugin.show(
        0,
        event.title,
        "days Remaining: $daysRemaining ",
        platformChannelSpecifics,
      );
    }
    ;
  }

  Future<void> scheduleNotification() async {
    final events = await _databaseService.getSingleEvent();

    if (events.isNotEmpty) {
      EventModel event = events[0];

      final notificationTime = tz.TZDateTime(
        tz.local,
        DateTime.now().year,
        DateTime.now().month,
        DateTime.now().day + 1, // Next day
        8,
        30,
      );
      final daysRemaining = event.startDate.difference(DateTime.now()).inDays;

      final androidPlatformChannelSpecifics = const AndroidNotificationDetails(
        'channel_id',
        'channel_name',
        importance: Importance.max,
        priority: Priority.high,
        playSound: true,
        enableVibration: true,
        enableLights: true,
      );
      final iOSPlatformChannelSpecifics = const DarwinNotificationDetails();
      final platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics,
      );

      await _flutterLocalNotificationsPlugin.zonedSchedule(
        0,
        'Event: ${event.title}',
        'Remaining: $daysRemaining',
        notificationTime,
        platformChannelSpecifics,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
      );
    }
  }

  Future<void> getAllNotifications() async {
    List<PendingNotificationRequest> notifications =
        await _flutterLocalNotificationsPlugin.pendingNotificationRequests();

    notifications.forEach((notification) {
      print('Notification ID: ${notification.id}');
      print('Title: ${notification.title}');
      print('Body: ${notification.body}');
      // Print other properties as needed
    });
  }

  Future<void> deleteAllNotifications() async {
    await _flutterLocalNotificationsPlugin.cancelAll();
  }
}
