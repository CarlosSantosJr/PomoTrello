import 'package:PomoTrello/models/TrelloCard.dart';
import 'package:flutter/material.dart';

class PomodoroPage extends StatefulWidget {
  final TrelloCard card;

  PomodoroPage({@required this.card});

  @override
  _PomodoroPageState createState() => _PomodoroPageState();
}

class _PomodoroPageState extends State<PomodoroPage> {
  TextStyle cardNameStyle =
      const TextStyle(color: Colors.white, fontSize: 20.0);
  TextStyle buttonTextStyle =
      const TextStyle(color: Colors.white, fontSize: 20.0);
  TextStyle timerTextStyle =
      const TextStyle(color: Colors.white, fontSize: 50.0);

  bool timerOn = false;
  bool pomodoroDone = false;

  // void onClickCallback(){}

  // void timerUpCallback(){}

  Widget buttons_row() {
    if (timerOn) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          RaisedButton(
            child: Text('Pause', style: buttonTextStyle),
            onPressed: () {},
            color: Colors.black,
            splashColor: Colors.red,
          ),
          SizedBox(width: 20.0),
          RaisedButton(
            child: Text('Done', style: buttonTextStyle),
            onPressed: () {},
            color: Colors.black,
            splashColor: Colors.green,
          ),
        ],
      );
    } else {
      if (pomodoroDone) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RaisedButton(
              child: Text('Start', style: buttonTextStyle),
              onPressed: () {},
              color: Colors.black,
              splashColor: Colors.red,
            ),
            SizedBox(width: 20.0),
            RaisedButton(
              child: Text('Done', style: buttonTextStyle),
              onPressed: () {},
              color: Colors.black,
              splashColor: Colors.green,
            ),
          ],
        );
      } else {
        return RaisedButton(
          color: Colors.black,
          splashColor: Colors.green,
          onPressed: () {
            setState(() {
              timerOn = true;
            });
          },
          child: Text('Start', style: buttonTextStyle),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              widget.card.name,
              style: cardNameStyle,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 40.0),
            Text('25:00', style: timerTextStyle),
            SizedBox(height: 30.0),
            buttons_row(),
          ],
        ),
      ),
    );
  }
}
