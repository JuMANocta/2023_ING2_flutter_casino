import 'package:casino_2023_ing2_flutter/end_game_screen.dart';
import 'package:casino_2023_ing2_flutter/game_logic.dart';
import 'package:flutter/material.dart';
import 'package:confetti/confetti.dart';
import 'dart:math';

class ResultScreen extends StatefulWidget {
  final int solde;
  final int chiffre;
  final int mise;
  final bool isWinner;
  final int croupier;
  final String message;
  final Function onPlayAgain;

  const ResultScreen({
    Key? key,
    required this.solde,
    required this.chiffre,
    required this.mise,
    required this.isWinner,
    required this.croupier,
    required this.message,
    required this.onPlayAgain,
  }) : super(key: key);

  @override
  _ResultScreenState createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  late ConfettiController _controllerConfetti;

  String roulette() {
    // creer un tableau de roulette
    List<String> roulette = [
      'assets/images/roulette1.jpg',
      'assets/images/roulette2.jpg',
      'assets/images/roulette3.jpg',
      'assets/images/roulette4.jpg',
      'assets/images/roulette5.jpg',
      'assets/images/roulette6.jpg',
      'assets/images/roulette7.jpg'
    ];
    // choisir un index au hasard
    int index = Random().nextInt(roulette.length);
    return roulette[index];
  }

  @override
  void initState() {
    super.initState();
    _controllerConfetti =
        ConfettiController(duration: const Duration(seconds: 3));
    if (widget.isWinner) {
      _controllerConfetti.play();
    }
  }

  @override
  void dispose() {
    _controllerConfetti.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData themeCasino = Theme.of(context);
    return WillPopScope(
      onWillPop: () async => false, // Empêche la navigation en arrière
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Casino App - Résultat'),
          centerTitle: true,
          leading: const SizedBox.shrink(),
        ),
        body: Stack(children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(roulette()),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(themeCasino.colorScheme.secondary.withOpacity(0.6), BlendMode.darken),
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: SizedBox(
              height: MediaQuery.of(context).size.height / 2,
              width: MediaQuery.of(context).size.width,
              child: Card(
                margin: const EdgeInsets.all(24),
                elevation: 8,
                shadowColor: themeCasino.primaryColorDark,
                color: widget.isWinner
                    ? Colors.green[200]?.withOpacity(0.9)
                    : Colors.red[200]?.withOpacity(0.9),
                shape: RoundedRectangleBorder(
                  // Ajouter cette ligne
                  borderRadius: BorderRadius.circular(16),
                  side: BorderSide(
                    color: themeCasino.primaryColorDark,
                    width: 2,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: ConfettiWidget(
                        confettiController: _controllerConfetti,
                        blastDirectionality: BlastDirectionality.explosive,
                        shouldLoop: true,
                        blastDirection: pi / 2,
                        emissionFrequency: 0.05,
                        numberOfParticles: 10,
                        gravity: 0.05,
                        colors: const [
                          Colors.cyan,
                          Colors.green,
                          Colors.grey,
                          Colors.orange,
                          Colors.purple
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 24),
                      child: Text(
                        widget.message,
                        style: const TextStyle(fontSize: 24),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Text(
                      'Votre solde est de ${widget.solde}€',
                      style: const TextStyle(fontSize: 24),
                    ),
                    Text(
                      'Le Croupier à tiré le ${widget.croupier}',
                      style: const TextStyle(fontSize: 24),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (widget.solde <= 0) {
                          // naviger vers la page de fin de partie
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const EndGameScreen(),
                            ),
                          );
                        } else {
                          widget.onPlayAgain(widget.solde);
                          Navigator.pop(context);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 32, vertical: 16),
                        textStyle: const TextStyle(fontSize: 20),
                        minimumSize: const Size(120, 50),
                      ),
                      child: const Text('Rejouer'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
