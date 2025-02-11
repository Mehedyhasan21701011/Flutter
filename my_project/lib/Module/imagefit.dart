import 'package:flutter/material.dart';

class Imagefit extends StatelessWidget {
  const Imagefit({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.network(
            'https://picsum.photos/200',
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
