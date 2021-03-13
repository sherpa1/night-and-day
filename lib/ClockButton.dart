import 'package:night_and_day/models/Today.dart';
import 'package:flutter/material.dart';

class ClockButton extends StatelessWidget {
  ClockButton({
    Key key,
    @required this.now,
    @required this.darkMode,
  }) : super(key: key);

  final bool darkMode; //value set from widget's parent
  final Today now;

  void _onPress() {
    now.add(
      Duration(hours: 6),
    );
  }

  Color _getColor() {
    return (!now.isDarkMode()) ? Colors.yellow[600] : Colors.cyan[800];
  }

  Color _getIconColor() {
    return (!now.isDarkMode()) ? Colors.blueGrey[900] : Colors.white;
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
