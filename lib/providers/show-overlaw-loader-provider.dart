import 'package:flutter/material.dart';

class ShowOverlayLoaderProvider extends ChangeNotifier {
  var _shouldShowOverlayLoader = false;
  get shouldShowOverlayLoader {
    return _shouldShowOverlayLoader;
  }

  changeShowOverlayState(s) {
    _shouldShowOverlayLoader = s;
    notifyListeners();
  }
}
