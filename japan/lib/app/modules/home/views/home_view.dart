import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:japan/app/modules/home/controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text(
          'Audio Quiz',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blue[600],
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      body: Obx(() {
        final question =
            controller.questions[controller.currentQuestionIndex.value];
        final progress =
            (controller.currentQuestionIndex.value + 1) /
            controller.questions.length;

        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Progress indicator
              Container(
                margin: const EdgeInsets.only(bottom: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Question ${controller.currentQuestionIndex.value + 1} of ${controller.questions.length}',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey[700],
                          ),
                        ),
                        Text(
                          'Score: ${controller.score.value}',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue[600],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    LinearProgressIndicator(
                      value: progress,
                      backgroundColor: Colors.grey[300],
                      valueColor: AlwaysStoppedAnimation<Color>(
                        Colors.blue[600]!,
                      ),
                      minHeight: 6,
                    ),
                  ],
                ),
              ),

              // Question card
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      // Question text
                      Text(
                        question.questionText,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                        textAlign: TextAlign.center,
                      ),

                      const SizedBox(height: 20),

                      // Audio player button
                      Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: controller.isPlaying.value
                              ? Colors.red[400]
                              : Colors.blue[600],
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              blurRadius: 8,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: IconButton(
                          onPressed: controller.playAudio,
                          icon: Icon(
                            controller.isPlaying.value
                                ? Icons.stop
                                : Icons.play_arrow,
                            size: 40,
                            color: Colors.white,
                          ),
                        ),
                      ),

                      const SizedBox(height: 10),

                      Text(
                        controller.isPlaying.value
                            ? 'Playing...'
                            : 'Tap to play audio',
                        style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Answer options
              Expanded(
                child: ListView.builder(
                  itemCount: question.options.length,
                  itemBuilder: (context, index) {
                    final isSelected =
                        controller.selectedAnswerIndex.value == index;
                    final isCorrect =
                        controller.correctAnswerIndex.value == index;
                    final isWrong =
                        controller.isAnswerRevealed.value &&
                        controller.selectedAnswerIndex.value == index &&
                        !isCorrect;

                    Color getBackgroundColor() {
                      if (!controller.isAnswerRevealed.value) {
                        return isSelected ? Colors.blue[100]! : Colors.white;
                      } else {
                        if (isCorrect) return Colors.green[100]!;
                        if (isWrong) return Colors.red[100]!;
                        return Colors.grey[50]!;
                      }
                    }

                    Color getBorderColor() {
                      if (!controller.isAnswerRevealed.value) {
                        return isSelected
                            ? Colors.blue[600]!
                            : Colors.grey[300]!;
                      } else {
                        if (isCorrect) return Colors.green[600]!;
                        if (isWrong) return Colors.red[600]!;
                        return Colors.grey[300]!;
                      }
                    }

                    return Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () => controller.selectAnswer(index),
                          borderRadius: BorderRadius.circular(12),
                          child: Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: getBackgroundColor(),
                              border: Border.all(
                                color: getBorderColor(),
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              children: [
                                // Option letter
                                Container(
                                  width: 32,
                                  height: 32,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: getBorderColor(),
                                  ),
                                  child: Center(
                                    child: Text(
                                      String.fromCharCode(
                                        65 + index,
                                      ), // A, B, C, D
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                ),

                                const SizedBox(width: 16),

                                // Option text
                                Expanded(
                                  child: Text(
                                    controller.getDisplayText(
                                      question.options[index],
                                    ),
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black87,
                                    ),
                                  ),
                                ),

                                // Result icon
                                if (controller.isAnswerRevealed.value)
                                  Icon(
                                    isCorrect
                                        ? Icons.check_circle
                                        : (isWrong ? Icons.cancel : null),
                                    color: isCorrect
                                        ? Colors.green[600]
                                        : Colors.red[600],
                                    size: 24,
                                  ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),

              // Submit button
              if (!controller.isAnswerRevealed.value)
                Container(
                  margin: const EdgeInsets.only(top: 20),
                  child: ElevatedButton(
                    onPressed: controller.selectedAnswerIndex.value != -1
                        ? controller.submitAnswer
                        : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue[600],
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 2,
                    ),
                    child: Text(
                      'Submit Answer',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

              // Next question indicator
              if (controller.isAnswerRevealed.value)
                Container(
                  margin: const EdgeInsets.only(top: 20),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color:
                        controller.selectedAnswerIndex.value ==
                            controller.correctAnswerIndex.value
                        ? Colors.green[50]
                        : Colors.red[50],
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color:
                          controller.selectedAnswerIndex.value ==
                              controller.correctAnswerIndex.value
                          ? Colors.green[300]!
                          : Colors.red[300]!,
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        controller.selectedAnswerIndex.value ==
                                controller.correctAnswerIndex.value
                            ? Icons.check_circle
                            : Icons.cancel,
                        color:
                            controller.selectedAnswerIndex.value ==
                                controller.correctAnswerIndex.value
                            ? Colors.green[600]
                            : Colors.red[600],
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          controller.selectedAnswerIndex.value ==
                                  controller.correctAnswerIndex.value
                              ? 'Correct! Moving to next question...'
                              : 'Incorrect. The correct answer was "${question.options[controller.correctAnswerIndex.value]}"',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color:
                                controller.selectedAnswerIndex.value ==
                                    controller.correctAnswerIndex.value
                                ? Colors.green[700]
                                : Colors.red[700],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        );
      }),
    );
  }
}
