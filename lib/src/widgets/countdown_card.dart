import 'package:countdownplus/src/widgets/timer_countdown.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/eventmodel.dart';
import '../utilities/bottom_sheets/card_bottomsheet.dart';

typedef EventCallBack = void Function(EventModel event);

class CountDownCard extends StatefulWidget {
  const CountDownCard({
    super.key,
    required this.event,
    required this.onDeleteEvent,
  });

  final EventModel event;
  final EventCallBack onDeleteEvent;

  @override
  State<CountDownCard> createState() => _CountDownCardState();
}

class _CountDownCardState extends State<CountDownCard> {
  @override
  Widget build(BuildContext context) {
    print([widget.event.startDate, widget.event.endDate]);
    return InkWell(
      onTap: () async {
        cardButtomsheet(
          context: context,
          event: widget.event,
          onDeleteEvent: widget.onDeleteEvent,
        );
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.only(bottom: 8),
        decoration: BoxDecoration(
          color: Color(widget.event.color),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.event.title,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w400),
              ),
              const SizedBox(
                height: 4,
              ),
              CountdownTimer(
                dateTime1: widget.event.startDate,
                dateTime2: widget.event.endDate,
                format: CountDownTimerFormat.daysHoursMinutesSeconds,
              ),
              Text(
                "Date: ${DateFormat('MMM d yyyy hh:mm ').format(widget.event.startDate)} - ${DateFormat('MMM d yyyy hh:mm ').format(widget.event.endDate)}",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ]),
      ),
    );
  }
}
