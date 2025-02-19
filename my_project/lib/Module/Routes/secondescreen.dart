import 'package:flutter/material.dart';

class SecondScreen extends StatelessWidget {
  final String data;

  const SecondScreen({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    // final String data = ModalRoute.of(context)!.settings.arguments as String;

    return Scaffold(
      appBar: AppBar(title: Text("Second Screen")),
      body: Center(
        child: Text(data, style: TextStyle(fontSize: 20)),
      ),
    );
  }
}
