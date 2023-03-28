import 'dart:math';
import 'package:casino_2023_ing2_flutter/home_screen.dart';
import 'package:flutter/material.dart';

class EndGameScreen extends StatelessWidget {
  const EndGameScreen({super.key});

  String end() {
    // creer un tableau de roulette
    List<String> roulette = [
      'assets/images/end1.jpg',
      'assets/images/end2.jpg',
      'assets/images/end3.jpg',
      'assets/images/end4.jpg'
    ];
    // choisir un index au hasard
    int index = Random().nextInt(roulette.length);
    return roulette[index];
  }

  @override
  Widget build(BuildContext context) {
    ThemeData themeCasino = Theme.of(context);
    return WillPopScope(
      onWillPop: () async => false, // Empêche la navigation en arrière
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Fin de la partie'),
          centerTitle: true,
          leading: const SizedBox.shrink(),
        ),
        body: Stack(children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(end()),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(themeCasino.colorScheme.secondary.withOpacity(0.6), BlendMode.darken),
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: SizedBox(
              height: MediaQuery.of(context).size.height / 1.8,
              width: MediaQuery.of(context).size.width / 1.2,
              child: Card(
                margin: const EdgeInsets.all(24),
                elevation: 8,
                shadowColor: themeCasino.primaryColorDark,
                // shadowColor: Colors.green[900],
                color: Colors.red[200]?.withOpacity(0.8),
                shape: RoundedRectangleBorder(
                  // Ajouter cette ligne
                  borderRadius: BorderRadius.circular(16),
                  side: BorderSide(
                    color: themeCasino.primaryColorDark,
                    width: 2,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Text(
                      'Fin de la partie',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: themeCasino.primaryColor.withOpacity(0.25),
                            spreadRadius: 8 / 2,
                            blurRadius: 8,
                            offset: const Offset(0, 8 / 2),
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: ConstrainedBox(
                          constraints: BoxConstraints(
                            maxWidth: MediaQuery.of(context).size.width / 2,
                          ),
                          child: Image.asset(
                            'assets/images/gameover.jpg',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    const Text(
                      'Vous avez perdu',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const HomeScreen(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 32, vertical: 16),
                        textStyle: const TextStyle(fontSize: 20),
                        minimumSize: const Size(120, 50),
                      ),
                      child: const Text('Retour au menu'),
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
