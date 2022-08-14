import 'dart:convert';

import 'package:hltb/private-creds.dart';
import 'package:http/http.dart' as http;

String cleanGameNameForMetacritic(String gameName) {
  // print(gameName);
  final cleanedGameName = gameName
      .toLowerCase()
      .replaceAll(': ', '-')
      .replaceAll('&', '')
      .replaceAll(' ', '-');
  return cleanedGameName;
}

// 'PC',
//     'PlayStation 4',
//     'PlayStation 5',
//     'Xbox One',
//     'Xbox Series X/S'

String unifyPlatformForMetacritic(platforms) {
  // print(platforms);

  if (platforms.contains('PC')) {
    return 'pc';
  } else if (platforms.contains('PlayStation')) {
    return 'playstation';
  } else if (platforms.contains('PlayStation 2')) {
    return 'playstation-2';
  } else if (platforms.contains('PlayStation 4')) {
    return 'playstation-4';
  } else if (platforms.contains('PlayStation 5')) {
    return 'playstation5';
  } else if (platforms.contains('Xbox One')) {
    return 'xbox-one';
  } else if (platforms.contains('Xbox Series X/S')) {
    return 'xbox-series-x';
  } else if (platforms.contains('Xbox 360')) {
    return 'xbox-360';
  } else {
    return '';
  }
}

//fetch game detail from metacritic website
fetchGameDetailFromMetcriticBackendServer(
    uniformPlatform, cleanedGameName) async {
  var res = await http.get(Uri.parse(
      PrivateCreds.METACRITIC_GAME_DETAIL_SERVER +
          'gameDetail/' +
          uniformPlatform +
          '/' +
          cleanedGameName));
  // print(res);
  print(PrivateCreds.METACRITIC_GAME_DETAIL_SERVER +
      'gameDetail/' +
      uniformPlatform +
      '/' +
      cleanedGameName);

  return res;
}

//fetch metacritic game score.
fetchMetascoreFromMetacriticBackendServer(
    uniformPlatform, cleanedGameName) async {
  try {
    var res = await http.get(Uri.parse(
        PrivateCreds.METACRITIC_GAME_DETAIL_SERVER +
            'metascore/' +
            uniformPlatform +
            '/' +
            cleanedGameName));
    if (jsonDecode(res.body)['metascore'] == null) {
      return "Not Found";
    }
    return jsonDecode(res.body)['metascore'];
  } catch (e) {
    return "Not Found";
  }
}
