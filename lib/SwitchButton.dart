import 'package:flutter/material.dart';

class SwitchButton extends StatefulWidget {
  SwitchButton({
    Key key,
    @required this.onChange,
    @required this.defaultStatus,
    @required this.onLabel,
    @required this.offLabel,
    @required this.onColor,
    @required this.offColor,
  }) : super(key: key);

  final bool defaultStatus;
  final String onLabel;
  final String offLabel;
  final Color onColor;
  final Color offColor;
  final Function onChange;

  @override
  _SwitchButtonState createState() => _SwitchButtonState();
}

class _SwitchButtonState extends State<SwitchButton> {
  bool _status = false;

  @override
  void initState() {
    if (widget.defaultStatus) {
      setState(() {
        _status = widget.defaultStatus;
      });
    }

    super.initState();
  }

  void _onPress() {
    setState(() {
      _status = !_status;
    });

    widget.onChange(_status);
  }

  Color _getColorAccordingToStatus() {
    return (_status) ? widget.onColor : widget.offColor;
  }

  String _getLabel() {
    return (_status) ? widget.onLabel : widget.offLabel;
  }

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: () => _onPress(),
      child: Text(_getLabel()),
      color: _getColorAccordingToStatus(),
    );
  }
}
