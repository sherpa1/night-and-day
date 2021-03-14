import 'package:flutter/material.dart';
import 'package:night_and_day/models/Today.dart';
import 'package:provider/provider.dart';

class ClockButton extends StatelessWidget {
  ClockButton({Key key}) : super(key: key);

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
    return Consumer<Today>(
      builder: (
        context,
        now,
        child,
      ) =>
          FlatButton(
        child: Icon(Icons.alarm_add, color: _getIconColor(now)),
        color: _getColor(now),
        onPressed: () => _onPress(now),
      ),
    );
  }
}
