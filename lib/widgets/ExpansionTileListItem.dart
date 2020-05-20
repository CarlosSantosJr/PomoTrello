import 'package:PomoTrello/models/TrelloCard.dart';
import 'package:PomoTrello/models/TrelloList.dart';
import 'package:PomoTrello/pages/PomodoroPage.dart';
import 'package:flutter/material.dart';

class ExpansionTileListItem extends StatefulWidget {
  final TrelloList list;

  ExpansionTileListItem({this.list});

  @override
  _ExpansionTileListItemState createState() => _ExpansionTileListItemState();
}

class _ExpansionTileListItemState extends State<ExpansionTileListItem> {
  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
        title: Text(widget.list.name),
        children: widget.list.cards
            .map((e) => ListTile(
                  title: Text(e.name),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PomodoroPage(
                          card: e,
                        ),
                      ),
                    );
                  },
                ))
            .toList());
  }
}
