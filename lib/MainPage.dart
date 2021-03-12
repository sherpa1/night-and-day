import 'package:flutter/material.dart';
import 'package:night_and_day/ClockButton.dart';

class MainPage extends StatefulWidget {
  MainPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  bool _isDay;
  int _hour;
  DateTime _now = DateTime.now();

  @override
  void initState() {
    _isDay = true;
    super.initState();
  }

  void _onDayChange(bool day) {
    var dayWas = _isDay;

    setState(() {
      _isDay = day;
      if (_isDay && _isDay != dayWas) _now = _now.add(new Duration(days: 1));
    });
  }

  void _onTimeChange(int hour) {
    setState(() {
      _hour = hour;
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
        return Colors.yellow[100];
        break;
      case 12:
        return Colors.yellow[400];
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
        color: (_isDay) ? Colors.blueGrey : Colors.white,
      ),
    );
  }

  Text _getLabel() {
    return Text(
      (_isDay) ? "Day" : "Night",
      style: TextStyle(
        fontFamily: 'FredokaOne',
        fontSize: 20,
        color: (_isDay) ? Colors.blueGrey : Colors.white,
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
        color: (_isDay) ? Colors.blueGrey : Colors.white,
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
              opacity: (_isDay) ? 1.0 : 0.0,
              duration: Duration(milliseconds: 800),
              child: _getImage(),
            ),
            ClockButton(
              onDayChange: _onDayChange,
              onTimeChange: _onTimeChange,
              defaultDay: _isDay,
              onColor: Colors.yellow[600],
              offColor: Colors.blueGrey,
            ),
          ],
        ),
      ),
    );
  }
}
