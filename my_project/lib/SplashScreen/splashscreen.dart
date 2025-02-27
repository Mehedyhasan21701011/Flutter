import 'package:flutter/material.dart';
import 'package:my_project/Module/home_page.dart';

class AnimatedSplashScreen extends StatefulWidget {
  const AnimatedSplashScreen({super.key});

  @override
  _AnimatedSplashScreenState createState() => _AnimatedSplashScreenState();
}


class _AnimatedSplashScreenState extends State<AnimatedSplashScreen> {
  @override
  void initState() {
    super.initState();

    // Delay for 3 seconds before navigating
    Future.delayed(Duration(seconds: 3), () {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomePageView()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Image.asset(
          'assets/animation/splash_1.gif',
          width: double.infinity,
          height: double.infinity,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
