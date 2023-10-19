import 'package:countdownplus/src/widgets/header.dart';
import 'package:flutter/material.dart';

class ErrorScreen extends StatefulWidget {
  const ErrorScreen({super.key});

  @override
  State<ErrorScreen> createState() => _ErrorScreenState();
}

class _ErrorScreenState extends State<ErrorScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const HeaderWidget(
              canGoBack: true,
              title: "CountDownPlus",
              iconButtonList: [],
            ),
            Flexible(
              child: Column(
                children: const [
                  // header

                  CircularProgressIndicator(),
                  Text("ERROR: Unable to load this page"),
                  Text("Click on the back arrow to go to the landing screen")
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
