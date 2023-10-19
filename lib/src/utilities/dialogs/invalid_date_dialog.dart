import 'package:flutter/material.dart';

import 'generic_dialog.dart';

Future<void> showIvalidDate(
  BuildContext context,
  String text,
) {
  return showGenericDialog<void>(
      context: context,
      title: "In valid date",
      content: text,
      optionsBuilder: () => {'OK': null});
}
