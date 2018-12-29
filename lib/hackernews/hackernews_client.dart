import 'dart:convert';

import 'package:hatter_news/hackernews/item.dart';
import 'package:http/http.dart' as http;

class HackernewsClient {
  static final String apiVersion = "v0";
  static final String baseUrl =
      "https://hacker-news.firebaseio.com/$apiVersion/";

  static Future<List<Item>> getItemsByType(String type, int maxAmount) async {
    String url = baseUrl + type + ".json";
    final response = await http.get(url);

    if (response.statusCode == 200) {
      List<String> responseBody = (json.decode(response.body) as List)
          .sublist(0, maxAmount)
          .map((id) => id.toString())
          .where((id) => id != null)
          .toList();
      return toItems(responseBody);
    } else {
      throw Exception("Couldn't load $type");
    }
  }

  static Future<List<Item>> toItems(List<String> ids) async {
    final items = await Future.wait(ids.map((id) => getItemById(id)));

    return items.where((item) => item != null).toList();
  }

  static Future<Item> getItemById(String id) async {
    String url = baseUrl + "item/" + id + ".json";
    final response = await http.get(url);

    if (response.body == 'null') {
      return null;
    } else {
      try {
        return Item.fromJson(json.decode(response.body));
      } catch (err) {
        print(err);
        return null;
      }
    }
  }
}
