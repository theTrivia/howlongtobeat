import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SearchGameProvider extends ChangeNotifier {
  var _searchResult = [];

  get searchResult {
    return _searchResult;
  }

  searchGames(gameName) async {
    try {
      var result = await http
          .get(Uri.parse('http://192.168.0.182:3000/getGames/' + gameName));
      _searchResult = jsonDecode(result.body)['result'];
      // print(_searchResult);
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }
}
