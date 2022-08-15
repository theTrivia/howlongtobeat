import 'package:flutter/material.dart';

class ShowOverlayLoaderProvider extends ChangeNotifier {
  var shouldShowOverlayLoader = false;
  // get shouldShowOverlayLoader {
  //   return _shouldShowOverlayLoader;
  // }

  setEntriesToNull() {
    shouldShowOverlayLoader = false;
    notifyListeners();
  }

  changeShowOverlayState(s) {
    shouldShowOverlayLoader = s;
    notifyListeners();
  }
}
