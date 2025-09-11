import 'package:get/get.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class HomeController extends GetxController {
  final stt.SpeechToText speech = stt.SpeechToText();

  var isListening = false.obs;
  var recognizedText = "".obs;
  var targetWord = "食べる".obs; // Example target word
  var score = 0.obs;
  var streak = 0.obs;

  final Map<String, String> wordPronunciationMap = {
    "食べる": "taberu",
    "飲む": "nomu",
    "行く": "iku",
    "見る": "miru",
    "書く": "kaku",
  };

  late final List<String> wordList = wordPronunciationMap.keys.toList();
  var currentIndex = 0;

  Future<void> startListening() async {
    bool available = await speech.initialize(
      onStatus: (status) {
        if (status == "done" || status == "notListening") {
          isListening.value = false;
        }
      },
      onError: (error) {
        isListening.value = false;
      },
    );

    if (available) {
      isListening.value = true;
      speech.listen(
        localeId: "ja-JP", // Japanese
        onResult: (result) {
          recognizedText.value = result.recognizedWords.trim();

          // ✅ Check exact match with target word
          if (recognizedText.value == targetWord.value) {
            score.value++;
            streak.value++;
            nextWord();
          } else {
            streak.value = 0; // reset streak if wrong
          }
        },
      );
    }
  }

  void stopListening() {
    speech.stop();
    isListening.value = false;
  }

  void nextWord() {
    currentIndex = (currentIndex + 1) % wordList.length;
    targetWord.value = wordList[currentIndex];
    recognizedText.value = "";
  }

  void previousWord() {
    currentIndex = (currentIndex - 1 + wordList.length) % wordList.length;
    targetWord.value = wordList[currentIndex];
    recognizedText.value = "";
  }

  void resetScore() {
    score.value = 0;
    streak.value = 0;
    recognizedText.value = "";
    currentIndex = 0;
    targetWord.value = wordList[currentIndex];
  }
}
