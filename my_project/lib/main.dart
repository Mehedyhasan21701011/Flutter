import 'package:flutter/material.dart';
import 'package:my_project/Module/Routes/secondescreen.dart';
import 'package:my_project/Module/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const HomePageView(),

      //   initialRoute: '/',
      // routes: {
      //   '/': (context) => FirstScreen(),
      //   '/second': (context) => SecondScreen(),
      // },
    );
  }
}
