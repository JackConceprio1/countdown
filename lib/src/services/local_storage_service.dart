import 'dart:async';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

Future<bool> getDisplayNotification() async {
  const storage = FlutterSecureStorage();

  String? value = await storage.read(key: "display_notification");

  if (value == null) {
    await storage.write(key: "display_notification", value: "true");
  }

  String? getValue = await storage.read(key: "display_notification");

  return getValue == "true" ? true : false;
}

Future<bool> setDisplayNotification() async {
  const storage = FlutterSecureStorage();

  bool value = await getDisplayNotification();

  await storage.write(key: "display_notification", value: (!value).toString());

  String? getValue = await storage.read(key: "display_notification");

  return getValue == "true" ? true : false;
}
