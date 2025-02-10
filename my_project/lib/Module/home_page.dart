import 'package:flutter/material.dart';
import 'package:my_project/Module/about_page.dart';
import 'package:my_project/Module/appbar.dart';
import 'package:my_project/Module/button_view.dart';
import 'package:my_project/Module/card_view.dart';
import 'package:my_project/Module/cycle_avater.dart';
import 'package:my_project/Module/expanded.dart';
import 'package:my_project/Module/fitbox.dart';
import 'package:my_project/Module/gride_View_count.dart';
import 'package:my_project/Module/gride_view.dart';
import 'package:my_project/Module/list_Tile.dart';
import 'package:my_project/Module/bottomNavigation.dart';
import 'package:my_project/Module/navbar.dart';

class HomePageView extends StatelessWidget {
  const HomePageView({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> page = [
      {'title': 'Home', 'pageName': const HomePageView()},
      {'title': 'About', 'pageName': const aboutPage()},
      {'title': "Card", 'pageName': const CardView()},
      {'title': "Cycle Avater", 'pageName': const CycleAvater()},
      {'title': "List Tile", 'pageName': const ListTileGuideline()},
      {'title': "Button Guideline", 'pageName': const ButtonView()},
      {'title': "Gride view", 'pageName': const GrideView()},
      {'title': "Gride view Count", 'pageName': const GridViewCountPage()},
      {'title': "Expanded", 'pageName': const ExpandedExample()},
      {'title': "Fitbox", 'pageName': const Fitbox()},
      {'title': "Appbars", 'pageName': const AppbarView()},
      {'title': "Bottomnavigation", 'pageName': const Bottomnavigation()},
      {'title': "NavBar", 'pageName': const Navbar()},
    ];
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            "My App",
            style: TextStyle(
                color: Colors.blueAccent,
                fontWeight: FontWeight.bold,
                fontSize: 30),
          ),
        ),
      ),
      body: ListView.builder(
          itemCount: page.length,
          itemBuilder: (context, index) {
            return Container(
              padding: const EdgeInsets.all(16.0),
              margin: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Colors.grey[200],
                  boxShadow: [
                    BoxShadow(
                        blurRadius: 4, color: Colors.grey, offset: Offset(2, 2))
                  ]),
              child: ListTile(
                leading: const Icon(
                  Icons.widgets,
                  color: Colors.green,
                ),
                title: Text(
                  page[index]['title'],
                  style: const TextStyle(
                      fontSize: 24, fontWeight: FontWeight.bold),
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => page[index]['pageName']));
                },
              ),
            );
          }),
    );
  }
}
