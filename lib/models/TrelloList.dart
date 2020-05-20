import 'package:PomoTrello/models/TrelloCard.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class TrelloList {
  String id;
  String name;
  bool closed;
  String idBoard;
  List<TrelloCard> cards = [];

  TrelloList({this.id, this.name, this.closed, this.idBoard});

  TrelloList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    closed = json['closed'];
    idBoard = json['idBoard'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['closed'] = this.closed;
    data['idBoard'] = this.idBoard;
    return data;
  }

  static Future<List<TrelloList>> getBoardLists(String key, String token, String boardId) async {
    final response = await http.get(
        'https://api.trello.com/1/boards/${boardId}/lists?key=${key}&token=${token}');

    if (response.statusCode == 200) {
      var lists = (json.decode(response.body) as List)
          .map((i) => TrelloList.fromJson(i))
          .toList();

      return lists;
    } else {
      throw Exception('Failed to load Lists');
    }
  }
}
