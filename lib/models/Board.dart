import 'package:http/http.dart' as http;
import 'dart:convert';

class Board {
  String name;
  bool closed;
  String id;

  Board({this.name, this.closed, this.id});

  Board.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    closed = json['closed'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['closed'] = this.closed;
    data['id'] = this.id;
    return data;
  }

  static Future<List<Board>> getBoards(String key, String token) async {
    final response = await http.get(
        'https://api.trello.com/1/members/me/boards?fields=name,closed&key=${key}&token=${token}');

    if (response.statusCode == 200) {
      var boards = (json.decode(response.body) as List)
          .map((i) => Board.fromJson(i))
          .toList();

      return boards;
    } else {
      throw Exception('Failed to load boards');
    }
  }
}
