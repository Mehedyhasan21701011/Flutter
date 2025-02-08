import 'package:flutter/material.dart';

class aboutPage extends StatelessWidget {
  const aboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("ABOUT"),
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                    color: Colors.blueAccent,
                    borderRadius: BorderRadius.circular(10)),
                width: 200,
                height: 200,
                child: const Center(child: Text("About")),
              ),
              const SizedBox(
                width: 10,
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(10),
                ),
                height: 200,
                width: 200,
                child: const Center(child: Text("Container")),
              )
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          const Column(
            children: [
              Text(
                "This is a simple",
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(
                height: 10,
              ),
              Icon(Icons.access_alarm_sharp),
              Icon(Icons.access_alarm_sharp),
              Icon(
                Icons.access_alarm_sharp,
                color: Colors.yellow,
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Icon(Icons.access_alarm_sharp),
              Icon(
                Icons.access_alarm_sharp,
                color: Colors.blue,
                size: 50,
              ),
              Icon(Icons.access_alarm_sharp),
            ],
          ),
        ],
      ),
    );
  }
}
