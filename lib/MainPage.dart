import 'package:flutter/material.dart';
import 'package:night_and_day/ClockButton.dart';
import 'package:night_and_day/models/Today.dart';
import 'package:provider/provider.dart';

class MainPage extends StatelessWidget {
  MainPage({Key key}) : super(key: key);

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  Image _getImage() {
    Today now = _scaffoldKey.currentContext.read<Today>();
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

  Color _getBackgroundColor() {
    Today now = _scaffoldKey.currentContext.read<Today>();
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

  Text _getTodayText() {
    Today now = _scaffoldKey.currentContext.read<Today>();
    return Text(
      now.dateToString(),
      style: TextStyle(
        fontFamily: 'FredokaOne',
        fontSize: 30,
        color: (now.isDarkMode()) ? Colors.white : Colors.cyan[800],
      ),
    );
  }

  Text _getDayMomentText() {
    var label;

    Today now = _scaffoldKey.currentContext.read<Today>();

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

  Text _getTimeText() {
    Today now = _scaffoldKey.currentContext.read<Today>();

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
      key: _scaffoldKey,
      body: Consumer<Today>(
        builder: (
          context,
          now,
          child,
        ) =>
            AnimatedContainer(
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
                  _getTodayText(),
                  _getDayMomentText(),
                  _getTimeText(),
                ],
              ),
              _getImage(),
              ClockButton(),
            ],
          ),
        ),
      ),
    );
  }
}
