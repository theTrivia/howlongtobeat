import 'package:flutter/material.dart';

//PROVIDER THAT SAVED MY LIFE xD

class FavScrollerProvider extends ChangeNotifier {
  int _fetchedTill = 0;

  get fetchedTill {
    return _fetchedTill;
  }

  setEntriesToNull() {
    _fetchedTill = 0;
    notifyListeners();
  }

  changeFetchedTillCounter(int index) {
    _fetchedTill = index;
    notifyListeners();
  }
}
