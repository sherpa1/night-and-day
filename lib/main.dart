import 'package:flutter/material.dart';
import 'package:night_and_day/NightAndDay.dart';
import 'package:provider/provider.dart';
import 'package:night_and_day/models/Today.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => Today(),
      child: NightAndDay(),
    ),
  );
}
