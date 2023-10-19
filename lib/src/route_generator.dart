import 'package:countdownplus/src/screens/create_edit_screen.dart';
import 'package:countdownplus/src/screens/error_screen.dart';
import 'package:countdownplus/src/screens/moreinfo_screen.dart';
import 'package:countdownplus/src/screens/widgets_screen_tree.dart';
import 'package:flutter/material.dart';

import 'constants/routes.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case widgetScreenTreeRoute:
        return MaterialPageRoute(builder: (_) => const WidgetScreenTree());

      case createEditRoute:
        // ignore: unnecessary_type_check
        if (args is dynamic) {
          return MaterialPageRoute(
              builder: (_) => CreateEditScreen(
                    eventId: args,
                  ));
        } else {
          return _errorRoute();
        }

      case moreinfoRoute:
        // ignore: unnecessary_type_check
        if (args is dynamic) {
          return MaterialPageRoute(
              builder: (_) => MoreInfoScreen(
                    eventId: args,
                  ));
        } else {
          return _errorRoute();
        }

      default:
        return MaterialPageRoute(builder: (_) => const WidgetScreenTree());
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) => const ErrorScreen());
  }
}
