import 'package:flutter/material.dart';
import 'package:night_and_day/ClockButton.dart';
import 'dart:async';

class MainPage extends StatefulWidget {
  MainPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  bool _darkMode; //from >=18 to <6
  int _dayMoment;
  DateTime _now;
  int _counter;

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    setState(() {
      _now = DateTime.now();
      _counter = 0;
      _darkMode = _isDarkMode(_now.hour);
      _dayMoment = _getDayMoment(_now.hour);
    });

    Timer.periodic(Duration(seconds: 1), (timer) {
      _onTimerUpdate();
    });

    super.initState();
  }

  bool _isDarkMode(int hour) {
    if (hour >= 18 || hour < 6) {
      return true;
    } else {
      return false;
    }
  }

  int _getDayMoment(int hour) {
    if (hour < 6)
      return 0;
    else if (hour < 12)
      return 6;
    else if (hour < 18)
      return 12;
    else
      return 18;
  }

  Image _getImage() {
    switch (_dayMoment) {
      case 0:
        return Image(
          width: 250,
          image: AssetImage('assets/images/night.png'),
        );
        break;
      case 6:
      case 18:
        return Image(
          width: 250,
          image: AssetImage('assets/images/evening.png'),
        );
        break;
      case 12:
        return Image(
          width: 250,
          image: AssetImage('assets/images/day.png'),
        );
        break;
      default:
        return Image(
          width: 250,
          image: AssetImage('assets/images/night.png'),
        );
    }
  }

  Color _getBackgroundColor() {
    switch (_dayMoment) {
      case 0:
        return Colors.grey.shade900;
        break;
      case 6:
        return Colors.yellow[300];
        break;
      case 12:
        return Colors.yellow[500];
        break;
      case 18:
        return Colors.blueGrey[600];
        break;
      default:
        return Colors.grey.shade900;
    }
  }

  String _getTodayDate() {
    return _now.toString().split(" ")[0];
  }

  Text _getToday() {
    return Text(
      _getTodayDate(),
      style: TextStyle(
        fontFamily: 'FredokaOne',
        fontSize: 30,
        color: (_darkMode) ? Colors.white : Colors.cyan[800],
      ),
    );
  }

  Text _getDayMomentText() {
    var label;

    switch (_dayMoment) {
      case 0:
        label = "night";
        break;
      case 6:
        label = "morning";
        break;
      case 12:
        label = "afternoon";
        break;
      case 18:
        label = "evening";
        break;
      default:
    }

    return Text(
      label,
      style: TextStyle(
        fontFamily: 'FredokaOne',
        fontSize: 20,
        color: (_darkMode) ? Colors.white : Colors.cyan[800],
      ),
    );
  }

  Text _getTime() {
    var hour =
        (_now.hour < 10) ? "0" + _now.hour.toString() : _now.hour.toString();
    var minute = (DateTime.now().minute < 10)
        ? "0" + DateTime.now().minute.toString()
        : DateTime.now().minute.toString();

    return Text(
      hour + ":" + minute,
      style: TextStyle(
        fontFamily: 'FredokaOne',
        fontSize: 20,
        color: (_darkMode) ? Colors.white : Colors.cyan[800],
      ),
    );
  }

  void _onDayChange(bool day) {
    setState(() {
      _now = _now.add(
        new Duration(
          days: 1,
        ),
      );
    });

    final snackBar = SnackBar(content: Text("Today is ${_getTodayDate()}"));
    //Scaffold.of(context).showSnackBar(snackBar);//can't use classic syntax because we are outside build method
    _scaffoldKey.currentState.showSnackBar(snackBar);
  }

  void _onTimerUpdate() {
    setState(() {
      if (_counter < 10) {
        _counter++;
      } else {
        _counter = 0;
        _onTimeChange(1);
      }
    });
  }

  void _onTimeChange(int hoursToAdd) {
    setState(() {
      _now = _now.add(Duration(hours: hoursToAdd));
      _dayMoment = _getDayMoment(_now.hour);
      _darkMode = _isDarkMode(_now.hour);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key:
          _scaffoldKey, //store context for using it inside _onCharacterRemoved method and showing SnackBar

      body: AnimatedContainer(
        // Define how long the animation should take.
        duration: Duration(seconds: 1),
        // Provide an optional curve to make the animation feel smoother.
        curve: Curves.fastOutSlowIn,
        width: double.infinity, //full width
        color: _getBackgroundColor(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Column(
              children: [
                _getToday(),
                _getDayMomentText(),
                _getTime(),
              ],
            ),
            _getImage(),
            ClockButton(
              onDayChange: _onDayChange,
              onTimeChange: _onTimeChange,
              defaultDay: _darkMode,
            ),
          ],
        ),
      ),
    );
  }
}
