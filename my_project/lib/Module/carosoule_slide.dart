import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class CarosouleSlide extends StatefulWidget {
  const CarosouleSlide({super.key});

  @override
  State<CarosouleSlide> createState() => _CarosouleSlideState();
}

class _CarosouleSlideState extends State<CarosouleSlide> {
  int currentIndex = 0;
  final List<Map<String, String>> images = [
    {
      'image':
          'https://plus.unsplash.com/premium_photo-1752091700147-1a58190cb857?w=600&auto=format&fit=crop&q=60',
      'title': 'No. 1 image'
    },
    {
      'image':
          'https://images.unsplash.com/photo-1754295083128-7f9c69c0a4d3?w=600&auto=format&fit=crop&q=60',
      'title': 'No. 2 image'
    },
    {
      'image':
          'https://images.unsplash.com/photo-1749739725667-f5cc294eb41e?w=600&auto=format&fit=crop&q=60',
      'title': 'No. 3 image'
    },
    {
      'image':
          'https://images.unsplash.com/photo-1753808446192-dcb2083936e2?w=600&auto=format&fit=crop&q=60',
      'title': 'No. 4 image'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Vertical sliding carousel demo"),
      ),
      body: Column(
        children: [
          CarouselSlider(
            options: CarouselOptions(
              height: 200,
              viewportFraction: 0.8,
              enlargeCenterPage: true,
              scrollDirection:
                  Axis.horizontal, // change to Axis.vertical if needed
              autoPlay: true,
              onPageChanged: (index, reason) {
                setState(() {
                  currentIndex = index;
                });
              },
            ),
            items: images.map((item) {
              return Builder(
                builder: (BuildContext context) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        Image.network(
                          item['image']!,
                          fit: BoxFit.cover,
                        ),
                        Positioned(
                          bottom: 10,
                          left: 10,
                          child: Text(
                            item['title']!,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              shadows: [
                                Shadow(
                                  color: Colors.black54,
                                  blurRadius: 4,
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            }).toList(),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: images.asMap().entries.map((entry) {
              return GestureDetector(
                onTap: () {},
                child: Container(
                  width: 8.0,
                  height: 8.0,
                  margin: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 4.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: currentIndex == entry.key
                        ? Colors.grey.shade800
                        : Colors.grey.shade400,
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
