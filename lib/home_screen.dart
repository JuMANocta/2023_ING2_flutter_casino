import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late int solde;
  final TextEditingController soldeController = TextEditingController();

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
              onPressed: () {
                setState(() {
                  solde = int.parse(soldeController.text);
                });
              },
              child: const Text('Valider'),
            ),
          ],
        )
      ),
    );
  }
}
