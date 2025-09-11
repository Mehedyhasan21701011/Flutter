import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:japan7/app/modules/home/controllers/home_controller.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeController());

    return Scaffold(
      backgroundColor: Colors.blueGrey.shade900,
      body: SafeArea(
        child: Stack(
          children: [
            // 🎯 Target romaji
            Align(
              alignment: Alignment.topCenter,
              child: Obx(
                () => Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Target: ${controller.targetRomaji.value}",
                        style: const TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 8),
                    ],
                  ),
                ),
              ),
            ),

            // 🏆 Score, ❤️ Lives & Level
            Align(
              alignment: Alignment.topRight,
              child: Obx(
                () => Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Level: ${controller.currentLevel.value}",
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.yellow,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "Score: ${controller.score.value}",
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        "❤️ ${controller.lives.value}",
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        "✅ ${controller.correctAnswers.value}",
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.green,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // ⬇️ Falling Kana
            Obx(
              () => Center(
                child: Stack(
                  alignment: AlignmentGeometry.directional(300, 300),
                  children: controller.fallingKana.map((kana) {
                    return Positioned(
                      top: kana["y"],
                      left: kana["x"], // Now uses random X position
                      child: GestureDetector(
                        onTap: () => controller.tapKana(kana),
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.orange, // All kana look the same
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black26,
                                blurRadius: 4,
                                offset: const Offset(2, 2),
                              ),
                            ],
                          ),
                          child: Text(
                            kana["kana"],
                            style: const TextStyle(
                              fontSize: 32,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
