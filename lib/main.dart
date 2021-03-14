import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:night_and_day/models/Today.dart';

enum Actions { Add }

Today hourReducer(Today state, dynamic action) {
  if (action == Actions.Add) {
    state.date = state.add(Duration(hours: 1));
    return state;
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

class MainPage extends StatelessWidget {
  MainPage({Key key}) : super(key: key);

  Image _getImage(Today now) {
    switch (now.dayMoment()) {
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

  Color _getBackgroundColor(Today now) {
    switch (now.dayMoment()) {
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

  Text _getTodayText(Today now) {
    return Text(
      now.dateToString(),
      style: TextStyle(
        fontFamily: 'FredokaOne',
        fontSize: 30,
        color: (now.isDarkMode()) ? Colors.white : Colors.cyan[800],
      ),
    );
  }

  Text _getDayMomentText(Today now) {
    var label;

    switch (now.dayMoment()) {
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
        color: (now.isDarkMode()) ? Colors.white : Colors.cyan[800],
      ),
    );
  }

  Text _getTimeText(Today now) {
    return Text(
      now.timeToString(),
      style: TextStyle(
        fontFamily: 'FredokaOne',
        fontSize: 20,
        color: (now.isDarkMode()) ? Colors.white : Colors.cyan[800],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedContainer(
        duration: Duration(
          seconds: 1,
        ),
        curve: Curves.fastOutSlowIn,
        width: double.infinity, //full width
        color: _getBackgroundColor(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Column(
              children: [
                _getTodayText(model),
                _getDayMomentText(model),
                _getTimeText(model),
              ],
            ),
            _getImage(model),
            ClockButton(now: model),
          ],
        ),
      ),
    );
  }
}

class NightAndDay extends StatelessWidget {
  NightAndDay({this.store});

  final String appTitle = "Night & Day";
  final Store<Today> store;

  @override
  Widget build(BuildContext context) {
    return new StoreProvider<Today>(
      store: store,
      child: MaterialApp(
        title: appTitle,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: MainPage(),
      ),
    );
  }
}

void main() {
  final store = new Store<Today>(hourReducer, initialState: Today());
  runApp(NightAndDay(store: store));
}
