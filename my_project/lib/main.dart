import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_project/Module/class%2015-19/controlar.dart';
import 'package:my_project/Module/class%2015-19/themecontroler.dart';
import 'package:my_project/SplashScreen/splashscreen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (context) => Controlar(),
    ),
    ChangeNotifierProvider(create: (context) => Themecontroler()),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeSwitcher = Provider.of<Themecontroler>(context);
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "flutter Demo",
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: themeSwitcher.themeMode,
      home: AnimatedSplashScreen(),
    );
  }
}
