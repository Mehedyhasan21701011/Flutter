import 'package:flutter/material.dart';

class SpacerGuide extends StatelessWidget {
  const SpacerGuide({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Spacer"),
      ),
      body: Center(
        child: Container(
          height: 300,
          decoration: BoxDecoration(color: Colors.amber.shade100),
          child: Column(
            children: [
              ListTile(
                title: Text("Mehedy"),
                subtitle: Text("Student"),
                trailing: Icon(Icons.star),
              ),
              ListTile(
                title: Text("Mehedy"),
                subtitle: Text("Student"),
                trailing: Icon(Icons.star),
              ),
              Divider(),
              Spacer(),
              GestureDetector(
                child: InkWell(
                  splashColor: Colors.grey.withOpacity(0.5),
                  onTap: () {},
                  child: ListTile(
                    title: Text("LogOut"),
                    leading: Icon(Icons.logout_sharp),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
