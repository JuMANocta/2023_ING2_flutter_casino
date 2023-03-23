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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Casino App - Résultat'),
      ),
      body: SizedBox(
        width: double.infinity,
        //width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
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
                  Colors.green,
                  Colors.blue,
                  Colors.pink,
                  Colors.orange,
                  Colors.purple
                ],
              ),
            ),
            Text(widget.message, style: const TextStyle(fontSize: 24)),
            const SizedBox(height: 16),
            Text(
              'Votre solde est de ${widget.solde}€',
              style: const TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 16),
            Text(
              'Le Croupier à tiré le ${widget.croupier}',
              style: const TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                widget.onPlayAgain(widget.solde);
                Navigator.pop(context);
              },
              child: const Text('Rejouer'),
            ),
          ],
        ),
      ),
    );
  }
}
