import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:async';
import 'dart:math';

class QuizQuestion {
  final String kanji;
  final String correctMeaning;
  final String displayMeaning;
  final bool isCorrect;
  final String reading;

  QuizQuestion({
    required this.kanji,
    required this.correctMeaning,
    required this.displayMeaning,
    required this.isCorrect,
    required this.reading,
  });
}

class HomeController extends GetxController with GetTickerProviderStateMixin {
  // Animation controllers
  late AnimationController _pulseAnimationController;
  late AnimationController _correctAnimationController;
  late AnimationController _wrongAnimationController;
  late AnimationController _timerAnimationController;

  late Animation<double> pulseAnimation;
  late Animation<double> correctAnimation;
  late Animation<double> wrongAnimation;
  late Animation<double> timerAnimation;

  // Timer
  Timer? _questionTimer;

  // Kanji data
  final List<Map<String, String>> kanjiData = [
    {'kanji': '水', 'meaning': 'পানি', 'reading': 'みず'},
    {'kanji': '火', 'meaning': 'আগুন', 'reading': 'ひ'},
    {'kanji': '木', 'meaning': 'গাছ', 'reading': 'き'},
    {'kanji': '土', 'meaning': 'মাটি', 'reading': 'つち'},
    {'kanji': '日', 'meaning': 'সূর্য', 'reading': 'にち'},
    {'kanji': '月', 'meaning': 'চাঁদ', 'reading': 'つき'},
    {'kanji': '山', 'meaning': 'পাহাড়', 'reading': 'やま'},
    {'kanji': '川', 'meaning': 'নদী', 'reading': 'かわ'},
    {'kanji': '人', 'meaning': 'মানুষ', 'reading': 'ひと'},
    {'kanji': '大', 'meaning': 'বড়', 'reading': 'だい'},
  ];

  // Wrong meanings for false questions
  final List<String> wrongMeanings = [
    'বাতাস',
    'বরফ',
    'ঘাস',
    'পাথর',
    'তারা',
    'সমুদ্র',
    'মেঘ',
    'বৃষ্টি',
  ];

  // Game state
  final Rx<QuizQuestion?> currentQuestion = Rx<QuizQuestion?>(null);
  final RxInt score = 0.obs;
  final RxInt streak = 0.obs;
  final RxInt bestStreak = 0.obs;
  final RxInt questionsAnswered = 0.obs;
  final RxInt correctAnswers = 0.obs;
  var timeLeft = 5.obs;
  final RxBool isGameActive = false.obs;
  final RxBool showResult = false.obs;
  final RxBool lastAnswerCorrect = false.obs;
  final RxString gameStatus = ''.obs;
  final RxBool isAnswering = false.obs;
  final RxBool gameCompleted = false.obs;

  final Random _random = Random();

  @override
  void onInit() {
    super.onInit();
    _initializeAnimations();
  }

