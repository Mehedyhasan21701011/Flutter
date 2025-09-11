import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:japan2/app/modules/home/controllers/home_controller.dart';

class HomeView extends StatelessWidget {
  final HomeController controller = Get.put(HomeController());

  HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Japanese Speaking Practice"),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              Get.defaultDialog(
                title: "Reset Score",
                middleText: "Are you sure you want to reset?",
                textCancel: "Cancel",
                textConfirm: "Reset",
                confirmTextColor: Colors.white,
                onConfirm: () {
                  controller.resetScore();
                  Get.back();
                  Get.snackbar("Reset Complete", "Score and streak reset");
                },
              );
            },
          ),
        ],
      ),
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blueAccent, Colors.lightBlue],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Score section
              Obx(
                () => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildScoreCard("Score", controller.score.value),
                    _buildScoreCard("Streak", controller.streak.value),
                  ],
                ),
              ),
              const SizedBox(height: 30),

              // Word card
              Obx(() => _buildWordCard(controller.targetWord.value)),

              const SizedBox(height: 10),

              // Pronunciation
              Obx(
                () => Text(
                  "Pronunciation: ${controller.wordPronunciationMap[controller.targetWord.value] ?? ''}",
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),

              const SizedBox(height: 30),

              // Recognized text
              Obx(
                () => Text(
                  "You said: ${controller.recognizedText.value}",
                  style: const TextStyle(fontSize: 18, color: Colors.white),
                  textAlign: TextAlign.center,
                ),
              ),

              const SizedBox(height: 30),

              // Mic button
              Obx(
                () => GestureDetector(
                  onTap: () {
                    controller.isListening.value
                        ? controller.stopListening()
                        : controller.startListening();
                  },
                  child: CircleAvatar(
                    radius: 40,
                    backgroundColor: controller.isListening.value
                        ? Colors.red
                        : Colors.green,
                    child: Icon(
                      controller.isListening.value ? Icons.mic : Icons.mic_none,
                      color: Colors.white,
                      size: 40,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Navigation buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: controller.previousWord,
                  ),
                  IconButton(
                    icon: const Icon(Icons.arrow_forward, color: Colors.white),
                    onPressed: controller.nextWord,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildScoreCard(String title, int value) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 6,
            offset: const Offset(2, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            "$value",
            style: const TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWordCard(String word) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.9),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(
        word,
        style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
        textAlign: TextAlign.center,
      ),
    );
  }
}
