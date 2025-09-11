import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_demo/module/countcontrollar.dart';
import 'package:getx_demo/module/secondpage.dart';
import 'package:getx_demo/notepad/notePad.dart';
import 'package:provider/provider.dart';

class Myhomepage extends StatelessWidget {
  const Myhomepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.blue.shade300,
        title: const Text(
          "First Page",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Consumer<Countcontrollar>(builder: (context, Countcontrollar, child) {
          return Text(
            'Counter: ${Countcontrollar.count}',
            style: const TextStyle(color: Colors.black),
          );
        }),
        const SizedBox(
          height: 10,
        ),
        ElevatedButton(
            onPressed: () {
              Provider.of<Countcontrollar>(context, listen: false).increment();
            },
            child: const Text("Add")),
        const SizedBox(
          height: 10,
        ),
        Center(
          child: ElevatedButton(
              onPressed: () {
                Get.to(const Secondpage());
              },
              child: const Text("Getx Route")),
        ),
        const SizedBox(
          height: 10,
        ),
        Center(
          child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => const Secondpage()));
              },
              child: const Text("Navigator Route")),
        ),
        const SizedBox(
          height: 10,
        ),
        Center(
            child: ElevatedButton(
                onPressed: () {
                  Get.to(const Notepad());
                },
                child: const Text("Note")))
      ]),
    );
  }
}
