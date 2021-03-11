import 'package:flutter/material.dart';

class Button extends StatefulWidget {
  Button({Key key, this.visited}) : super(key: key);

  final bool visited;

  @override
  _ButtonState createState() => _ButtonState();
}

class _ButtonState extends State<Button> {
  int _status = 0;

  @override
  void initState() {
    if (widget.visited) {
      setState(() {
        _status = 1;
      });
    }

    super.initState();
  }

  void _onPress() {
    if (_status == 0) {
      setState(() {
        _status = 1;
      });
    } else if (_status == 1) {
      setState(() {
        _status = 0;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(_status.toString()),
        RaisedButton(
          onPressed: () => _onPress(),
          child: Text("click"),
        )
      ],
    );
  }
}
