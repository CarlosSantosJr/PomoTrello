import 'package:PomoTrello/models/Board.dart';
import 'package:PomoTrello/models/TrelloList.dart';
import 'package:PomoTrello/models/TrelloCard.dart';
import 'package:PomoTrello/widgets/ExpansionTileListItem.dart';

import 'package:flutter/material.dart';


class BoardPage extends StatefulWidget {
  final String trelloKey;
  final String token;
  final Board board;

  BoardPage({Key key, this.trelloKey, this.token, this.board})
      : super(key: key);

  @override
  _BoardPageState createState() => _BoardPageState();
}

class _BoardPageState extends State<BoardPage> {
  Future<List<TrelloList>> futureLists;

  Future<List<TrelloList>> getLists() async {
    List<TrelloList> lists = await TrelloList.getBoardLists(widget.trelloKey, widget.token, widget.board.id);

    for (int i = 0; i < lists.length; i++) {
      lists[i].cards = await TrelloCard.getListCards(widget.trelloKey, widget.token, lists[i].id);
    }

    return lists; 
  }

  @override
  void initState() {
    super.initState();
    futureLists = getLists();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Board: ${widget.board.name}'),
      ),
      body: FutureBuilder<List<TrelloList>>(
        future: futureLists,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                TrelloList list = snapshot.data[index];
                if (!list.closed) {
                  return ExpansionTileListItem(list: list);
                }
                return null;
              },
              itemCount: snapshot.data.length,
            );
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
