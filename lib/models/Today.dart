import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

class Today {
  Today([DateTime defaultDate]) {
    if (defaultDate == null)
      this.date = DateTime.now();
    else
      this.date = defaultDate;
  }

  DateTime date;

  String timeToString() {
    var hour =
        (date.hour < 10) ? "0" + date.hour.toString() : date.hour.toString();
    var minute = (DateTime.now().minute < 10)
        ? "0" + DateTime.now().minute.toString()
        : DateTime.now().minute.toString();

    return "$hour:$minute";
  }

  String dateToString() {
    return this.date.toString().split(" ")[0];
  }

  int hour() {
    return this.date.hour;
  }

  int minute() {
    return this.date.minute;
  }

  int dayMoment() {
    if (this.date.hour < 6)
      return 0;
    else if (this.date.hour < 12)
      return 6;
    else if (this.date.hour < 18)
      return 12;
    else
      return 18;
  }

  bool isDarkMode() {
    if (this.date.hour < 6)
      return true;
    else if (this.date.hour < 12)
      return false;
    else if (this.date.hour < 18)
      return false;
    else
      return true;
  }
}

class TodayManager extends StateNotifier<Today> {
  TodayManager(Today today) : super(today ?? Today());

  int counter = 0;

  void add(Duration duration) {
    state.date.add(duration);
  }

  void autoAdd() {
    Timer.periodic(Duration(seconds: 1), (timer) {
      onTimerUpdate();
    });
  }

  void onTimerUpdate() {
    if (counter < 10) {
      counter++;
    } else {
      counter = 0;
      _onTimeChange(1); //add 1 day to current Date when counter == 10
    }
  }

  void _onTimeChange(int hoursToAdd) {
    state.date.add(Duration(hours: hoursToAdd));
  }
}
