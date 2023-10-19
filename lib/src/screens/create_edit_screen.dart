// ignore_for_file: use_full_hex_values_for_flutter_colors

import 'package:countdownplus/src/utilities/bottom_sheets/select_color_bottomsheet.dart';
import 'package:countdownplus/src/utilities/dialogs/error_dialog.dart';
import 'package:countdownplus/src/utilities/dialogs/invalid_date_dialog.dart';
import 'package:countdownplus/src/widgets/contaner_row_widget.dart';
import 'package:countdownplus/src/widgets/title_contaner_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../constants/routes.dart';
import '../models/eventmodel.dart';
import '../services/database_service.dart';
import '../widgets/custom_button.dart';

class CreateEditScreen extends StatefulWidget {
  final dynamic eventId;
  const CreateEditScreen({super.key, this.eventId});

  @override
  State<CreateEditScreen> createState() => _CreateEditScreenState();
}

class _CreateEditScreenState extends State<CreateEditScreen> {
  EventModel? _dbEvent;
  late DatabaseService _databaseService;
  late DateTime _startingDate = DateTime.now();
  late TextEditingController _eventTitleController;
  // late TextEditingController _eventDescriptionController;

  late int _selectedColor = 0xFF607D8B;
  @override
  void initState() {
    super.initState();
    _databaseService = Provider.of<DatabaseService>(context, listen: false);
    _eventTitleController = TextEditingController();
    // _eventDescriptionController = TextEditingController();
    getEvent();
  }

  Future getEvent() async {
    if (widget.eventId != null) {
      EventModel dbEvent = await _databaseService.getEventById(widget.eventId);

      setState(() {
        _eventTitleController.text = dbEvent.title;
        _selectedColor = dbEvent.color;
        _startingDate = dbEvent.startDate;
        _dbEvent = dbEvent;
      });
    } else {
      return null;
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final BuildContext dialogContext = context;
    final DateTime? picked = await showDatePicker(
      context: dialogContext,
      initialDate: _startingDate,
      firstDate: DateTime.now().subtract(const Duration(days: 365 * 10)),
      lastDate: DateTime.now().add(const Duration(days: 365 * 10)),
    );

    if (picked != null) {
      final DateTime now = DateTime.now();
      if (picked.isAfter(now) || picked.isAtSameMomentAs(now)) {
        setState(() {
          _startingDate = DateTime(
            picked.year,
            picked.month,
            picked.day,
            _startingDate.hour,
            _startingDate.minute,
          );
        });
      } else {
        // ignore: use_build_context_synchronously
        showIvalidDate(context,
            "Please select a date that is not less than the current date.");
      }
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(_startingDate),
    );

    if (pickedTime != null) {
      setState(() {
        _startingDate = DateTime(
          _startingDate.year,
          _startingDate.month,
          _startingDate.day,
          pickedTime.hour,
          pickedTime.minute,
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(children: [
        Material(
          elevation: 7,
          animationDuration: const Duration(seconds: 8),
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              children: [
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.arrow_back_ios),
                ),
                Flexible(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        (_dbEvent == null)
                            ? "Create Event"
                            : "Edit: ${_dbEvent!.title}",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                        ),
                        softWrap: false,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        DateFormat('MMM d yyyy').format(DateTime.now()),
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.black45,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Flexible(
          child: ListView(
            padding: const EdgeInsets.all(4),
            children: [
              const SizedBox(
                height: 12,
              ),
              TextField(
                controller: _eventTitleController,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 0,
                    horizontal: 12,
                  ), // Adjust padding as desired

                  filled: true,
                  fillColor: const Color(0xfffe0e0e0),
                  hintText: "Event Name",
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),

              // event times
              TitleContanerWidget(
                title: "Event Date",
                widget: [
                  ContainerRowWidget(
                    onTap: () async {
                      await _selectDate(context);
                    },
                    title: "Event Date",
                    widget: Text(
                      DateFormat('MMM d yyyy').format(_startingDate),
                    ),
                  ),
                  ContainerRowWidget(
                    onTap: () async {
                      await _selectTime(context);
                    },
                    title: "Event Time",
                    widget: Text(
                      DateFormat('h:mm a').format(_startingDate),
                    ),
                  ),
                ],
              ),

              // location

              // event colour
              const SizedBox(
                height: 8,
              ),
              TitleContanerWidget(
                title: "Colour",
                widget: [
                  ContainerRowWidget(
                    onTap: () async {
                      await colorPickerBottomSheet(
                          context: context,
                          selectedColour: _selectedColor,
                          setColour: (int value) => {
                                setState(
                                  () => {
                                    _selectedColor = value,
                                  },
                                ),
                              });
                    },
                    title: "Colour",
                    widget: Row(
                      children: [
                        Container(
                          height: 16,
                          width: 16,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: Color(_selectedColor)),
                        ),
                        const SizedBox(
                          width: 4,
                        ),
                        Text(Color(_selectedColor).value.toString())
                      ],
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 16,
              ),

              TextField(
                maxLines: 5,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: const Color(0xfffe0e0e0),
                  hintText: "Description",
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),

              // create event
              const SizedBox(
                height: 8,
              ),

              CustomButton(
                text: (widget.eventId == null)
                    ? 'Create New Event'
                    : "Update Event",
                onPressed: () async {
                  final event = EventModel(
                    id: (widget.eventId == null) ? null : widget.eventId,
                    title: _eventTitleController.text,
                    description: '',
                    startDate: _startingDate,
                    endDate: _startingDate.add(const Duration(days: 1)),
                    color: _selectedColor,
                  );

                  if (event.title == "") {
                    // show error for title being empty
                    await showErrorDialog(
                        context, "your title cannot be empty");
                  } else if (event.startDate.isBefore(DateTime.now())) {
                    // show error for starting date is before current time

                    await showErrorDialog(context,
                        "Your event date cannot before the current date");
                  } else {
                    if (widget.eventId == null) {
                      await _databaseService.createEvent(event);
                    } else {
                      await _databaseService.updateEvent(event);
                    }
                    Navigator.pushNamedAndRemoveUntil(
                        context, widgetScreenTreeRoute, (route) => false);
                  }
                },
              )
            ],
          ),
        )
      ])),
    );
  }
}
