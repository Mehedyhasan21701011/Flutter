import 'package:flutter/material.dart';

class Arrayexample extends StatelessWidget {
  const Arrayexample({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> list = ["Mehedy", "Jalal", "Numan"];
    return Scaffold(
      appBar: AppBar(
        title: Text("Array Example"),
      ),
      body: ListView.builder(
          itemCount: 3,
          itemBuilder: (context, index) {
            return Card(
              child: ListTile(
                title: Center(child: Text(list[index])),
                onTap: () {},
              ),
            );
          }),
    );
  }
}
