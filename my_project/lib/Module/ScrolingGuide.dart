import 'package:flutter/material.dart';

class Scrolingguide extends StatelessWidget {
  Scrolingguide({super.key});
  final List<String> categoryList = [
    "Mehedy",
    "Hasan",
    "John",
    "Doe",
    "Alice",
    "Bob",
    "Emma",
    "Chris"
  ];

  final List<Map<String, String>> productList = [
    {"name": "Laptop", "image": "https://via.placeholder.com/100"},
    {"name": "Phone", "image": "https://via.placeholder.com/100"},
    {"name": "Shoes", "image": "https://via.placeholder.com/100"},
    {"name": "Watch", "image": "https://via.placeholder.com/100"},
    {"name": "Bag", "image": "https://via.placeholder.com/100"},
    {"name": "Headphones", "image": "https://via.placeholder.com/100"},
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Scroling Guide"),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 100,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: productList.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Chip(
                      label: Text(categoryList[index]),
                      padding: const EdgeInsets.all(10),
                    ),
                  );
                }),
          ),
          Expanded(
            child: GridView.builder(
                padding: const EdgeInsets.all(10),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // Two items per row
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 0.8,
                ),
                itemCount: productList.length,
                itemBuilder: (context, index) {
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 3,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.network(productList[index]["image"]!, height: 80),
                        const SizedBox(height: 10),
                        Text(
                          productList[index]["name"]!,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  );
                }),
          )
        ],
      ),
    );
  }
}
