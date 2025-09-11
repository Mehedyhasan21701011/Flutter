import 'package:get/get.dart';
import 'package:japan3/app/data/story.dart';
import 'package:japan3/app/data/storyRepo.dart';


class HomeController extends GetxController {
  final parts = <StoryPart>[].obs;
  final unlockedIds = <int>{}.obs; // which parts are unlocked
  final completedIds = <int>{}.obs; // which quizzes completed

  @override
  void onInit() {
    super.onInit();
    parts.assignAll(StoryRepository.loadParts());
    // First part is unlocked by default
    unlockedIds.add(0);
  }

  bool isUnlocked(int id) => unlockedIds.contains(id);
  bool isCompleted(int id) => completedIds.contains(id);

  void markCompleted(StoryPart part) {
    completedIds.add(part.id);
    // Unlock the next part if exists
    final nextIndex = part.id + 1;
    if (nextIndex < parts.length) {
      unlockedIds.add(nextIndex);
    }
    update();
  }
}
