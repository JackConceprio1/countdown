import 'package:countdownplus/src/services/database_service.dart';
import 'package:countdownplus/src/services/local_storage_service.dart';
import 'package:countdownplus/src/services/notification_service.dart';
import 'package:countdownplus/src/utilities/dialogs/delete_all_notifications.dart';
import 'package:countdownplus/src/widgets/contaner_row_widget.dart';
import 'package:countdownplus/src/widgets/header.dart';
import 'package:countdownplus/src/widgets/title_contaner_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../utilities/dialogs/delete_all_events_dialog.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  late DatabaseService _databaseService;
  late NotificationService _notificationService;
  bool _displayNoifications = false;
  @override
  void initState() {
    super.initState();
    _databaseService = Provider.of<DatabaseService>(context, listen: false);
    _notificationService = NotificationService();
    initData();
  }

  initData() async {
    bool getDisplayNoifications = await getDisplayNotification();

    setState(() {
      _displayNoifications = getDisplayNoifications;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const HeaderWidget(title: "Settings", iconButtonList: []),
          Flexible(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(8),
              child: Column(
                children: [
                  TitleContanerWidget(
                    title: "Notifications",
                    widget: [
                      ContainerRowWidget(
                        title: "display noifications",
                        widget: Text((_displayNoifications) ? "On" : "Off"),
                        onTap: () async {
                          // check to see if the user wants to turn off Noifications

                          if (_displayNoifications == true) {
                            bool d =
                                await showDeleteAllNoificationsDialog(context);
                            if (d == true) {
                              // delete all noificatons
                              _notificationService.deleteAllNotifications();

                              bool v = await setDisplayNotification();
                              setState(() {
                                _displayNoifications = v;
                              });
                              // set _displayNoifications to false
                            }
                          } else {
                            // create notifications
                            await _notificationService
                                .initializeNotifications();
                            await _notificationService.scheduleNotification();

                            _notificationService.getAllNotifications();

                            setState(() {
                              _displayNoifications = true;
                            });
                          }
                        },
                      ),
                    ],
                  ),
                  TextButton(
                    onPressed: () async {
                      final shouldDelete = await showDeleteAllDialog(context);
                      if (shouldDelete) {
                        _databaseService.removeAllEvents();
                      }
                    },
                    child: const Text("Delete All Events"),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
