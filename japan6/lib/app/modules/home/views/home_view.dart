import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flip_card/flip_card.dart';
import 'package:japan5/app/modules/home/controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final flipKey = GlobalKey<FlipCardState>();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Flashcards"),
        actions: [
          IconButton(
            onPressed: controller.shuffleCards,
            icon: const Icon(Icons.shuffle),
          ),
        ],
      ),
      body: Center(
        child: Obx(() {
          final card = controller.cards[controller.currentIndex.value];

          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // ✅ Progress text
              Text(
                "Learned: ${controller.learnedCount} / ${controller.cards.length}",
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),

              // ✅ FlipCard with learned tracking
              SizedBox(
                height: 180,
                width: 260,
                child: FlipCard(
                  key: flipKey,
                  direction: FlipDirection.HORIZONTAL,
                  speed: 400,
                  onFlipDone: (yes) {
                    if (yes) {
                      controller.markLearned(); // ব্যাক সাইড দেখলে শিখে গেছে
                    }
                  },
                  front: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.blueGrey,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      card.front,
                      style: const TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  back: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.deepOrange,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      card.back,
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 30),

              // ✅ Navigation Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () {
                      controller.prevCard();
                      flipKey.currentState?.controller
                          ?.reset(); // নতুন কার্ডে গেলে রিসেট
                    },
                    icon: const Icon(Icons.arrow_back, size: 32),
                  ),
                  const SizedBox(width: 40),
                  IconButton(
                    onPressed: () {
                      controller.nextCard();
                      flipKey.currentState?.controller
                          ?.reset(); // নতুন কার্ডে গেলে রিসেট
                    },
                    icon: const Icon(Icons.arrow_forward, size: 32),
                  ),
                ],
              ),
            ],
          );
        }),
      ),
    );
  }
}
