import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Grammar Detective')),
      body: Obx(() {
        return Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Arrange the words to form a correct Japanese sentence:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),

              // Target zone (placed words)
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: controller.placed
                    .map(
                      (word) => Chip(
                        label: Text(word, style: const TextStyle(fontSize: 18)),
                        deleteIcon: const Icon(Icons.close),
                        onDeleted: () => controller.removeWord(word),
                      ),
                    )
                    .toList(),
              ),

              const Divider(height: 40),

              // Shuffled words to drag/tap
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: controller.shuffled
                    .map(
                      (word) => ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: () => controller.placeWord(word),
                        child: Text(word, style: const TextStyle(fontSize: 18)),
                      ),
                    )
                    .toList(),
              ),

              const SizedBox(height: 30),

              // Submit button
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32,
                      vertical: 12,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: controller.checkAnswer,
                  child: const Text('Submit', style: TextStyle(fontSize: 18)),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
