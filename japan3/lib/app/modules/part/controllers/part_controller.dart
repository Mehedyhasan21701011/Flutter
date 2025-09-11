import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:japan3/app/data/story.dart';
import '../../home/controllers/home_controller.dart';

class PartController extends GetxController {
  late final StoryPart part;

  // For MCQ
  final selectedIndex = (-1).obs;
  // For translation/free text
  final textController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    part = Get.arguments as StoryPart;
  }

  void submit() {
    if (!part.isTranslation) {
      // MCQ
      if (selectedIndex.value == -1) {
        Get.snackbar(
          'Select an answer',
          'Please choose an option before submitting',
        );
        return;
      }
      final isCorrect = selectedIndex.value == part.correctIndex;
      if (isCorrect) {
        _completeAndCelebrate();
      } else {
        Get.snackbar(
          'Try again',
          'উত্তরটি ঠিক নয়, আরেকবার চেষ্টা করো।',
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } else {
      // Translation
      final answer = textController.text.trim();
      if (answer.isEmpty) {
        Get.snackbar('Write your answer', 'অনুবাদ লিখে জমা দাও');
        return;
      }
      // Simple keyword check (demo). In real apps, evaluate with NLP or teacher.
      final keyword = part.translationKeyword?.toLowerCase() ?? '';
      final ok = keyword.isEmpty || answer.toLowerCase().contains(keyword);
      if (ok) {
        _completeAndCelebrate();
      } else {
        Get.snackbar(
          'Looks close!',
          'কীওয়ার্ড মেলেনি। ইঙ্গিত: ${part.translationKeyword}',
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    }
  }

  void _completeAndCelebrate() {
    Get.find<HomeController>().markCompleted(part);
    Get.dialog(
      AlertDialog(
        title: const Text('Unlocked! 🎉'),
        content: const Text(
          'তুমি এই অংশের চ্যালেঞ্জ সম্পন্ন করেছো। পরের অংশ আনলক হয়েছে!',
        ),
        actions: [
          TextButton(
            onPressed: () {
              Get.back(); // close dialog
              Get.back(); // go back to previous screen
            },
            child: const Text('Continue'),
          ),
        ],
      ),
      barrierDismissible: false,
    );
  }
}
