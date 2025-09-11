import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:japan3/app/routes/app_pages.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Story Unlock Quest')),
      body: Obx(() {
        return ListView.separated(
          padding: const EdgeInsets.all(16),
          itemCount: controller.parts.length,
          separatorBuilder: (_, __) => const SizedBox(height: 12),
          itemBuilder: (context, index) {
            final part = controller.parts[index];
            final unlocked = controller.isUnlocked(part.id);
            final done = controller.isCompleted(part.id);

            return Card(
              elevation: 1,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: ListTile(
                leading: CircleAvatar(child: Text('${part.id + 1}')),
                title: Text(part.title),
                subtitle: Text(
                  unlocked
                      ? (done ? 'Completed' : 'Unlocked – tap to continue')
                      : 'Locked – complete the previous part',
                ),
                trailing: Icon(
                  done
                      ? Icons.check_circle
                      : (unlocked ? Icons.lock_open : Icons.lock),
                  color: done
                      ? Colors.green
                      : (unlocked ? Colors.orange : Colors.grey),
                ),
                onTap: unlocked
                    ? () {
                        // ✅ No need to lazyPut if binding is configured in AppPages
                        Get.toNamed(Routes.PART, arguments: part);
                      }
                    : null,
              ),
            );
          },
        );
      }),
    );
  }
}
