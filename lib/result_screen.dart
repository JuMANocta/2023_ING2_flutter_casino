import 'package:flutter/material.dart';

class ResultScreen extends StatefulWidget {
  final int solde;
  final int chiffre;
  final int mise;
  final bool isWinner;

  const ResultScreen(
      {Key? key,
      required this.solde,
      required this.chiffre,
      required this.mise,
      required this.isWinner})
      : super(key: key);

  @override
  _ResultScreenState createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Casino App - Résultat'),
      ),
      body: Container(
        width: double.infinity,
        //width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(widget.isWinner ? 'Félicitation !' : 'Dommage ...'),
            const SizedBox(height: 16),
            Text(
              'Votre solde est de ${widget.solde}€',
              style: const TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Rejouer'),
            ),
          ],
        ),
      ),
    );
  }
}
