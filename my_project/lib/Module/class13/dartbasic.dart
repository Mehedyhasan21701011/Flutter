import 'package:flutter/material.dart';

class Dartbasic extends StatelessWidget {
  const Dartbasic({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dart Basic"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
                onPressed: () {
                  // mPrint();
                  mVariables();
                  mList();
                  nMap();
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.blue,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Execute",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ))
          ],
        ),
      ),
    );
  }

  void mPrint() {
    print("I am print function");
  }

  void mVariables() {
    // final name = "Mehedy";
    // final name = "hasan";
    // const String name = "Mehedy";
    // const String name = "Hasan";
    // differences between final and const ,final is without datatypes on the other hand const is with datatypes
    // we cann't change final or const variable value

    int? a;
    a = 10;
    print(a == null ? "This is null" : "Ok");

    DateTime date1 = DateTime.now();
    print(date1);
    final DateTime date = DateTime.now();
    print(date);

    String num1 = '12345';

    print(num.parse(num1));
  }

  void mList() {
    List<String> list = ["a", "b", "c", "d", "e"];
    print(list);
    for (int i = 0; i < list.length; i++) {
      print(list[i] == "a" ? "Ok" : "NOt Ok");
    }
    for (var element in list) {
      if (element == "a") {
        print("ok");
      } else {
        print("Not Ok");
      }
    }
  }

  void nMap() {
    Map<String, dynamic> map = {
      "name": "Mehedy",
      "age": 25,
      "city": "Dhaka",
    };
  }
}
