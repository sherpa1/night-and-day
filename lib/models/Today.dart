import 'package:flutter/widgets.dart';
import 'dart:async';

class Today with ChangeNotifier {
  Today([DateTime defaultDate]) {
    if (defaultDate == null)
      this._date = DateTime.now();
    else
      this._date = defaultDate;

    Timer.periodic(Duration(seconds: 1), (timer) {
      _onTimerUpdate();
    });
  }

  DateTime _date;
  int _counter = 0;

  void _onTimerUpdate() {
    if (_counter < 10) {
      _counter++;
    } else {
      _counter = 0;
      _onTimeChange(1); //add 1 day to current Date when counter == 10
    }
    this.notifyListeners();
  }

  void _onTimeChange(int hoursToAdd) {
    this._date = this._date.add(Duration(hours: hoursToAdd));
    this.notifyListeners();
  }

  String timeToString() {
    var hour =
        (_date.hour < 10) ? "0" + _date.hour.toString() : _date.hour.toString();
    var minute = (DateTime.now().minute < 10)
        ? "0" + DateTime.now().minute.toString()
        : DateTime.now().minute.toString();

    return "$hour:$minute";
  }

  String dateToString() {
    return this._date.toString().split(" ")[0];
  }

  DateTime date() {
    return this._date;
  }

  int hour() {
    return this._date.hour;
  }

  int minute() {
    return this._date.minute;
  }

  void add(Duration duration) {
    this._date = this._date.add(duration);

    this.notifyListeners();
  }

  int dayMoment() {
    if (this._date.hour < 6)
      return 0;
    else if (this._date.hour < 12)
      return 6;
    else if (this._date.hour < 18)
      return 12;
    else
      return 18;
  }

  bool isDarkMode() {
    if (this._date.hour < 6)
      return true;
    else if (this._date.hour < 12)
      return false;
    else if (this._date.hour < 18)
      return false;
    else
      return true;
  }
}
