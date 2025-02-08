import 'package:flutter/material.dart';

class CycleAvater extends StatelessWidget {
  const CycleAvater({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cycle Avater'),
      ),
      body: const Center(
        child: CircleAvatar(
          radius: 80,
          backgroundColor: Colors.blue,
          child: Padding(
            padding: EdgeInsets.all(5.0),
            child: CircleAvatar(
              radius: 78,
              backgroundImage: AssetImage('assets/images/shoe_1.png'),
            ),
          ),
        ),
      ),
    );
  }
}
