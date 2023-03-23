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

  void valideStartGame() {
    String message = '';
    if (chiffreController.text.isNotEmpty && miseController.text.isNotEmpty) {
      try {
        chiffre = int.parse(chiffreController.text);
        if (chiffre < 0 || chiffre > 49) {
          message = 'Le chiffre doit être compris entre 0 et 49';
          chiffre = 0;
          chiffreController.clear();
        }
      } catch (e) {
        message = 'Le chiffre doit être compris entre 0 et 49';
        chiffre = 0;
        chiffreController.clear();
      }
      try {
        mise = int.parse(miseController.text);
        if (mise < 0) {
          message = 'La mise doit être supérieur à 0';
          mise = 0;
          miseController.clear();
        }
      } catch (e) {
        message = 'La mise doit être inférieur à votre solde de ${widget.solde}€';
        mise = 0;
        miseController.clear();
      }

      if (chiffre >= 0 && chiffre <= 49 && mise > 0 && mise <= widget.solde) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => GameScreen(solde: widget.solde),
          ),
        );
      } else {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Erreur'),
                content: Text(message),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('OK'),
                  ),
                ],
              );
            });
      }
    }
  }

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
                labelText:
                    'Entrer votre mise inférieur à votre solde de ${widget.solde}€',
                border: const OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: valideStartGame,
              child: const Text('Valider et lancer le jeu'),
            ),
            const SizedBox(height: 24),
            Text(
              'Votre solde est de ${widget.solde}€',
              style: const TextStyle(fontSize: 24),
            )
          ],
        ),
      ),
    );
  }
}
