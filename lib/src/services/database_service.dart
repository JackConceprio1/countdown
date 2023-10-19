import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../models/eventmodel.dart';

class DatabaseService with ChangeNotifier {
  final StreamController<List<EventModel>> _eventStreamController =
      StreamController<List<EventModel>>.broadcast();

  Stream<List<EventModel>> get eventStream => _eventStreamController.stream;

  List<EventModel> _events = [];

  List<EventModel> get events => _events;

  Future<Database> _initializeDatabase() async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, 'MyEvents.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE events(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            title TEXT,
            description TEXT,
            startDate INTEGER,
            endDate INTEGER,
            color INTEGER
          )
          ''');
      },
    );
  }

  Future<List<EventModel>> getSingleEvent() async {
    final db = await _initializeDatabase();
    final eventsData = await db.query('events');
    _events =
        eventsData.map((eventData) => EventModel.fromJson(eventData)).toList();

    return _events;
  }

  Future<void> getAllEvents() async {
    final db = await _initializeDatabase();
    final eventsData = await db.query('events');
    _events =
        eventsData.map((eventData) => EventModel.fromJson(eventData)).toList();
    _events.sort((a, b) => a.startDate
        .compareTo(b.startDate)); // Sort the events list by startDate

    _eventStreamController.add(_events);
    notifyListeners();
  }

  Future<void> removeAllEvents() async {
    final db = await _initializeDatabase();
    await db.delete('events');
    _events = [];
    _eventStreamController.add(_events);
    notifyListeners();
  }

  Future<void> deleteSingleEvent(int eventId) async {
    final db = await _initializeDatabase();

    final deletedCount = await db.delete(
      "events",
      where: 'id = ?',
      whereArgs: [eventId],
    );

    if (deletedCount == 0) {
      return; // Exit the method if the deletion was unsuccessful
    }

    _events.removeWhere((event) => event.id == eventId);
    _eventStreamController.add(_events);
  }

  Future<void> updateEvent(EventModel event) async {
    final db = await _initializeDatabase();
    await db.update(
      'events',
      event.toJson(),
      where: 'id = ?',
      whereArgs: [event.id],
    );
    _events = _events.map((existingEvent) {
      return existingEvent.id == event.id ? event : existingEvent;
    }).toList();
    _events.sort((a, b) => a.startDate
        .compareTo(b.startDate)); // Sort the events list by startDate

    _eventStreamController.add(_events);
    notifyListeners();
  }

  Future<void> createEvent(EventModel event) async {
    final db = await _initializeDatabase();

    final insertId = await db.insert("events", event.toJson());

    final newEvent = await getEventById(insertId);
    _events.add(newEvent);
    _events.sort((a, b) => a.startDate
        .compareTo(b.startDate)); // Sort the events list by startDate

    _eventStreamController.add(_events);
    notifyListeners();
  }

  Future<EventModel> getEventById(int eventId) async {
    final db = await _initializeDatabase();
    final eventData = await db.query(
      'events',
      where: 'id = ?',
      whereArgs: [eventId],
    );
    if (eventData.isNotEmpty) {
      return EventModel.fromJson(eventData.first);
    }
    throw Exception('Event not found');
  }

  @override
  void dispose() {
    _eventStreamController.close();
    super.dispose();
  }
}
