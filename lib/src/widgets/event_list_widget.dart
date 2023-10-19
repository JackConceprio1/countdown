import 'package:flutter/material.dart';

import '../models/eventmodel.dart';
import 'countdown_card.dart';

typedef EventCallBack = void Function(EventModel event);

class EventListWidget extends StatelessWidget {
  final List<EventModel> events;
  final EventCallBack onDeleteEvent;
  const EventListWidget({
    super.key,
    required this.events,
    required this.onDeleteEvent,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: events.length,
      itemBuilder: (context, index) {
        final EventModel event = events[index];
        return CountDownCard(event: event, onDeleteEvent: onDeleteEvent);
      },
    );
  }
}
