import 'dart:ui';
import 'package:get/get.dart';
import 'dart:math';

class HomeController extends GetxController {
  final correctOrder = ["私は", "日本に", "行きます"].obs;

  // Current shuffled list
  final shuffled = <String>[].obs;

  final placed = <String>[].obs; // user placed words

  @override
  void onInit() {
    super.onInit();
    shuffleWords();
  }

  void shuffleWords() {
    shuffled.assignAll(correctOrder);
    shuffled.shuffle(Random());
    placed.clear();
  }

  bool get isCorrect =>
      placed.length == correctOrder.length &&
      List.generate(
        correctOrder.length,
        (i) => placed[i] == correctOrder[i],
      ).every((e) => e);

  void placeWord(String word) {
    placed.add(word);
    shuffled.remove(word);
    update();
  }

  void removeWord(String word) {
    shuffled.add(word);
    placed.remove(word);
    update();
  }

  void checkAnswer() {
    if (isCorrect) {
      Get.snackbar(
        'Correct! 🎉',
        'Well done! You arranged the sentence correctly.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Color.fromARGB(255, 0, 128, 0), // dark green
      );
      shuffleWords(); // Optional: reshuffle for next round
    } else {
      Get.snackbar(
        'Incorrect ❌',
        'Try again. Check the word order.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Color.fromARGB(255, 255, 0, 0), // pure red
      );
    }
  }
}
