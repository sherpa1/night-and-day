import 'dart:async';
import 'package:scoped_model/scoped_model.dart';

class Today extends Model {
  Today([DateTime defaultDate]) {
    if (defaultDate == null)
      this.date = DateTime.now();
    else
      this.date = defaultDate;

    Timer.periodic(Duration(seconds: 1), (timer) {
      onTimerUpdate();
    });
  }

  DateTime date;

  int counter = 0;

  void add(Duration duration) {
    date = date.add(duration);
    notifyListeners();
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
    notifyListeners();
  }

  void _onTimeChange(int hoursToAdd) {
    date = date.add(Duration(hours: hoursToAdd));
  }

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
