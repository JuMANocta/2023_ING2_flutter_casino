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
  late String _porte;

  @override
  void initState() {
    super.initState();
    _porte = porte();
  }

  // créer la logique de vérification utilisateur
  void startGame() {
    if (soldeController.text.isEmpty) {
      showErro();
    }else {
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
        showErro();
      }
    }
  }

  void showErro() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Theme(
            data: ThemeData.dark(),
            child: AlertDialog(
              title: const Text('Erreur'),
              content: const Text('Le solde doit être supérieur à 0'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('OK'),
                ),
              ],
            ),
          );
        });
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
    ThemeData themeCasino = Theme.of(context);
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
                  image: AssetImage(_porte),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                      themeCasino.primaryColor.withOpacity(0.6),
                      BlendMode.darken),
                ),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: SizedBox(
                height: MediaQuery.of(context).size.height / 3,
                child: Card(
                  margin: const EdgeInsets.only(left: 24, right: 24),
                  elevation: 8,
                  shadowColor: themeCasino.primaryColor,
                  color: themeCasino.colorScheme.secondary.withOpacity(0.8),
                  shape: RoundedRectangleBorder(
                    // Ajouter cette ligne
                    borderRadius: BorderRadius.circular(16),
                    side: const BorderSide(
                      color: Colors.black,
                      width: 2,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Text(
                        'Bienvenue dans le casino',
                        style: TextStyle(
                            fontSize: 24,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 75, right: 75),
                        decoration: BoxDecoration(
                          color:
                              Colors.white60.withOpacity(0.6), // Couleur opaque
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: TextFormField(
                          maxLength: 4,
                          textAlign: TextAlign.center,
                          style: themeCasino.textTheme.bodyMedium,
                          controller: soldeController,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                              labelText: 'Entrez votre solde',
                              border: OutlineInputBorder(),
                              counterText: ''),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: startGame,
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 32, vertical: 16),
                          textStyle: themeCasino.textTheme.bodyMedium,
                          // minimumSize: const Size(120, 50),
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
