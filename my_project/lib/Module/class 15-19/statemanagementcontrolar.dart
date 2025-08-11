import 'package:flutter/material.dart';
import 'package:my_project/Module/class%2015-19/controlar.dart';
import 'package:my_project/Module/class%2015-19/themecontroler.dart';
import 'package:provider/provider.dart';

class Statemanagementcontrolar extends StatefulWidget {
  const Statemanagementcontrolar({super.key});

  @override
  State<Statemanagementcontrolar> createState() =>
      _StatemanagementcontrolarState();
}

class _StatemanagementcontrolarState extends State<Statemanagementcontrolar> {
  int count = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 112, 164, 206),
      appBar: AppBar(
        title: Text('State Management'),
        actions: [
          IconButton(
            icon: Icon(Icons.brightness_2),
            onPressed: () {
              Provider.of<Themecontroler>(context, listen: false)
                  .toggleThemeMode();
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Consumer<Controlar>(
              builder: (context, Controlar, child) =>
                  Text("${Controlar.Count}"),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(),
              onPressed: () {
                // Update the state
                Provider.of<Controlar>(context, listen: false).increment();
              },
              child: Icon(
                Icons.add_circle,
                size: 30,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(),
              onPressed: () {
                Provider.of<Controlar>(context, listen: false).decrement();
              },
              child: Icon(
                Icons.remove_circle,
                size: 30,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
