import 'package:flutter/material.dart';

import '../../constants/routes.dart';
import '../../models/eventmodel.dart';
import '../dialogs/delete_dialog.dart';

cardButtomsheet(
    {required BuildContext context, required EventModel event, onDeleteEvent}) {
  showModalBottomSheet(
    context: context,
    builder: ((BuildContext context) {
      return FractionallySizedBox(
        heightFactor: 1,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Event: ${event.title}",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ListTile(
              title: Text(
                "View Event",
              ),
              onTap: () async {
                Navigator.pushNamed(context, moreinfoRoute,
                    arguments: event.id);
              },
            ),
            ListTile(
              title: Text("Edit Event"),
              onTap: () async {
                Navigator.pushNamed(context, createEditRoute,
                    arguments: event.id);
              },
            ),
            ListTile(
              title: Text("Delete Event"),
              onTap: () async {
                final shouldDelete = await showDeleteDialog(context);
                if (shouldDelete) {
                  onDeleteEvent(event);
                  Navigator.pop(context);
                }
              },
            ),
          ],
        ),
      );
    }),
  );
}
