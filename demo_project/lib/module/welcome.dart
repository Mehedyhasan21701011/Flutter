import 'package:demo_project/module/signin.dart';
import 'package:demo_project/module/signup.dart';
import 'package:flutter/material.dart';

class Welcome extends StatefulWidget {
  const Welcome({super.key});

  @override
  _WelcomeState createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  bool isSignInSelected = true; // Track which button is selected

  void _navigateToNextScreen() {
    if (isSignInSelected) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const Signin()),
      );
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const Signup()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber.shade100,
      body: Column(
        children: [
          const Expanded(
            flex: 8,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Welcome Back!",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 24,
                        color: Colors.blue,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "Please enter your email address to continue.",
                    style: TextStyle(fontSize: 18),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      side: BorderSide(style: BorderStyle.none),
                      backgroundColor:
                          isSignInSelected ? Colors.white : Colors.transparent,
                      foregroundColor:
                          isSignInSelected ? Colors.blue : Colors.black,
                      shape: const RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.only(topRight: Radius.circular(50)),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 30),
                    ),
                    onPressed: () {
                      setState(() {
                        isSignInSelected = true;
                      });
                      Future.delayed(const Duration(milliseconds: 200),
                          _navigateToNextScreen);
                    },
                    child: const Text("Sign in"),
                  ),
                ),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      side: BorderSide(style: BorderStyle.none),
                      backgroundColor:
                          !isSignInSelected ? Colors.white : Colors.transparent,
                      foregroundColor:
                          !isSignInSelected ? Colors.blue : Colors.black,
                      shape: const RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.only(topLeft: Radius.circular(50)),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 30),
                    ),
                    onPressed: () {
                      setState(() {
                        isSignInSelected = false;
                      });
                      Future.delayed(const Duration(milliseconds: 200),
                          _navigateToNextScreen);
                    },
                    child: const Text("Sign up"),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
