import 'package:flutter/material.dart';

class Containersetcontainer extends StatelessWidget {
  const Containersetcontainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 300,
        height: 300,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), color: Colors.blue),
        child: Row(
          children: [
            Expanded(
                flex: 3,
                child: Center(
                  child: Text(
                    "Containerset",
                    style: TextStyle(fontSize: 14),
                  ),
                )),
            Expanded(
                flex: 2,
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(10),
                          bottomRight: Radius.circular(10))),
                ))
          ],
        ),
      ),
    );
  }
}
