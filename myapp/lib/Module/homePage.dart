import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:myapp/Module/class_4/bodycontainhome.dart';
import 'package:myapp/Module/class_4/bodynotification.dart';
import 'package:myapp/Module/class_4/bodysetting.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  int _currentIndex = 0;
  final List<Widget> _pages = [
    const Bodycontainhome(),
    const Bodynotification(),
    const Bodysetting()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu, size: 30),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          ),
        ),
        backgroundColor: Colors.blue.shade300,
        title: const Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: "Shop",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              TextSpan(
                text: "N",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white, // Make "N" red
                ),
              ),
              TextSpan(
                text: "ow",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        actions: const [
          Text("Mehedy Hasan",
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 14)),
          SizedBox(width: 10),
          CircleAvatar(
            backgroundColor: Colors.white30,
            radius: 16,
            child: Icon(
              Icons.account_circle,
              size: 32,
            ),
            // child: CircleAvatar(
            //   backgroundColor: Colors.blue,

            //   // backgroundImage: AssetImage("assets/Images/Cart.png"),
            //   radius: 14,
            // ),
          ),
          SizedBox(width: 10),
        ],
      ),
      drawer: Drawer(
        child: Column(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue.shade300),
              child: Container(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: FittedBox(fit: BoxFit.fill, child: Icon(Icons.account_circle,)),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Mehedy Hasan",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold)),
                          Text("mehedypro21@gmail.com",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 14)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text("Home"),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text("Settings"),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: const Icon(Icons.mode),
              title: const Text("Theme"),
              onTap: () => Navigator.pop(context),
            ),
            Divider(),
            Spacer(),
            Container(
              child: ListTile(
                leading: const Icon(Icons.logout, color: Colors.red),
                title:
                    const Text("Logout", style: TextStyle(color: Colors.red)),
                onTap: () => Navigator.pop(context),
              ),
            ),
          ],
        ),
      ),
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.white,
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        backgroundColor: Colors.blue.shade300,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.home, color: Colors.black), label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(Icons.notifications, color: Colors.black),
              label: "Notifications"),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings, color: Colors.black),
              label: "Settings"),
        ],
      ),
    );
  }
}
