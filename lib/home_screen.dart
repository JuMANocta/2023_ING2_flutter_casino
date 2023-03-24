import 'dart:math';

import 'package:flutter/material.dart';
import 'game_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

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

  String porte() {
    //creer un tableau de porte
    List<String> porte = [
      'assets/images/porte1.jpg',
      'assets/images/porte2.jpg',
      'assets/images/porte3.jpg',
      'assets/images/porte4.jpg'
    ];
    //choisir un index au hasard
    int index = Random().nextInt(porte.length);
    return porte[index];
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false, // Empêche la navigation en arrière
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Casino App'),
          centerTitle: true,
          leading: const SizedBox.shrink(),
        ),
        body: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(porte()),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: SizedBox(
                height: MediaQuery.of(context).size.height / 3,
                child: Card(
                  margin: const EdgeInsets.all(24),
                  elevation: 8,
                  // shadowColor: Colors.green[900],
                  color: Colors.green[200]?.withOpacity(0.9),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Bienvenue dans le casino',
                        style: TextStyle(
                            fontSize: 24,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 16),
                      Container(
                        margin: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color:
                              Colors.white.withOpacity(0.6), // Couleur opaque
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: TextFormField(
                          //maxLength: 3,
                          textAlign: TextAlign.center,
                          controller: soldeController,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            labelText: 'Entrez votre solde',
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: startGame,
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 32, vertical: 16),
                          textStyle: const TextStyle(fontSize: 20),
                          minimumSize: const Size(120, 50),
                        ),
                        child: const Text('Démarrer Game 🤑'),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
