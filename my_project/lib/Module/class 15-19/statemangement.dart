import 'package:flutter/material.dart';
import 'package:my_project/Module/class%2015-19/themecontroler.dart';
import 'package:provider/provider.dart';

class Statemangement extends StatefulWidget {
  Statemangement({super.key});
  @override
  State<Statemangement> createState() => _StatemangementState();
}

class _StatemangementState extends State<Statemangement> {
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
            // Text("Value:$count",
            //     style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30)),
            Text("$count"),
            ElevatedButton(
              style: ElevatedButton.styleFrom(),
              onPressed: () {
                // Update the state
                setState(() {
                  count++;
                });
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
                // Update the state
                setState(() {
                  count--;
                });
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
