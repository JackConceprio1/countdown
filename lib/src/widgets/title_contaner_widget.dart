import 'package:flutter/cupertino.dart';

class TitleContanerWidget extends StatelessWidget {
  final String title;
  final List<Widget> widget;
  const TitleContanerWidget({
    super.key,
    required this.title,
    required this.widget,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 6,
          ),
          Container(
            decoration: BoxDecoration(
                color: const Color(0xffE0E0E0),
                borderRadius: BorderRadius.circular(4)),
            child: Column(
              children: widget,
            ),
          ),
        ],
      ),
    );
  }
}
