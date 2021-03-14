import 'package:flutter/material.dart';
import 'package:night_and_day/MainPage.dart';
import 'package:provider/provider.dart';
import 'package:night_and_day/models/Today.dart';

class NightAndDay extends StatelessWidget {
  final String appTitle = "Night & Day";

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => Today(),
        child: MaterialApp(
          title: appTitle,
          theme: ThemeData(
            primarySwatch: Colors.blue,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          home: MainPage(),
        ));
  }
}
