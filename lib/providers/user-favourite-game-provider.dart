import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../model/game.dart';

class UserFavouriteGameProvider extends ChangeNotifier {
  final secureStorage = FlutterSecureStorage();
  final db = FirebaseFirestore.instance;
  var _userFavouriteGameList = [];
  var _favGameDetails = [];

  get userFavouriteGameList {
    return _userFavouriteGameList;
  }

  get favGameDetails {
    return _favGameDetails;
  }

  setSearchResultToNull() {
    _userFavouriteGameList = [];
    notifyListeners();
  }

  //should be called at the time of launching the application
  fetchFavouriteGamesFromDatabase() async {
    var userData;
    final _uid = await secureStorage.read(key: 'uid');

    await db.collection('user-data').doc(_uid).get().then(
          (value) => {
            userData = value.data(),
          },
        );
    final List favGames = userData['fav-games'];
    _userFavouriteGameList = favGames;
    return _userFavouriteGameList;
    // print(_userFavouriteGames);
    // notifyListeners();
  }

  //should be called at the time of launching the application
  fetchFavouriteGameDetails() async {
    var gameIds = await fetchFavouriteGamesFromDatabase();
    print(gameIds);
    var _searchResult = [];

    for (var i = 0; i < gameIds.length; i++) {
      try {
        var result = await http.get(
          Uri.parse('http://192.168.0.182:3000/gameDetail/' + gameIds[i]),
        );
        // print(result.body);
        var formattedResult = jsonDecode(result.body)['result'];
        // return formattedResult;
        // print(formattedResult);
        _searchResult.add(formattedResult);
      } catch (e) {
        print(e);
      }
    }
    _favGameDetails = _searchResult;
    notifyListeners();
  }

  addFavouriteGamesToList(Game game) {
    _favGameDetails.add(game);
    print(_favGameDetails);
    notifyListeners();
  }

  removeFavouriteGameFromList() {}
}
