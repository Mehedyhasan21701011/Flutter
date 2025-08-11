import 'package:flutter/material.dart';

class ScrollingGuide extends StatefulWidget {
  const ScrollingGuide({super.key});

  @override
  State<ScrollingGuide> createState() => _ScrollingGuideStates();
}

class _ScrollingGuideStates extends State<ScrollingGuide> {
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

  final ScrollController _scrollController = ScrollController();
  bool _showCategories = true;
  double _lastOffset = 0;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_handleScroll);
  }

  void _handleScroll() {
    double offset = _scrollController.offset;

    if (offset > _lastOffset && offset - _lastOffset > 10) {
      // scrolling down
      if (_showCategories) {
        setState(() => _showCategories = false);
      }
    } else if (offset < _lastOffset && _lastOffset - offset > 10) {
      // scrolling up
      if (!_showCategories) {
        setState(() => _showCategories = true);
      }
    }
    _lastOffset = offset;
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Scrolling Guide")),
      body: Column(
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            height: _showCategories ? 100 : 0,
            child: _showCategories
                ? ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: categoryList.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Chip(
                          label: Text(categoryList[index]),
                          padding: const EdgeInsets.all(10),
                        ),
                      );
                    },
                  )
                : null,
          ),
          Expanded(
            child: GridView.builder(
              controller: _scrollController,
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
              },
            ),
          ),
        ],
      ),
    );
  }
}
