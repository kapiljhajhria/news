import 'dart:convert';
import 'package:http/http.dart' show Client;
import 'package:news/src/resources/repository.dart';
import '../models/item_model.dart';
import 'dart:async';

class NewsApiProvider implements Source {
  Client client = Client();
  List<int> topIds = [];
  String _rootUrl = "https://hacker-news.firebaseio.com/v0";

  Future<List<int>> fetchTopIds() async {
    final response = await client.get("$_rootUrl/topstories.json");
    final ids = json.decode(response.body);
    return ids.cast<int>();
  }

  Future<ItemModel> fetchItem(int id) async {
    final response = await client.get("$_rootUrl/item/$id.json");
    final parsedJson = json.decode(response.body);
    return ItemModel.fromJson(parsedJson);
  }
}
