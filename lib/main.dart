import 'package:flutter/material.dart';
import 'package:night_and_day/models/Today.dart';
import 'package:scoped_model/scoped_model.dart';

class ClockButton extends StatelessWidget {
  ClockButton({Key key, this.now}) : super(key: key);

  final Today now;

  void _onPress(Today now) {
    now.add(Duration(hours: 6));
  }

  Color _getColor(Today now) {
    return (!now.isDarkMode()) ? Colors.yellow[600] : Colors.cyan[800];
  }

  Color _getIconColor(Today now) {
    return (!now.isDarkMode()) ? Colors.blueGrey[900] : Colors.white;
  }

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      child: Icon(Icons.alarm_add, color: _getIconColor(now)),
      color: _getColor(now),
      onPressed: () => _onPress(now),
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
    return ScopedModelDescendant<Today>(
      builder: (context, child, model) => Scaffold(
        body: AnimatedContainer(
          duration: Duration(
            seconds: 1,
          ),
          curve: Curves.fastOutSlowIn,
          width: double.infinity, //full width
          color: _getBackgroundColor(model),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              ScopedModelDescendant<Today>(
                builder: (context, child, model) => Column(
                  children: [
                    _getTodayText(model),
                    _getDayMomentText(model),
                    _getTimeText(model),
                  ],
                ),
              ),
              ScopedModelDescendant<Today>(
                builder: (context, child, model) => _getImage(model),
              ),
              ScopedModelDescendant<Today>(
                builder: (context, child, model) => ClockButton(now: model),
              ),
            ],
          ),
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
        home: ScopedModel<Today>(
          model: Today(),
          child: MainPage(),
        ));
  }
}

void main() {
  runApp(
    NightAndDay(),
  );
}
