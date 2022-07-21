import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SearchGameDetailProvider extends ChangeNotifier {
  var _gameSearchResult = [];

  get gameSearchResult {
    return _gameSearchResult;
  }

  setGameSearchResultToNull() {
    _gameSearchResult = [];
    notifyListeners();
  }

  getGameDetail(gameId) async {
    try {
      var result = await http
          .get(Uri.parse('http://192.168.0.182:3000/gameDetail/' + gameId));
      print(result.body);
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }
}
