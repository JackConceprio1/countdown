import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:intl/intl.dart';

import '../constants/routes.dart';

class HeaderWidget extends StatelessWidget {
  final bool canGoBack;
  final String title;
  final List<IconButton> iconButtonList;
  const HeaderWidget({
    super.key,
    this.canGoBack = false,
    required this.title,
    required this.iconButtonList,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 7,
      animationDuration: const Duration(seconds: 8),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                (canGoBack)
                    ? IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(Icons.arrow_back_ios),
                      )
                    : SizedBox(),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          title,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
                          ),

                          softWrap: true,
                          overflow: TextOverflow
                              .ellipsis, // Add ellipsis for overflow
                        ),
                      ],
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
              ],
            ),
            Row(
              children: iconButtonList,
            )
          ],
        ),
      ),
    );
  }
}
