import 'package:flutter/material.dart';

class ClockButton extends StatefulWidget {
  ClockButton({
    Key key,
    @required this.onDayChange,
    @required this.onTimeChange,
    @required this.defaultDay,
  }) : super(key: key);

  final Function onDayChange; //fired at 18 and
  final Function onTimeChange; //fired each 6 hours
  final bool defaultDay; //value set from widget's parent

  @override
  _ClockButtonState createState() => _ClockButtonState();
}

class _ClockButtonState extends State<ClockButton> {
  bool _aNewDayStarts;
  int _hour;

  @override
  void initState() {
    setState(() {
      if (widget.defaultDay != null) {
        if (widget.defaultDay) {
          _aNewDayStarts = widget
              .defaultDay; //start value set from local widget constructor param, given from parent
          _hour = 6; //local logic
        } else {
          _aNewDayStarts = false;
          _hour = 0; //local logic
        }
      } else {
        _aNewDayStarts = false;
        _hour = 0;
      }
    });

    if (widget.defaultDay) {
      _hour = 0;
    }

    super.initState();
  }

  void _onPress() {
    //each time state is set, build method is executed and all conditionnal displays are re-evaluated
    setState(() {
      if (_hour == 18) {
        _hour = 0;
        _aNewDayStarts = true;
        widget.onDayChange(
          _aNewDayStarts,
        ); //calling back parent method and give local state value
      } else {
        _hour += 6;
        _aNewDayStarts = false;
      }
    });

    widget.onTimeChange(
      _hour,
    );
  }

  Color _getColor() {
    return (_aNewDayStarts) ? Colors.yellow[600] : Colors.blueGrey;
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      FlatButton(
        child: Icon(Icons.alarm_add),
        onPressed: () => _onPress(),
        color: _getColor(),
      ),
    ]);
  }
}
