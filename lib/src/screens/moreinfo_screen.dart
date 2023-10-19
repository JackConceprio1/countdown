import 'package:countdownplus/src/widgets/contaner_row_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../models/eventmodel.dart';
import '../services/database_service.dart';
import '../widgets/header.dart';
import '../widgets/title_contaner_widget.dart';

class MoreInfoScreen extends StatefulWidget {
  final dynamic eventId;

  const MoreInfoScreen({Key? key, this.eventId}) : super(key: key);

  @override
  State<MoreInfoScreen> createState() => _MoreInfoScreenState();
}

class _MoreInfoScreenState extends State<MoreInfoScreen> {
  EventModel? _dbEvent;
  late DatabaseService _databaseService;

  @override
  void initState() {
    _databaseService = Provider.of<DatabaseService>(context, listen: false);
    super.initState();
    getEvent();
  }

  Future<void> getEvent() async {
    if (widget.eventId != null) {
      EventModel? dbEvent = await _databaseService.getEventById(widget.eventId);

      setState(() {
        _dbEvent = dbEvent;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_dbEvent == null) {
      // Handle the case where _dbEvent is null
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    EventModel event = _dbEvent!; // Use _dbEvent! to access the non-null value

    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HeaderWidget(
              title: event.title,
              iconButtonList: const [],
              canGoBack: true,
            ),
            Flexible(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 8,
                    ),
                    TitleContanerWidget(
                      title: "Event Dates",
                      widget: [
                        ContainerRowWidget(
                          onTap: () => {},
                          title: "Start Date",
                          widget: Text(DateFormat('MMM d yyyy - h:mm a')
                              .format(event.startDate)),
                        ),
                        ContainerRowWidget(
                          onTap: () => {},
                          title: "Ending Date",
                          widget: Text(DateFormat('MMM d yyyy - h:mm a')
                              .format(event.endDate)),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    (event.description == "")
                        ? const SizedBox()
                        : Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text(
                                "Description",
                                style: TextStyle(
                                    fontWeight: FontWeight.w500, fontSize: 16),
                              ),
                              SizedBox(
                                height: 6,
                              ),
                              Text(
                                '',
                                style: TextStyle(fontSize: 16),
                              )
                            ],
                          )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
