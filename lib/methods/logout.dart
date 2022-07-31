import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hltb/providers/user-favourite-game-provider.dart';
import 'package:provider/provider.dart';

import '../providers/search-game-provider.dart';

class Logout {
  static final secureStorage = const FlutterSecureStorage();

  static onLogout(context) async {
    await secureStorage.deleteAll();
    await FirebaseAuth.instance.signOut();
    await Provider.of<SearchGameProvider>(context, listen: false)
        .setSearchResultToNull();
    await Provider.of<UserFavouriteGameProvider>(context, listen: false)
        .setSearchResultToNull();
  }
}
