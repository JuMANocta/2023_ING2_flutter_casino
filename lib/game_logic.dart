import 'dart:math';

class GameLogic {
  int solde;
  int chiffre;
  int mise;
  late int croupier;
  late bool isWinner;
  late String message;

  GameLogic({required this.solde, required this.chiffre, required this.mise});

  void play() {
    croupier = Random().nextInt(50);

    if (chiffre == croupier) {
      isWinner = true;
      solde += mise * 3;
      message = 'Félicitation ! Vous avez gagné ${mise * 3}€';
    } else if (chiffre % 2 == 0 && croupier % 2 == 0 ||
        chiffre % 2 == 1 && croupier % 2 == 1) {
      String couleur = 'ROUGE';
      isWinner = true;
      solde += (mise * 0.5).ceil();
      if (chiffre % 2 == 1) {
        couleur = 'NOIR';
      }
      message =
          'Félicitation ! Vous avez gagné $mise€ grâce à la couleur $couleur';
    } else {
      isWinner = false;
      solde -= mise;
      message = 'Dommage ... Vous avez perdu $mise€';
    }
  }
}
