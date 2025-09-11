import 'dart:async';
import 'dart:math' as math;
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class HomeController extends GetxController {
  // টার্গেট রোমাজি যেটা দেখাবে
  var targetRomaji = ''.obs;

  // ফেলার অক্ষরের লিস্ট
  var fallingKana = <Map<String, dynamic>>[].obs;

  // পয়েন্ট এবং লাইফ
  var score = 0.obs;
  var lives = 3.obs;

  // Level system
  var currentLevel = 1.obs;
  var correctAnswers = 0.obs;

  // টাইমার
  Timer? gameLoop;
  Timer? spawnTimer;

  final kanaMap = {
    "a": "あ",
    "i": "い",
    "u": "う",
    "e": "え",
    "o": "お",
    "ka": "か",
    "ki": "き",
    "ku": "く",
    "ke": "け",
    "ko": "こ",
  };

  final random = math.Random();
  List<String> shuffledRomaji = [];

  @override
  void onInit() {
    super.onInit();
    shuffleRomaji();
    startGame();
  }

  void shuffleRomaji() {
    shuffledRomaji = kanaMap.keys.toList();
    shuffledRomaji.shuffle(random);
  }

  void startGame() {
    score.value = 0;
    lives.value = 3;
    currentLevel.value = 1;
    correctAnswers.value = 0;
    fallingKana.clear();
    startLevel();
  }

  void startLevel() {
    // Reset falling kana
    fallingKana.clear();

    // Start new target
    newTarget();

    // Game speed increases with level (kana moves faster)
    int moveSpeed = math.max(100, 300 - (currentLevel.value * 20));

    // Spawn speed also increases (more frequent spawning)
    int spawnSpeed = math.max(800, 2000 - (currentLevel.value * 100));

    // Movement timer
    gameLoop?.cancel();
    gameLoop = Timer.periodic(Duration(milliseconds: moveSpeed), (_) {
      moveKana();
    });

    // Spawn timer
    spawnTimer?.cancel();
    spawnTimer = Timer.periodic(Duration(milliseconds: spawnSpeed), (_) {
      spawnKana();
    });
  }

  void newTarget() {
    // Reshuffle if we've used all kana
    if (shuffledRomaji.isEmpty) {
      shuffleRomaji();
    }
    targetRomaji.value = shuffledRomaji.removeAt(0);
  }

  void spawnKana() {
    var allRomaji = kanaMap.keys.toList();
    allRomaji.shuffle(random);
    var romaji = allRomaji[0];

    // Random horizontal position
    double randomX = random.nextDouble() * 250;

    fallingKana.add({
      "kana": kanaMap[romaji],
      "romaji": romaji,
      "y": 100.0,
      "x": 75 + randomX,
      "id": DateTime.now().millisecondsSinceEpoch + random.nextInt(1000),
    });
  }

  void moveKana() {
    double fallSpeed = 10.0 + (currentLevel.value * 1.5);

    for (var item in fallingKana) {
      item["y"] += fallSpeed;
    }

    fallingKana.removeWhere((item) {
      if (item["y"] > 600) {
        // যদি টার্গেট মিস হয় → লাইফ কমবে
        if (item["romaji"] == targetRomaji.value) {
          lives.value--;
          showMissedTargetMessage();
          if (lives.value <= 0) {
            endGame();
            return true;
          }
          newTarget();
        }
        return true;
      }
      return false;
    });

    fallingKana.refresh();
  }

  void tapKana(Map<String, dynamic> kana) {
    if (kana["romaji"] == targetRomaji.value) {
      // ✅ Correct answer → Level complete
      gameLoop?.cancel();
      spawnTimer?.cancel();

      fallingKana.clear();

      score.value += 10 * currentLevel.value;
      correctAnswers.value++;

      showSuccessMessage();

      // Show level complete after short delay
      Future.delayed(const Duration(milliseconds: 800), () {
        showLevelCompleteDialog();
      });
    } else {
      // ❌ Wrong answer → lose life
      lives.value--;
      showWrongMessage();
      if (lives.value <= 0) {
        endGame();
        return;
      }
    }

    // Remove tapped kana
    fallingKana.remove(kana);
    fallingKana.refresh();
  }

  void showSuccessMessage() {
    Get.snackbar(
      "🎉 Correct!",
      "+${10 * currentLevel.value} points! Level Complete!",
      backgroundColor: Colors.green,
      colorText: Colors.white,
      duration: const Duration(milliseconds: 800),
      snackPosition: SnackPosition.TOP,
      margin: const EdgeInsets.all(10),
      borderRadius: 10,
    );
  }

  void showWrongMessage() {
    Get.snackbar(
      "❌ Wrong!",
      "That was not '${targetRomaji.value}'. Try again!",
      backgroundColor: Colors.red,
      colorText: Colors.white,
      duration: const Duration(seconds: 1),
      snackPosition: SnackPosition.TOP,
      margin: const EdgeInsets.all(10),
      borderRadius: 10,
    );
  }

  void showMissedTargetMessage() {
    Get.snackbar(
      "💔 Missed!",
      "You missed the target '${targetRomaji.value}'!",
      backgroundColor: Colors.orange,
      colorText: Colors.white,
      duration: const Duration(milliseconds: 800),
      snackPosition: SnackPosition.TOP,
      margin: const EdgeInsets.all(10),
      borderRadius: 10,
    );
  }

  void showLevelCompleteDialog() {
    Get.dialog(
      AlertDialog(
        title: const Text("🎊 Level Complete!"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Level ${currentLevel.value} Completed!",
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              "You found the correct kana!",
              style: const TextStyle(fontSize: 16),
            ),
            Text(
              "Score: ${score.value}",
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              "Ready for the next level?",
              style: TextStyle(fontSize: 14, color: Colors.blue),
            ),
          ],
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              Get.back(); // Close dialog
              levelUp();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              foregroundColor: Colors.white,
            ),
            child: const Text("Next Level"),
          ),
        ],
      ),
      barrierDismissible: false,
    );
  }

  void levelUp() {
    currentLevel.value++;
    correctAnswers.value = 0;

    shuffleRomaji();
    startLevel();
  }

  void endGame() {
    gameLoop?.cancel();
    spawnTimer?.cancel();

    Get.dialog(
      AlertDialog(
        title: const Text("💀 Game Over"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Final Score: ${score.value}",
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              "Level Reached: ${currentLevel.value}",
              style: const TextStyle(fontSize: 16),
            ),
            Text(
              "Total Correct Answers: ${correctAnswers.value}",
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              Get.back(); // Close dialog
              startGame(); // Restart
            },
            child: const Text("Play Again"),
          ),
        ],
      ),
      barrierDismissible: false,
    );
  }

  @override
  void onClose() {
    gameLoop?.cancel();
    spawnTimer?.cancel();
    super.onClose();
  }
}
