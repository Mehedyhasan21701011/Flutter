import 'package:flutter/material.dart';

class Navbar extends StatefulWidget {
  const Navbar({super.key});

  @override
  State<Navbar> createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  String _selectedText = "Home"; // Default text

  void _updateText(String newText) {
    setState(() {
      _selectedText = newText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Nav Bar"),
      ),
      body: Column(
        children: [
          Container(
            height: 60,
            decoration: const BoxDecoration(color: Colors.blue, boxShadow: [
              BoxShadow(color: Colors.grey, blurRadius: 4, offset: Offset(2, 2))
            ]),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                  icon: const Icon(
                    Icons.home,
                    size: 40,
                    color: Colors.white,
                  ),
                  onPressed: () => _updateText("Home"),
                ),
                IconButton(
                  icon: const Icon(
                    Icons.search,
                    size: 40,
                    color: Colors.white,
                  ),
                  onPressed: () => _updateText("Search"),
                ),
                IconButton(
                  icon:
                      const Icon(Icons.settings, size: 40, color: Colors.white),
                  onPressed: () => _updateText("Settings"),
                ),
              ],
            ),
          ),
          Expanded(
            child: Center(
              child: Text(
                _selectedText,
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
