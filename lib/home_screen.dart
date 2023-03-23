import 'package:flutter/material.dart';
import 'game_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late int solde;
  final TextEditingController soldeController = TextEditingController();

  // créer la logique de vérification utilisateur
  void startGame() {
    if (soldeController.text.isNotEmpty) {
      try {
        solde = int.parse(soldeController.text);
      } catch (e) {
        solde = 0;
        soldeController.clear();
      }
      if (solde > 0) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => GameScreen(solde: solde),
          ),
        );
      } else {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Erreur'),
                content: const Text('Le solde doit être supérieur à 0'),
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
        title: const Text('Casino App'),
      ),
      body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Bienvenue dans le casino',
                style: TextStyle(fontSize: 24),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: soldeController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Entrez votre solde',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: startGame,
                child: const Text('Démarrer Game 🤑'),
              ),
            ],
          )),
    );
  }
}
