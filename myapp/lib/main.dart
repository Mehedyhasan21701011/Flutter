import 'package:flutter/material.dart';
import 'package:myapp/Module/class15_19/themecontroler.dart';
import 'package:myapp/Module/homePage.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(ChangeNotifierProvider(
      create: (context) => Themecontroler(), child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<Themecontroler>(
      builder: (context, themeController, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData.light(),
          darkTheme: ThemeData.dark(),
          themeMode: themeController.thememode, // Apply theme mode
          home: const Homepage(),
        );
      },
    );
  }
}
