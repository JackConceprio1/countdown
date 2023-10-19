import 'package:flutter/material.dart';

class ContainerRowWidget extends StatelessWidget {
  final String title;
  final Widget widget;
  final Function onTap;
  const ContainerRowWidget(
      {super.key,
      required this.title,
      required this.widget,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => {onTap()},
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
        child: Row(
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 16.0),
            ),
            const Spacer(),
            widget,
          ],
        ),
      ),
    );
  }
}
