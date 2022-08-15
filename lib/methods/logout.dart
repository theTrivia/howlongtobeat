import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hltb/providers/fav-scroller-provider.dart';
import 'package:provider/provider.dart';

import '../providers/popular-games-provider.dart';
import '../providers/search-game-provider.dart';
import '../providers/show-overlaw-loader-provider.dart';
import '../providers/user-favourite-game-provider.dart';

class Logout {
  static const secureStorage = FlutterSecureStorage();

  static onLogout(context) async {
    await secureStorage.deleteAll();
    await FirebaseAuth.instance.signOut();
    await Provider.of<FavScrollerProvider>(context, listen: false)
        .setEntriesToNull();

    // await Provider.of<PopularGamesProvider>(context, listen: false)
    //     .setEntriesToNull();

    await Provider.of<SearchGameProvider>(context, listen: false)
        .setEntriesToNull();

    await Provider.of<ShowOverlayLoaderProvider>(context, listen: false)
        .setEntriesToNull();
    await Provider.of<UserFavouriteGameProvider>(context, listen: false)
        .setEntriesToNull();
  }
}
