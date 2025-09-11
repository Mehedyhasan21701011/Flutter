// Add this to your pubspec.yaml dependencies:
// just_audio: ^0.9.36
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';

/// Question model
class Question {
  final String questionText;
  final String audioFile;
  final List<String> options;
  final int correctIndex;

  Question({
    required this.questionText,
    required this.audioFile,
    required this.options,
    required this.correctIndex,
  });
}

class HomeController extends GetxController {
  /// Example questions with local audio files
  final questions = <Question>[
    Question(
      questionText: "What does this Japanese word mean?",
      audioFile: "file_1.mp3",
      options: ["Meal", "Goodbye", "Thank you", "Yes"],
      correctIndex: 0,
    ),
    Question(
      questionText: "What is the meaning of this phrase?",
      audioFile: "file_2.mp3",
      options: ["Water", "Food", "House", "Car"],
      correctIndex: 1,
    ),
  ].obs;

  /// States
  var currentQuestionIndex = 0.obs;
  var selectedAnswerIndex = (-1).obs;
  var correctAnswerIndex = (-1).obs;
  var isAnswerRevealed = false.obs;
  var score = 0.obs;

  /// Audio
  final AudioPlayer _audioPlayer = AudioPlayer();
  var isPlaying = false.obs;

  @override
  void onInit() {
    super.onInit();
    // Listen to player state changes
    _audioPlayer.playerStateStream.listen((state) {
      isPlaying.value = state.playing;

      // Optional: Handle completion
      if (state.processingState == ProcessingState.completed) {
        isPlaying.value = false;
      }
    });
  }

  /// Play / Stop audio
  Future<void> playAudio() async {
    try {
      if (_audioPlayer.playing) {
        await _audioPlayer.stop();
      } else {
        final audioFile = questions[currentQuestionIndex.value].audioFile;
        print("Playing audio file: assets/$audioFile"); // Debug log
        await _audioPlayer.setAsset('assets/$audioFile');
        await _audioPlayer.play();
      }
    } catch (e) {
      print("Error playing audio: $e");
      Get.snackbar("Audio Error", "Could not play audio file");
      isPlaying.value = false;
    }
  }

  /// Select an answer
  void selectAnswer(int index) {
    if (!isAnswerRevealed.value) {
      selectedAnswerIndex.value = index;
    }
  }

  /// Submit answer
  void submitAnswer() {
    if (selectedAnswerIndex.value == -1) {
      Get.snackbar("No Selection", "Please select an answer");
      return;
    }

    final question = questions[currentQuestionIndex.value];
    correctAnswerIndex.value = question.correctIndex;
    isAnswerRevealed.value = true;

    if (selectedAnswerIndex.value == correctAnswerIndex.value) {
      score.value++;
    }

    /// Move to next question after delay
    Future.delayed(const Duration(seconds: 2), () {
      nextQuestion();
    });
  }

  /// Go to next question
  void nextQuestion() {
    if (currentQuestionIndex.value < questions.length - 1) {
      currentQuestionIndex.value++;
    } else {
      Get.snackbar(
        "Game Over",
        "Final Score: ${score.value}/${questions.length}",
      );
      // Optional: Reset game
      resetGame();
      return;
    }

    selectedAnswerIndex.value = -1;
    correctAnswerIndex.value = -1;
    isAnswerRevealed.value = false;

    // Stop any playing audio when moving to next question
    if (_audioPlayer.playing) {
      _audioPlayer.stop();
    }
  }

  /// Reset game (optional)
  void resetGame() {
    currentQuestionIndex.value = 0;
    selectedAnswerIndex.value = -1;
    correctAnswerIndex.value = -1;
    isAnswerRevealed.value = false;
    score.value = 0;
    if (_audioPlayer.playing) {
      _audioPlayer.stop();
    }
  }

  /// Helper: return option text
  String getDisplayText(String text) {
    return text;
  }

  @override
  void onClose() {
    _audioPlayer.dispose();
    super.onClose();
  }
}
