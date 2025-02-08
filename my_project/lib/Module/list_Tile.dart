import 'package:flutter/material.dart';

class ListTileGuideline extends StatelessWidget {
  const ListTileGuideline({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("List Tile"),
      ),
      body: Center(
        child: SizedBox(
          width: 300,
          height: 75,
          child: ListTile(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10), // Added rounded corners
              side: const BorderSide(color: Colors.blue, width: 2), // Border
            ),
            leading: const Icon(Icons.person, color: Colors.blue),
            title: const Text("Mehedy Hasan"),
            subtitle: const Text("University of Chittagong"),
            trailing: const Icon(Icons.edit, color: Colors.black),
            tileColor: const Color.fromARGB(255, 137, 197, 246),
            onTap: () {
              print("List Tile");
            },
          ),
        ),
      ),
    );
  }
}
