import 'package:flutter/material.dart';

import 'generic_dialog.dart';

Future<bool> showDeleteAllDialog(
  BuildContext context,
) {
  return showGenericDialog<bool>(
    context: context,
    title: "Delete",
    content: "Are you sure you want to delete all events",
    optionsBuilder: () => {'Yes': true, "No": false},
  ).then(
    (value) => value ?? false,
  );
}
