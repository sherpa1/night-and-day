import 'package:flutter/material.dart';

class ClockButton extends StatefulWidget {
  ClockButton({
    Key key,
    @required this.onDayChange,
    @required this.onTimeChange,
    @required this.defaultDay,
    @required this.onColor,
    @required this.offColor,
  }) : super(key: key);

  final Function onDayChange;
  final Function onTimeChange;
  final bool defaultDay; //value set from widget's parent
  final Color onColor;
  final Color offColor;

  @override
  _ClockButtonState createState() => _ClockButtonState();
}

class _ClockButtonState extends State<ClockButton> {
  bool _newDay = false;
  int _hour = 0;

  @override
  void initState() {
    setState(() {
      if (widget.defaultDay != null) {
        if (widget.defaultDay) {
          _newDay = widget
              .defaultDay; //start value set from local widget constructor param, given from parent
          _hour = 6; //local logic
        } else {
          _newDay = false;
          _hour = 0; //local logic
        }
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
      _hour += 6;

      if (_hour == 24) _hour = 0;

      _newDay = (_hour >= 6 && _hour <= 18);
    });

    if (_hour >= 6 || _hour <= 18) {
      widget.onDayChange(
        _newDay,
      ); //calling back parent method and give local state value
      widget.onTimeChange(
        _hour,
      );
    } else {
      widget.onTimeChange(
        _hour,
      );
    }
  }

  Color _getColor() {
    return (_newDay) ? widget.onColor : widget.offColor;
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
