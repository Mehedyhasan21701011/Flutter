import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:japan5/app/modules/home/controllers/home_controller.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeController());

    return Scaffold(
      backgroundColor: const Color(0xFF1A1A2E),
      appBar: AppBar(
        title: const Text(
          'কাঞ্জি পপ কুইজ',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: const Color(0xFF16213E),
        elevation: 0,
        actions: [
          Obx(
            () => controller.isGameActive.value
                ? IconButton(
                    onPressed: controller.pauseGame,
                    icon: const Icon(Icons.pause, color: Colors.white),
                  )
                : IconButton(
                    onPressed: controller.resumeGame,
                    icon: const Icon(Icons.ads_click, color: Colors.white),
                  ),
          ),
        ],
      ),
      body: Obx(() {
        if (controller.gameCompleted.value) {
          return _buildGameOverScreen(controller);
        } else if (!controller.isGameActive.value &&
            controller.currentQuestion.value == null) {
          return SingleChildScrollView(child: _buildStartScreen(controller));
        } else {
          return _buildGameScreen(controller);
        }
      }),
    );
  }

  // ----------------- START SCREEN -----------------
  Widget _buildStartScreen(HomeController controller) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.quiz, size: 100, color: Color(0xFF4ECDC4)),
          const SizedBox(height: 40),
          const Text(
            'কাঞ্জি পপ কুইজ',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'সত্য/মিথ্যা দ্রুততম উত্তর',
            style: TextStyle(fontSize: 18, color: Colors.white70),
          ),
          const SizedBox(height: 40),
          ElevatedButton(
            onPressed: controller.startGame,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF4ECDC4),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            child: const Text(
              'গেম শুরু করুন',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  // ----------------- GAME OVER SCREEN -----------------
  Widget _buildGameOverScreen(HomeController controller) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.emoji_events, size: 100, color: Color(0xFF4ECDC4)),
            const SizedBox(height: 20),
            const Text(
              '🎉 গেম শেষ!',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 20),

            // Final Score
            Obx(
              () => Text(
                'আপনার স্কোর: ${controller.score.value}',
                style: const TextStyle(fontSize: 22, color: Colors.white70),
              ),
            ),
            const SizedBox(height: 10),
            const SizedBox(height: 40),

            // Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton.icon(
                  onPressed: controller.startGame,
                  icon: const Icon(Icons.replay),
                  label: const Text("আবার খেলুন"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF4ECDC4),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 14,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                ElevatedButton.icon(
                  onPressed: controller.stopGame,
                  icon: const Icon(Icons.home),
                  label: const Text("হোম"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 14,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // ----------------- GAME SCREEN -----------------
  Widget _buildGameScreen(HomeController controller) {
    return SafeArea(
      child: Column(
        children: [
          _buildStatsBar(controller),
          _buildTimer(controller),
          Expanded(child: _buildQuestionArea(controller)),
          _buildAnswerButtons(controller),
          const SizedBox(height: 8),
        ],
      ),
    );
  }

  // ----------------- UI Helpers -----------------
  Widget _buildStatsBar(HomeController controller) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: Color(0xFF16213E),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildStatItem('স্কোর', '${controller.score.value}'),
          _buildStatItem('স্ট্রিক', '${controller.streak.value}'),
          _buildStatItem('প্রশ্ন', '${controller.questionsAnswered.value}'),
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color(0xFF4ECDC4),
          ),
        ),
        Text(
          label,
          style: const TextStyle(fontSize: 12, color: Colors.white70),
        ),
      ],
    );
  }

  Widget _buildTimer(HomeController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Row(
        children: [
          Expanded(
            child: AnimatedBuilder(
              animation: controller.timerAnimation,
              builder: (context, child) {
                return LinearProgressIndicator(
                  value: controller.timerAnimation.value,
                  backgroundColor: Colors.white24,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    controller.timeLeft.value <= 2
                        ? Colors.red
                        : const Color(0xFF4ECDC4),
                  ),
                  minHeight: 6,
                );
              },
            ),
          ),
          const SizedBox(width: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: controller.timeLeft.value <= 2
                  ? Colors.red
                  : const Color(0xFF4ECDC4),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              '${controller.timeLeft.value}s',
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuestionArea(HomeController controller) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Kanji with pulse animation
          AnimatedBuilder(
            animation: controller.pulseAnimation,
            builder: (context, child) {
              return Transform.scale(
                scale: controller.pulseAnimation.value,
                child: Text(
                  controller.currentQuestion.value?.kanji ?? '',
                  style: const TextStyle(
                    fontSize: 80,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 20),

          // Meaning
          Text(
            controller.currentQuestion.value?.displayMeaning ?? '',
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 20),

          // Status message
          if (controller.showResult.value)
            Text(
              controller.gameStatus.value,
              style: TextStyle(
                fontSize: 18,
                color: controller.lastAnswerCorrect.value
                    ? Colors.greenAccent
                    : Colors.redAccent,
                fontWeight: FontWeight.bold,
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildAnswerButtons(HomeController controller) {
    return Obx(() {
      Color wrongBg;
      Color correctBg;
      Color wrongFg;
      Color correctFg;

      // 🔹 Neutral state
      if (controller.answerState.value == "") {
        wrongBg = Colors.white;
        correctBg = Colors.white;
        wrongFg = Colors.black;
        correctFg = Colors.black;
      }
      // 🔹 Wrong answer chosen
      else if (controller.answerState.value == "wrong") {
        wrongBg = Colors.red;
        wrongFg = Colors.white;
        correctBg = Colors.white;
        correctFg = Colors.black;
      }
      // 🔹 Correct answer chosen
      else {
        wrongBg = Colors.white;
        wrongFg = Colors.black;
        correctBg = Colors.green;
        correctFg = Colors.white;
      }

      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
        child: Row(
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: controller.isAnswering.value
                    ? null
                    : () => controller.answerQuestion(false),
                style: ElevatedButton.styleFrom(
                  backgroundColor: wrongBg,
                  foregroundColor: wrongFg,
                  disabledBackgroundColor: wrongBg.withOpacity(0.6),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 14,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: const Text(
                  "❌ ভুল",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: ElevatedButton(
                onPressed: controller.isAnswering.value
                    ? null
                    : () => controller.answerQuestion(true),
                style: ElevatedButton.styleFrom(
                  backgroundColor: correctBg,
                  foregroundColor: correctFg,
                  disabledBackgroundColor: correctBg.withOpacity(0.6),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 14,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: const Text(
                  "✅ সঠিক",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
