import 'package:flutter/material.dart';

class TabControl extends StatelessWidget {
  const TabControl({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Center(child: Text("Welcome")),
      ),
      body: DefaultTabController(
          length: 3,
          child: Column(
            children: [
              TabBar(tabs: [
                Tab(
                  icon: Icon(Icons.home),
                  text: "home",
                ),
                Tab(
                  icon: Icon(Icons.search),
                  text: "search",
                ),
                Tab(
                  icon: Icon(Icons.settings),
                  text: "settings",
                ),
              ]),
              Expanded(
                  child: TabBarView(children: [
                Center(
                  child: Text("Home page"),
                ),
                Center(
                  child: Text("Searching page"),
                ),
                Center(
                  child: Text("Setting page"),
                ),
              ]))
            ],
          )),
    );
  }
}
