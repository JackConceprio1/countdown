import 'package:flutter/material.dart';

import 'generic_dialog.dart';

Future<bool> showDeleteAllNoificationsDialog(
  BuildContext context,
) {
  return showGenericDialog<bool>(
    context: context,
    title: "Delete",
    content: "Are you sure you want to remove all Noifications",
    optionsBuilder: () => {'Yes': true, "No": false},
  ).then(
    (value) => value ?? false,
  );
}
