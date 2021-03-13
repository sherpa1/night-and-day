import 'package:flutter/material.dart';

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
    widget.onTimeChange(6);
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
