import 'package:flutter/material.dart';

class ShowOverlayLoaderProvider extends ChangeNotifier {
  var _shouldShowOverlayLoader = false;
  get shouldShowOverlayLoader {
    return _shouldShowOverlayLoader;
  }

  setEntriesToNull() {
    _shouldShowOverlayLoader = false;
    notifyListeners();
  }

  changeShowOverlayState(s) {
    _shouldShowOverlayLoader = s;
    notifyListeners();
  }
}
