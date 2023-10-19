// import 'package:countdownplus/src/services/notification_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import 'src/app.dart';
import 'src/services/database_service.dart';

void main() {
  sqfliteFfiInit();

  WidgetsFlutterBinding.ensureInitialized();
  //
  // FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  //     FlutterLocalNotificationsPlugin();

  // final NotificationService _notificationService = NotificationService();

  //
  // flutterLocalNotificationsPlugin
  //     .resolvePlatformSpecificImplementation<
  //         AndroidFlutterLocalNotificationsPlugin>()!
  //     .requestPermission();
  //
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => DatabaseService()),
      ],
      child: const App(),
    ),
  );
}
