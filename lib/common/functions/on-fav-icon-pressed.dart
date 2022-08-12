import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:hltb/private-creds.dart';
import 'package:hltb/providers/show-overlaw-loader-provider.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import '../../providers/user-favourite-game-provider.dart';

final secureStorage = FlutterSecureStorage();

var db = FirebaseFirestore.instance;

onFavIconPress(gameId, context) async {
  // print(gameId);
  //delay for testing purpose

  Provider.of<ShowOverlayLoaderProvider>(context, listen: false)
      .changeShowOverlayState(true);
  // await Future.delayed(Duration(seconds: 5));
  await checkAndSaveGameIfUserLikesTheGame(gameId, context).then((_) {
    Provider.of<ShowOverlayLoaderProvider>(context, listen: false)
        .changeShowOverlayState(false);
  });
}

//searches for the game id is present in user's database. If the game is not present, then the game is added
checkAndSaveGameIfUserLikesTheGame(gameId, context) async {
  var userData;
  final _uid = await secureStorage.read(key: 'uid');

  await db.collection('user-data').doc(_uid).get().then(
        (value) => {
          userData = value.data(),
        },
      );

  var userFavGames = userData['fav-games'];

  // adds the game to users database
  if (userFavGames.contains(gameId) == false) {
    print('game doesnot contain in user\'s favourite list');
    await db.collection('user-data').doc(_uid).set({
      'fav-games': [...userFavGames, gameId]
    });
    //adding the game in users fav list provider.
    Provider.of<UserFavouriteGameProvider>(context, listen: false)
        .addFavGameIdToList(gameId);

    var res = await http.get(
      Uri.parse(PrivateCreds.HELPER_SERVER + 'gameDetail/' + gameId.toString()),
    );
    var r = jsonDecode(res.body)['result'];
    Provider.of<UserFavouriteGameProvider>(context, listen: false)
        .addFavGameDetailToList({gameId: r});

    print('game added to list successfully');
  }
  // remove the game id from users database
  else {
    await removeTheGameIdFromUserDatabase(userFavGames, gameId, _uid, context);
    // print('game already present in user\'s fav list');
    Provider.of<UserFavouriteGameProvider>(context, listen: false)
        .removeFavGameIdFromList(gameId);
    Provider.of<UserFavouriteGameProvider>(context, listen: false)
        .removeFavGameDetailFromList(gameId);
    userFavGames.remove(gameId);
    // await db.collection('user-data').doc(_uid).set(
    //   {
    //     'fav-games': userFavGames,
    //   },
    // );

    print(gameId);
    print('gameId removed from the user\'s list');
  }
  return;
}

//saves the gameId to users database
saveTheGameIdToUserDatabase() async {}

//removes the gameId from the users database
removeTheGameIdFromUserDatabase(
  List userFavGameList,
  gameId,
  _uid,
  context,
) async {
  userFavGameList.remove(gameId);
  await db.collection('user-data').doc(_uid).set(
    {
      'fav-games': userFavGameList,
    },
  );
  // Provider.of<UserFavouriteGameProvider>(context, listen: false)
  //     .fetchFavouriteGameDetails();
  print('item removed from db');
  return;
}
