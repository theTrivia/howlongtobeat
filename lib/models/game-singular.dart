import 'dart:ffi';

class GameSingular {
  final int id;
  final String name;
  final String imageUrl;
  final Float gameplayMain;
  final Float gameplayMainExtra;
  final Float gameplayCompletionist;

  GameSingular({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.gameplayMain,
    required this.gameplayMainExtra,
    required this.gameplayCompletionist,
  });
}
