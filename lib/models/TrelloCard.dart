import 'package:http/http.dart' as http;
import 'dart:convert';


class TrelloCard {
  String id;
  bool closed;
  String name;

  TrelloCard({this.id, this.closed, this.name});

  TrelloCard.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    closed = json['closed'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['closed'] = this.closed;
    data['name'] = this.name;
    return data;
  }

  static Future<List<TrelloCard>> getListCards(String key, String token, String listId) async {
    final response = await http.get(
        'https://api.trello.com/1/lists/${listId}/cards?key=${key}&token=${token}');

    if (response.statusCode == 200) {
      var cards = (json.decode(response.body) as List)
          .map((i) => TrelloCard.fromJson(i))
          .toList();

      return cards;
    } else {
      throw Exception('Failed to load Cards');
    }
  }
}