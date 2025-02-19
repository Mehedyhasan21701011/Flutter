import 'package:flutter/material.dart';
import 'package:my_project/Module/Routes/secondescreen.dart';

class FirstScreen extends StatelessWidget {
  const FirstScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("First Screen")),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    SecondScreen(data: "I am from first Screen"),
              ),
            );
          },
          child: Text("Send"),
        ),
        // child: ElevatedButton(
        //   onPressed: () {
        //     Navigator.pushNamed(
        //       context,
        //       '/second',
        //       arguments: 'Hello from First Screen', // Passing Data
        //     );
        //   },
        //   child: Text("Go to Second Screen"),
        // ),
      ),
    );
  }
}
