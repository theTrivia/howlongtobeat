import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import '../private-creds.dart';

class PopularGamesProvider extends ChangeNotifier {
  var _popularGameResult = [];

  get popularGames {
    return _popularGameResult;
  }

  getPopularGames() async {
    try {
      var result =
          await http.get(Uri.parse(PrivateCreds.HLTB_SERVER + 'popularGames'));
      _popularGameResult = jsonDecode(result.body)['popularGames'];
      print(_popularGameResult);
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }
}
