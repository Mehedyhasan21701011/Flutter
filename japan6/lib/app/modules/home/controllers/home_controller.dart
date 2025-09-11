import 'dart:math';
import 'package:get/get.dart';

class Flashcard {
  final String front;
  final String back;
  RxBool learned = false.obs; // প্রতিটি কার্ড শেখা হয়েছে কিনা track করার জন্য
  Flashcard(this.front, this.back);
}

class HomeController extends GetxController {
  final cards = <Flashcard>[].obs;
  final currentIndex = 0.obs;

  final random = Random();

  @override
  void onInit() {
    super.onInit();
    cards.assignAll([
      Flashcard("猫", "Cat"),
      Flashcard("犬", "Dog"),
      Flashcard("学校", "School"),
      Flashcard("ありがとう", "Thank you"),
      Flashcard("水", "Water"),
    ]);
    shuffleCards();
  }

  /// ✅ শিখে গেছে বলে মার্ক করা
  void markLearned() {
    cards[currentIndex.value].learned.value = true;
  }

  /// ✅ কতগুলো শব্দ শিখলো
  int get learnedCount => cards.where((card) => card.learned.value).length;

  /// ✅ পরের কার্ডে যাওয়া
  void nextCard() {
    if (currentIndex.value < cards.length - 1) {
      currentIndex.value++;
    } else {
      currentIndex.value = 0;
    }
  }

  /// ✅ আগের কার্ডে যাওয়া
  void prevCard() {
    if (currentIndex.value > 0) {
      currentIndex.value--;
    } else {
      currentIndex.value = cards.length - 1;
    }
  }

  /// ✅ শাফল করে শুরুতে নিয়ে আসা
  void shuffleCards() {
    cards.shuffle(random);
    currentIndex.value = 0;
  }
}