  void _initializeAnimations() {
    _pulseAnimationController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    _correctAnimationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _wrongAnimationController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _timerAnimationController = AnimationController(
      duration: const Duration(seconds: 5),
      vsync: this,
    );

    pulseAnimation = Tween<double>(begin: 1.0, end: 1.1).animate(
      CurvedAnimation(
        parent: _pulseAnimationController,
        curve: Curves.easeInOut,
      ),
    );

    correctAnimation = Tween<double>(begin: 1.0, end: 1.3).animate(
      CurvedAnimation(
        parent: _correctAnimationController,
        curve: Curves.elasticOut,
      ),
    );

    wrongAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _wrongAnimationController, curve: Curves.easeOut),
    );

    timerAnimation = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(parent: _timerAnimationController, curve: Curves.linear),
    );

    // Start pulse animation loop
    _pulseAnimationController.repeat(reverse: true);
  }

  void startGame() {
    // Reset game state
    score.value = 0;
    streak.value = 0;
    questionsAnswered.value = 0;
    correctAnswers.value = 0;
    isGameActive.value = true;
    showResult.value = false;
    gameStatus.value = '';
    gameCompleted.value = false;

    _generateNewQuestion();
  }

  void _generateNewQuestion() {
    // Check if game should end - after all kanji have been shown
    if ((questionsAnswered.value - correctAnswers.value) > 0) {
      _endGame();
      return;
    }

    if (!isGameActive.value) return;

    isAnswering.value = false;
    showResult.value = false;

    // Select random kanji
    final kanjiItem = kanjiData[_random.nextInt(kanjiData.length)];

    // Decide if this should be a true or false question (50/50 chance)
    final bool shouldBeCorrect = _random.nextBool();

    String displayMeaning;
    if (shouldBeCorrect) {
      displayMeaning = kanjiItem['meaning']!;
    } else {
      // Select a random wrong meaning
      displayMeaning = wrongMeanings[_random.nextInt(wrongMeanings.length)];
      // Make sure it's not accidentally correct
      while (displayMeaning == kanjiItem['meaning']) {
        displayMeaning = wrongMeanings[_random.nextInt(wrongMeanings.length)];
      }
    }

    currentQuestion.value = QuizQuestion(
      kanji: kanjiItem['kanji']!,
      correctMeaning: kanjiItem['meaning']!,
      displayMeaning: displayMeaning,
      isCorrect: shouldBeCorrect,
      reading: kanjiItem['reading']!,
    );

    _startTimer(); // ✅ now calls the wrapper method
  }

  void _endGame() {
    isGameActive.value = false;
    gameCompleted.value = true;
    _questionTimer?.cancel();
    _timerAnimationController.stop();
    showResult.value = false;

    // Show game completion message
    gameStatus.value = 'গেম সম্পন্ন! চূড়ান্ত স্কোর: ${score.value}';
  }

  // ✅ Wrapper: default 5 seconds
  void _startTimer() {
    _startTimerWithTime(5);
  }

  // ✅ Unified timer logic
  void _startTimerWithTime(int time) {
    timeLeft.value = time;
    _timerAnimationController.duration = Duration(seconds: time);
    _timerAnimationController.reset();
    _timerAnimationController.forward();

    _questionTimer?.cancel();
    _questionTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (timeLeft.value > 0) {
        timeLeft.value--;
      } else {
        timer.cancel();
        if (!isAnswering.value) {
          _handleTimeUp();
        }
      }
    });
  }

  void _handleTimeUp() {
    isAnswering.value = true;
    _questionTimer?.cancel();

    // Time up is considered wrong answer
    lastAnswerCorrect.value = false;
    gameStatus.value = 'সময় শেষ!';
    streak.value = 0;
    questionsAnswered.value++;

    _playWrongAnimation();
    showResult.value = true;

    _scheduleNextQuestion();
  }

  var answerState = "".obs;
  void answerQuestion(bool userAnswer) {
    if (isAnswering.value || !isGameActive.value) return;

    isAnswering.value = true;
    _questionTimer?.cancel();
    _timerAnimationController.stop();

    final question = currentQuestion.value!;
    final isCorrect = userAnswer == question.isCorrect;

    questionsAnswered.value++;
    lastAnswerCorrect.value = isCorrect;

    // 🔹 Update button state for UI coloring
    answerState.value = isCorrect ? "correct" : "wrong";

    if (isCorrect) {
      correctAnswers.value++;
      streak.value++;

      // Update best streak
      if (streak.value > bestStreak.value) {
        bestStreak.value = streak.value;
      }

      // Calculate score with streak bonus
      int basePoints = 10;
      int bonusPoints = _calculateStreakBonus();
      score.value += basePoints + bonusPoints;

      gameStatus.value = bonusPoints > 0
          ? 'সঠিক! +${basePoints + bonusPoints} (+$bonusPoints বোনাস)'
          : 'সঠিক! +$basePoints';

      _playCorrectAnimation();
    } else {
      streak.value = 0;
      gameStatus.value = 'ভুল! সঠিক অর্থ: ${question.correctMeaning}';
      _playWrongAnimation();
    }

    showResult.value = true;

    // 🔹 Reset button state when moving to next question
    Future.delayed(const Duration(seconds: 1), () {
      answerState.value = "";
      _scheduleNextQuestion();
      isAnswering.value = false;
    });
  }

  int _calculateStreakBonus() {
    if (streak.value >= 10) return 50;
    if (streak.value >= 5) return 15;
    if (streak.value >= 2) return 5;
    return 0;
  }

  void _playCorrectAnimation() {
    _correctAnimationController.forward().then((_) {
      _correctAnimationController.reverse();
    });
  }

  void _playWrongAnimation() {
    _wrongAnimationController.forward().then((_) {
      _wrongAnimationController.reverse();
    });
  }

  void _scheduleNextQuestion() {
    Timer(const Duration(milliseconds: 2500), () {
      if (isGameActive.value) {
        _generateNewQuestion();
      }
    });
  }

  void pauseGame() {
    isGameActive.value = false;
    _questionTimer?.cancel();
    _timerAnimationController.stop();
  }

  void resumeGame() {
    if (currentQuestion.value != null && !isAnswering.value) {
      isGameActive.value = true;
      _startTimerWithTime(timeLeft.value); // ✅ fixed typo
    }
  }

  void stopGame() {
    isGameActive.value = false;
    gameCompleted.value = false;
    _questionTimer?.cancel();
    _timerAnimationController.stop();
    showResult.value = false;
    currentQuestion.value = null;
  }

  // Getters for statistics
  double get accuracy {
    if (questionsAnswered.value == 0) return 0.0;
    return (correctAnswers.value / questionsAnswered.value) * 100;
  }

  String get accuracyText => '${accuracy.toStringAsFixed(1)}%';

  @override
  void onClose() {
    _questionTimer?.cancel();
    _pulseAnimationController.dispose();
    _correctAnimationController.dispose();
    _wrongAnimationController.dispose();
    _timerAnimationController.dispose();
    super.onClose();
  }
}
