import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:night_and_day/models/';

enum Actions { Add }

Today hourReducer(Today state, dynamic action) {
  if (action == Actions.Increment) {
    return state + 1;
  }

  return state;
}

class ClockButton extends StatefulWidget {
  ClockButton({
    Key key,
    @required this.onDayChange,
    @required this.onTimeChange,
    @required this.defaultDay,
  }) : super(key: key);

  final Function onDayChange; //fired at 18 and
  final Function onTimeChange;
  final bool defaultDay; //value set from widget's parent

  @override
  _ClockButtonState createState() => _ClockButtonState();
}

class _ClockButtonState extends State<ClockButton> {
  bool _aNewDayStarts;

  @override
  void initState() {
    setState(() {
      if (widget.defaultDay != null) {
        if (widget.defaultDay) {
          _aNewDayStarts = widget
              .defaultDay; //start value set from local widget constructor param, given from parent
        } else {
          _aNewDayStarts = false;
        }
      } else {
        _aNewDayStarts = false;
      }
    });

    super.initState();
  }

  void _onPress() {
    widget.onTimeChange(6); //add 6 hours to current Date
  }

  Color _getColor() {
    return (_aNewDayStarts) ? Colors.yellow[600] : Colors.cyan[800];
  }

  Color _getIconColor() {
    return (_aNewDayStarts) ? Colors.blueGrey[900] : Colors.white;
  }

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      child: Icon(
        Icons.alarm_add,
        color: _getIconColor(),
      ),
      onPressed: () => _onPress(),
      color: _getColor(),
    );
  }
}

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
  int _counter; //each N seconds call back parent widget

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    setState(() {
      _now = DateTime.now();
      _counter = 0;
      _darkMode = _isDarkMode(_now.hour);
      _dayMoment = _getDayMoment(_now.hour);
    });

    //update time each N second(s)
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

  Text _getTodayText() {
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

  Text _getTimeText() {
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
          days: 1, //add 1 day to current Date
        ),
      );
    });

    final snackBar = SnackBar(content: Text("Today is ${_getTodayDate()}"));
    _scaffoldKey.currentState.showSnackBar(snackBar);
  }

  void _onTimerUpdate() {
    setState(() {
      if (_counter < 10) {
        _counter++;
      } else {
        _counter = 0;
        _onTimeChange(1); //add 1 day to current Date when counter == 10
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
      key: _scaffoldKey,
      body: AnimatedContainer(
        duration: Duration(seconds: 1),
        curve: Curves.fastOutSlowIn,
        width: double.infinity, //full width
        color: _getBackgroundColor(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Column(
              children: [
                _getTodayText(),
                _getDayMomentText(),
                _getTimeText(),
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

void main() {
  runApp(NightAndDay());
}
