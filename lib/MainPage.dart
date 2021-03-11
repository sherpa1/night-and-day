import 'package:flutter/material.dart';
import 'package:night_and_day/SwitchButton.dart';

class MainPage extends StatefulWidget {
  MainPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  bool _isDay;

  @override
  void initState() {
    _isDay = true;
    super.initState();
  }

  void _onChange(bool value) {
    setState(() {
      _isDay = value;
    });
  }

  Image _getImage() {
    return (_isDay)
        ? Image(
            width: 100,
            image: AssetImage('assets/images/day.png'),
          )
        : Image(
            width: 100,
            image: AssetImage('assets/images/night.png'),
          );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            _getImage(),
            SwitchButton(
              onChange: _onChange,
              defaultStatus: _isDay,
              onLabel: "Day",
              offLabel: "Night",
              onColor: Colors.yellow,
              offColor: Colors.blueGrey,
            ),
          ],
        ),
      ),
    );
  }
}
