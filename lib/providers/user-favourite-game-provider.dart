import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../private-creds.dart';
import '../model/game.dart';

class UserFavouriteGameProvider extends ChangeNotifier {
  final secureStorage = FlutterSecureStorage();
  final db = FirebaseFirestore.instance;
  var _userFavouriteGameList = [];
  var _favGameDetails = {};

  get userFavouriteGameList {
    return _userFavouriteGameList;
  }

  get favGameDetails {
    return _favGameDetails;
  }

  setEntriesToNull() {
    _userFavouriteGameList = [];
    _favGameDetails = {};
    notifyListeners();
  }

/////////////////////////////////////// Methods to alter _userFavouriteGameList ////////////////////////////////
  addFavGameIdToList(id) {
    _userFavouriteGameList.add(id);
    notifyListeners();
  }

  removeFavGameIdFromList(id) {
    _userFavouriteGameList.remove(id);
    notifyListeners();
  }
  ///////////////////////////////////////////////////////////////////////////////////////////////////////////////

  addFavGameDetailToList(Map gameDetail) {
    gameDetail.keys.forEach((k) {
      _favGameDetails[k] = gameDetail[k];
    });

    notifyListeners();
  }

  removeFavGameDetailFromList(gameId) {
    _favGameDetails.removeWhere(((key, value) => key == gameId.toString()));
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
    var newList = [];
    for (int i = 0; i < favGames.length; i++) {
      newList.add(favGames[i]);
    }
    _userFavouriteGameList = newList;
    notifyListeners();
  }
}
