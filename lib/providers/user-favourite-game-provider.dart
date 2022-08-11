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

  setSearchResultToNull() {
    _userFavouriteGameList = [];
    notifyListeners();
  }

/////////////////////////////////////// Methods to alter _userFavouriteGameList ////////////////////////////////
  addFavGameIdToList(id) {
    _userFavouriteGameList.add(id);
    print('fav game list from provider ${_userFavouriteGameList}');
    notifyListeners();
  }

  removeFavGameIdFromList(id) {
    _userFavouriteGameList.remove(id);
    print('ids after removing from the list ${_userFavouriteGameList}');
    notifyListeners();
  }
  ///////////////////////////////////////////////////////////////////////////////////////////////////////////////

  addFavGameDetailToList(Map gameDetail) {
    // print(gameDetail);
    gameDetail.keys.forEach((k) {
      print('from provider');
      print(k);
      _favGameDetails[k] = gameDetail[k];
      // print(_favGameDetails.length);
      // notifyListeners();
    });

    // print('----------------');
    // print(_favGameDetails.length);
    notifyListeners();
  }

  removeFavGameDetailFromList(gameId) {
    print(gameId);
    print(
        'b4 -------------    details after getting removed from the list ${_favGameDetails.keys.length}');
    // _favGameDetails.remove(gameId);
    _favGameDetails.removeWhere(((key, value) => key == gameId.toString()));
    print(
        'after -----------   details after getting removed from the list ${_favGameDetails.keys.length}');
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
    // print(_userFavouriteGameList[0].runtimeType);
    notifyListeners();
    // return _userFavouriteGameList;
    // print(_userFavouriteGames);
  }

  //should be called at the time of launching the application
  // fetchFavouriteGameDetails() async {
  //   var gameIds = await fetchFavouriteGamesFromDatabase();
  //   print(gameIds);
  //   var _searchResult = [];

  //   for (var i = 0; i < gameIds.length; i++) {
  //     try {
  //       var result = await http.get(
  //         Uri.parse(PrivateCreds.HELPER_SERVER + 'gameDetail/' + gameIds[i]),
  //       );
  //       // print(result.body);
  //       var formattedResult = jsonDecode(result.body)['result'];
  //       // return formattedResult;
  //       // print(formattedResult);
  //       _searchResult.add(formattedResult);
  //     } catch (e) {
  //       print(e);
  //     }
  //   }
  //   _favGameDetails = _searchResult;
  //   notifyListeners();
  // }

////////////////////// junk methods //////////////////////

}
