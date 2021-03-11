import 'package:flutter/material.dart';
import 'package:night_and_day/MainPage.dart';

class NightAndDay extends StatelessWidget {
  final String appTitle = "Night & Day";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: appTitle,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MainPage(title: appTitle),
    );
  }
}
