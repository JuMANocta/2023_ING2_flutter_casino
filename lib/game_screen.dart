import 'package:flutter/material.dart';

class GameScreen extends StatefulWidget {
  final int solde;

  const GameScreen({Key? key, required this.solde}) : super(key: key);

  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  late int chiffre;
  late int mise;
  final TextEditingController chiffreController = TextEditingController();
  final TextEditingController miseController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Casino App - Game'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Choisissez votre chiffre et miser',
                style: TextStyle(fontSize: 24)),
            const SizedBox(height: 16),
            TextFormField(
              controller: chiffreController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Entrez un chiffre entre 0 et 49',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: miseController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Entrer votre mise inférieur à votre solde de ${widget.solde}€',
                border: const OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {},
              child: const Text('Valider et lancer le jeu'),
            ),
          ],
        ),
      ),
    );
  }
}
