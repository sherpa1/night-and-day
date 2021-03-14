import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:night_and_day/models/Today.dart';

enum Actions { Add }

Today hourReducer(Today state, dynamic action) {
  if (action == Actions.Add) {
    state.date = state.add(Duration(hours: 1));
    return state;
  }

  return state;
}

// class ClockButton extends StatelessWidget {
//   ClockButton({Key key, this.store}) : super(key: key);

//   Store<Today> store;

//   void _onPress(Today now) {
//     now.add(Duration(hours: 6));
//   }

//   Color _getColor(Today now) {
//     return (!now.isDarkMode()) ? Colors.yellow[600] : Colors.cyan[800];
//   }

//   Color _getIconColor(Today now) {
//     return (!now.isDarkMode()) ? Colors.blueGrey[900] : Colors.white;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return new StoreProvider<Today>(
//       store: store,
//       child: FlatButton(
//         child: Icon(
//           Icons.alarm_add, /*color: _getIconColor(now)*/
//         ),
//         // color: _getColor(now),
//         // onPressed: () => _onPress(now),
//         onPressed: () => print('press'),
//       ),
//     );
//   }
// }

class MainPage extends StatelessWidget {
  MainPage({Key key, this.store}) : super(key: key);

  final Store<Today> store;

  Image _getImage() {
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
    return new StoreProvider<Today>(
      store: store,
      child: Scaffold(
        body: AnimatedContainer(
          duration: Duration(
            seconds: 1,
          ),
          curve: Curves.fastOutSlowIn,
          width: double.infinity, //full width
          //color: _getBackgroundColor(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              new StoreConnector<Today, Today>(
                converter: (store) => store.state,
                builder: (context, today) {
                  return new Text(today.timeToString());
                },
              ),
              Column(
                children: [
                  _getTodayText(),
                  _getDayMomentText(),
                  _getTimeText(),
                ],
              ),
              _getImage(),
              //ClockButton(),
            ],
          ),
        ),
      ),
    );
  }
}

class NightAndDay extends StatelessWidget {
  NightAndDay({this.store});

  final String appTitle = "Night & Day";
  final Store<Today> store;

  @override
  Widget build(BuildContext context) {
    return new StoreProvider<Today>(
      store: store,
      child: MaterialApp(
          title: appTitle,
          theme: ThemeData(
            primarySwatch: Colors.blue,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          home: new StoreProvider<Today>(
            store: store,
            child: MainPage(store: store),
          )),
    );
  }
}

void main() {
  final store = new Store<Today>(hourReducer, initialState: Today());
  runApp(NightAndDay(store: store));
}
