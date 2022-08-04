import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../private-creds.dart';

class SearchGameProvider extends ChangeNotifier {
  var _searchResult = [];

  get searchResult {
    return _searchResult;
  }

  setSearchResultToNull() {
    _searchResult = [];
    notifyListeners();
  }

  searchGames(gameName) async {
    try {
      var result = await http
          .get(Uri.parse(PrivateCreds.HELPER_SERVER + 'getGames/' + gameName));
      _searchResult = jsonDecode(result.body)['result'];
      // print(_searchResult);
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }
}
