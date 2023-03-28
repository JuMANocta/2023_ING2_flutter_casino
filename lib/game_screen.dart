import 'dart:math';
import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';
import 'result_screen.dart';
import 'game_logic.dart';

class GameScreen extends StatefulWidget {
  int solde;

  GameScreen({Key? key, required this.solde}) : super(key: key);

  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  late int chiffre;
  late int mise;
  final TextEditingController chiffreController = TextEditingController();
  final TextEditingController miseController = TextEditingController();
  int _currentChiffre = 0;
  int _currentMise = 1;
  late String _indoorImage;

  @override
  void initState() {
    super.initState();
    _indoorImage = indoor();
  }

  void valideStartGame() {
    String message = '';
    chiffre = _currentChiffre;
    mise = _currentMise;
    // if (chiffreController.text.isNotEmpty && miseController.text.isNotEmpty) {
    //   try {
    //     chiffre = int.parse(chiffreController.text);
    //     if (chiffre < 0 && chiffre > 49) {
    //       message = 'Le chiffre doit être compris entre 0 et 49';
    //       chiffre = 0;
    //       chiffreController.clear();
    //     }
    //   } catch (e) {
    //     message = 'Le chiffre doit être compris entre 0 et 49';
    //     chiffre = 0;
    //     chiffreController.clear();
    //   }
    //   try {
    //     mise = int.parse(miseController.text);
    //     if (mise < 0 && mise > widget.solde) {
    //       message = 'La mise doit être supérieur à 0';
    //       mise = 0;
    //       miseController.clear();
    //     }
    //   } catch (e) {
    //     message =
    //         'La mise doit être inférieur à votre solde de ${widget.solde}€';
    //     mise = 0;
    //     miseController.clear();
    //   }

    if (chiffre >= 0 && chiffre <= 49 && mise > 0 && mise <= widget.solde) {
      GameLogic gameLogic =
          GameLogic(solde: widget.solde, chiffre: chiffre, mise: mise);
      gameLogic.play();
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ResultScreen(
              solde: gameLogic.solde,
              chiffre: gameLogic.chiffre,
              mise: gameLogic.mise,
              isWinner: gameLogic.isWinner,
              croupier: gameLogic.croupier,
              message: gameLogic.message,
              onPlayAgain: (int newSolde) {
                setState(() {
                  widget.solde = newSolde;
                  chiffreController.clear();
                  miseController.clear();
                });
              }),
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
    // }
  }

  String indoor() {
    List<String> indoor = [
      'assets/images/indoor1.jpg',
      'assets/images/indoor2.jpg',
      'assets/images/indoor3.jpg'
    ];
    int index = Random().nextInt(indoor.length);
    return indoor[index];
  }

  @override
  Widget build(BuildContext context) {
    ThemeData themeCasino = Theme.of(context);
    return WillPopScope(
      onWillPop: () async => false, // Empêche la navigation en arrière
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Casino App - Game'),
          centerTitle: true,
          leading: const SizedBox.shrink(),
        ),
        body: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(_indoorImage),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                      themeCasino.colorScheme.secondary.withOpacity(0.6),
                      BlendMode.darken),
                ),
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Card(
                margin: const EdgeInsets.only(
                    top: 24, left: 24, right: 24, bottom: 8),
                elevation: 8,
                shadowColor: themeCasino
                    .primaryColorDark, // Utiliser la couleur du thème
                color: themeCasino.cardColor.withOpacity(0.9),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    'Votre solde est de ${widget.solde}€',
                    textAlign:
                        TextAlign.center, // Centrer le texte dans le Card
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: themeCasino.colorScheme.secondary,
                    ),
                  ),
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
                  shadowColor: themeCasino.primaryColor,
                  color: themeCasino.colorScheme.secondary.withOpacity(0.9),
                  shape: RoundedRectangleBorder(
                    // Ajouter cette ligne
                    borderRadius: BorderRadius.circular(16),
                    side: const BorderSide(
                      color: Colors.black,
                      width: 2,
                    ),
                  ),
                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const Text('Choisissez ...',
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold)),
                      // const SizedBox(height: 16),
                      // Container(
                      //   margin: const EdgeInsets.all(16),
                      //   decoration: BoxDecoration(
                      //     color: Colors.white.withOpacity(0.6),
                      //     borderRadius: BorderRadius.circular(8),
                      //   ),
                      //   child: TextFormField(
                      //     controller: chiffreController,
                      //     keyboardType: TextInputType.number,
                      //     decoration: const InputDecoration(
                      //       labelText: 'Entrez un chiffre entre 0 et 49',
                      //       border: OutlineInputBorder(),
                      //     ),
                      //   ),
                      // ),
                      Text('Votre Chiffre : $_currentChiffre',
                          style: const TextStyle(fontSize: 20)),
                      // const SizedBox(height: 8),
                      NumberPicker(
                        textStyle: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color:
                              Colors.black, // Changer la couleur du texte
                          fontStyle: FontStyle.italic,
                        ),
                        infiniteLoop: true,
                        selectedTextStyle: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                        minValue: 0,
                        maxValue: 49,
                        value: _currentChiffre,
                        axis: Axis.horizontal,
                        onChanged: (value) =>
                            setState(() => _currentChiffre = value),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: Colors.black26),
                        ),
                      ),
                      // const SizedBox(height: 16),
                      Text('Votre mise : $_currentMise',
                          style: const TextStyle(fontSize: 20)),
                      // const SizedBox(height: 8),
                      NumberPicker(
                        textStyle: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color:
                              Colors.black, // Changer la couleur du texte
                          fontStyle: FontStyle.italic,
                        ),
                        infiniteLoop: true,
                        selectedTextStyle: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                        minValue: 1,
                        maxValue: widget.solde,
                        value: _currentMise,
                        axis: Axis.horizontal,
                        onChanged: (value) => setState(
                            () => _currentMise = min(value, widget.solde)),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: Colors.black26),
                        ),
                      ),
                      // Container(
                      //   margin: const EdgeInsets.all(16),
                      //   decoration: BoxDecoration(
                      //     color: Colors.white.withOpacity(0.6),
                      //     borderRadius: BorderRadius.circular(8),
                      //   ),
                      //   child: TextFormField(
                      //     controller: miseController,
                      //     keyboardType: TextInputType.number,
                      //     decoration: InputDecoration(
                      //       labelText:
                      //           'Entrer votre mise inférieur à votre solde de ${widget.solde}€',
                      //       border: const OutlineInputBorder(),
                      //     ),
                      //   ),
                      // ),
                      // const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: valideStartGame,
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 32, vertical: 16),
                          textStyle: const TextStyle(fontSize: 20),
                          minimumSize: const Size(120, 50),
                        ),
                        child: const Text('Valider et lancer le jeu'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
