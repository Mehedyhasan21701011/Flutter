import 'package:flutter/material.dart';
import 'package:getx_demo/module/countcontrollar.dart';
import 'package:provider/provider.dart';

class Secondpage extends StatelessWidget {
  const Secondpage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Center(child: Text('Second Page')),
      ),
      body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Center(
          child: ElevatedButton(
              onPressed: () {
                Provider.of<Countcontrollar>(context, listen: false)
                    .decrement();
              },
              child: Text("Decrement")),
        ),
        SizedBox(
          height: 10,
        ),
        Center(child: Text('This is the second page')),
      ]),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pop(context);
        },
        child: Icon(Icons.arrow_back),
      ),
    );
  }
}
