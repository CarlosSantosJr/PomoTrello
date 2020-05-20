import 'package:PomoTrello/models/Board.dart';
import 'package:PomoTrello/pages/BoardPage.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String trelloKey = '8ea781e518c0687a336de2647b651149';
  String token =
      '8d435577cbece998c05ef2dd833760282aae1ebbe81a4cd205e8a526c511baf2';

  Future<List<Board>> futureBoards;

  @override
  void initState() {
    super.initState();
    futureBoards = Board.getBoards(trelloKey, token);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: FutureBuilder<List<Board>>(
        future: futureBoards,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                Board board = snapshot.data[index];
                if (!board.closed) {
                  return ListTile(
                    title: Text(board.name),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BoardPage(
                            board: board,
                            trelloKey: trelloKey,
                            token: token,
                          ),
                        ),
                      );
                    },
                  );
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
