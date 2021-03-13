import 'package:flutter/material.dart';
import 'package:night_and_day/ClockButton.dart';

class MainPage extends StatefulWidget {
  MainPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  bool _darkMode; //from >=18 to <6
  int _hour;
  DateTime _now;

  @override
  void initState() {
    setState(() {
      var nowHour = DateTime.now().hour;

      if (nowHour >= 0 && nowHour < 6) _hour = 0;
      if (nowHour >= 6 && nowHour < 12) _hour = 6;
      if (nowHour >= 12 && nowHour < 18) _hour = 12;
      if (nowHour >= 18 && nowHour < 0) _hour = 18;

      _now = DateTime.now();

      _darkMode = true;
      _hour = 0;
    });

    super.initState();
  }

  void _onDayChange(bool day) {
    setState(() {
      _now = _now.add(
        new Duration(
          days: 1,
        ),
      );
    });
  }

  void _onTimeChange(int hour) {
    setState(() {
      _hour = hour;
      if (_hour >= 18 && _hour < 6)
        _darkMode = true;
      else
        _darkMode = false;
    });
  }

  Image _getImage() {
    switch (_hour) {
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

  Color _getColor() {
    switch (_hour) {
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
        return Colors.blueGrey[900];
    }
  }

  Text _getToday() {
    return Text(
      _now.toString().split(" ")[0],
      style: TextStyle(
        fontFamily: 'FredokaOne',
        fontSize: 30,
        color: (!_darkMode) ? Colors.blueGrey : Colors.white,
      ),
    );
  }

  Text _getLabel() {
    var label;

    switch (_hour) {
      case 0:
        label = "night";
        break;
      case 6:
        label = "morning";
        break;
      case 12:
        label = "midday";
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
        color: (!_darkMode) ? Colors.blueGrey : Colors.white,
      ),
    );
  }

  Text _getHour() {
    String _hourStr;

    if (_hour < 10)
      _hourStr = "0" + _hour.toString();
    else
      _hourStr = _hour.toString();

    return Text(
      _hourStr + ':00 o\'clock',
      style: TextStyle(
        fontFamily: 'FredokaOne',
        fontSize: 20,
        color: (!_darkMode) ? Colors.blueGrey : Colors.white,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity, //full width
        color: _getColor(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Column(
              children: [
                _getToday(),
                _getLabel(),
                _getHour(),
              ],
            ),
            AnimatedOpacity(
              opacity: (_hour == 0) ? 0.0 : 1.0,
              duration: Duration(milliseconds: 800),
              child: _getImage(),
            ),
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
