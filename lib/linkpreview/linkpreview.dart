import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;
import 'package:http/http.dart' as http;

class LinkPreview {
  static const String _baseUrl = "http://api.linkpreview.net/";
  static final Map _previewCache = {};
  static String _apiKey;

  static Future<String> getPreview(String url) async {
    if (_previewCache.containsKey(url)) {
      return _previewCache[url];
    }

    String apiKey = await _getApiKey();
    String requestUrl = "$_baseUrl?key=$apiKey&q=$url";
    final response = await http.get(requestUrl);

    if (response.statusCode == 200) {
      String imageUrl = (json.decode(response.body) as Map)["image"];
      _previewCache[url] = imageUrl;

      return imageUrl;
    } else {
      print("Couldn't load $requestUrl");
      throw Exception("Couldn't load $requestUrl");
    }
  }

  static Future<String> _getApiKey() async {
    if (_apiKey == null) {
      String apiKeysJson = await rootBundle.loadString("secrets/api_keys.json");
      _apiKey = json.decode(apiKeysJson)["linkpreview"];

      if (_apiKey == null) {
        throw Exception("Failed to load linkpreview API key!");
      }
    }

    return _apiKey;
  }
}
