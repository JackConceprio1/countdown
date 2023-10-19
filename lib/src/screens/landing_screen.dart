import 'package:countdownplus/src/constants/routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/eventmodel.dart';
import '../services/database_service.dart';
import '../widgets/event_list_widget.dart';
import '../widgets/header.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({super.key});

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  late DatabaseService _databaseService;
  @override
  void initState() {
    super.initState();

    _databaseService = Provider.of<DatabaseService>(context, listen: false);
    _databaseService.getAllEvents();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // header
        HeaderWidget(
          canGoBack: false,
          title: "CountDownPlus",
          iconButtonList: [
            IconButton(
              onPressed: () => Navigator.pushNamed(context, createEditRoute),
              icon: const Icon(
                Icons.add,
                size: 28,
              ),
            )
          ],
        ),
        // Body
        Flexible(
          child: StreamBuilder<List<EventModel>>(
            stream: _databaseService.eventStream,
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                case ConnectionState.active:
                  if (snapshot.hasData) {
                    final allEvent = snapshot.data as List<EventModel>;

                    return (allEvent.isEmpty)
                        ? createEventHelper()
                        : EventListWidget(
                            events: allEvent,
                            onDeleteEvent: (event) async {
                              await _databaseService
                                  .deleteSingleEvent(event.id!);
                            });
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                default:
                  return const Center(child: CircularProgressIndicator());
              }
            },
          ),
        ),
      ],
    );
  }

  Column createEventHelper() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        Text("How To Create an Event"),
        Text("Click on The + icon to create an event")
      ],
    );
  }
}
