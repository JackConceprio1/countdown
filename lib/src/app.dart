import 'package:countdownplus/src/constants/routes.dart';
import 'package:countdownplus/src/route_generator.dart';
import 'package:countdownplus/src/services/notification_service.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  const App({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // final NotificationService notificationService = NotificationService();
    // notificationService.initializeNotifications();
    // notificationService.scheduleNotification();

    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: widgetScreenTreeRoute,
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}
