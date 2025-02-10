import 'package:flutter/material.dart';

class ExpandedExample extends StatelessWidget {
  const ExpandedExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Expanded Widget Example"),
        backgroundColor: Colors.blueAccent,
      ),
      body: Column(
        children: [
          Container(
            height: 100,
            color: Colors.red,
            child: const Center(
              child: Text(
                "Fixed Height Container",
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: Container(
                  color: Colors.green,
                  child: const Center(
                    child: Text(
                      "Expanded ",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                flex: 3,
                child: Container(
                  color: Colors.black,
                  child: Text("row col 2"),
                ),
              )
            ],
          ),
          Expanded(
            flex: 2, // Takes twice the space of the previous Expanded widget
            child: Container(
              color: Colors.blue,
              child: const Center(
                child: Text(
                  "Expanded with flex: 2",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            ),
          ),
          Container(
            height: 50,
            color: Colors.orange,
            child: const Center(
              child: Text(
                "Fixed Height Footer",
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
