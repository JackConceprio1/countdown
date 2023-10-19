import 'dart:async';

import 'package:flutter/material.dart';

enum CountDownTimerFormat {
  daysHoursMinutesSeconds,
  daysHoursMinutes,
  daysHours,
  daysOnly,
  hoursMinutesSeconds,
  hoursMinutes,
  hoursOnly,
  minutesSeconds,
  minutesOnly,
  secondsOnly,
}

class CountdownTimer extends StatefulWidget {
  final DateTime dateTime1;
  final DateTime dateTime2;
  final CountDownTimerFormat format;

  CountdownTimer(
      {required this.dateTime1,
      required this.dateTime2,
      this.format = CountDownTimerFormat.daysHoursMinutesSeconds});

  @override
  _CountdownTimerState createState() => _CountdownTimerState();
}

class _CountdownTimerState extends State<CountdownTimer> {
  late Duration _duration;
  late Timer _timer;
  int _currentTimerNumber = 1;
  bool _isCountdownComplete = false;

  @override
  void initState() {
    super.initState();
    _duration = _getCurrentDuration();
    if (_duration.isNegative) {
      _isCountdownComplete = true;
    } else {
      startTimer();
    }
  }

  Duration _getCurrentDuration() {
    DateTime now = DateTime.now();
    if (widget.dateTime1.isAfter(now)) {
      _currentTimerNumber = 1;
      return widget.dateTime1.difference(now);
    } else if (widget.dateTime2.isAfter(now)) {
      _currentTimerNumber = 2;
      return widget.dateTime2.difference(now);
    }
    return Duration.zero;
  }

  void startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _duration -= Duration(seconds: 1);
        if (_duration.isNegative) {
          _timer.cancel();
          if (_currentTimerNumber == 1 &&
              widget.dateTime2.isAfter(DateTime.now())) {
            _currentTimerNumber = 2;
            _duration = widget.dateTime2.difference(DateTime.now());
            startTimer();
          } else {
            _isCountdownComplete = true;
          }
        }
      });
    });
  }

  String getTimerText() {
    if (_isCountdownComplete) {
      return 'Countdown Complete!';
    } else if (_currentTimerNumber == 2) {
      return "You're event is in progress";
    } else {
      final days = _duration.inDays;
      final hours = _duration.inHours % 24;
      final minutes = _duration.inMinutes % 60;
      final seconds = _duration.inSeconds % 60;

      return formatTime(days, hours, minutes, seconds);
    }
  }

  String formatTime(int days, int hours, int minutes, int seconds) {
    String formattedTime = '';

    switch (widget.format) {
      case CountDownTimerFormat.daysHoursMinutesSeconds:
        formattedTime += _formatComponent(days, 'Days');
        formattedTime += _formatComponent(hours, 'Hours');
        formattedTime += _formatComponent(minutes, 'Minutes');
        formattedTime += _formatComponent(seconds, 'Seconds');
        break;
      case CountDownTimerFormat.daysHoursMinutes:
        formattedTime += _formatComponent(days, 'Days');
        formattedTime += _formatComponent(hours, 'Hours');
        formattedTime += _formatComponent(minutes, 'Minutes');
        break;
      case CountDownTimerFormat.daysHours:
        formattedTime += _formatComponent(days, 'Days');
        formattedTime += _formatComponent(hours, 'Hours');
        break;
      case CountDownTimerFormat.daysOnly:
        formattedTime += _formatComponent(days, 'Days');
        break;
      case CountDownTimerFormat.hoursMinutesSeconds:
        formattedTime += _formatComponent(hours, 'Hours');
        formattedTime += _formatComponent(minutes, 'Minutes');
        formattedTime += _formatComponent(seconds, 'Seconds');
        break;
      case CountDownTimerFormat.hoursMinutes:
        formattedTime += _formatComponent(hours, 'Hours');
        formattedTime += _formatComponent(minutes, 'Minutes');
        break;
      case CountDownTimerFormat.hoursOnly:
        formattedTime += _formatComponent(hours, 'Hours');
        break;
      case CountDownTimerFormat.minutesSeconds:
        formattedTime += _formatComponent(minutes, 'Minutes');
        formattedTime += _formatComponent(seconds, 'Seconds');
        break;
      case CountDownTimerFormat.minutesOnly:
        formattedTime += _formatComponent(minutes, 'Minutes');
        break;
      case CountDownTimerFormat.secondsOnly:
        formattedTime += _formatComponent(seconds, 'Seconds');
        break;

      default:
        formattedTime += _formatComponent(days, 'Days');
        formattedTime += _formatComponent(hours, 'Hours');
        formattedTime += _formatComponent(minutes, 'Minutes');
        formattedTime += _formatComponent(seconds, 'Seconds');
    }

    return formattedTime.trim();
  }

  String _formatComponent(int value, String label) {
    final formattedValue = value.toString().padLeft(2, '0');

    return '$formattedValue $label ';
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          getTimerText(),
          style: TextStyle(fontSize: 16, color: Colors.white),
        ),
      ],
    );
  }
}
