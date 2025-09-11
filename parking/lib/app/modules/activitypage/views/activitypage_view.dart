import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parking/app/modules/activitypage/controllers/activitypage_controller.dart';

class ActivitypageView extends StatelessWidget {
  const ActivitypageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // ✅ Put controller inside build (hot reload safe)
    final ActivityPageController activityController = Get.put(
      ActivityPageController(),
    );

    final size = MediaQuery.of(context).size;
    final isPortrait = size.height > size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Activity'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Recent Activities',
                style: TextStyle(
                  fontSize: isPortrait ? 24 : 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: Obx(() {
                  if (activityController.recentActivities.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.history,
                            size: isPortrait ? 80 : 60,
                            color: Colors.grey[400],
                          ),
                          const SizedBox(height: 12),
                          Text(
                            "No recent activities found",
                            style: TextStyle(
                              fontSize: isPortrait ? 18 : 16,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    );
                  }

                  return ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: activityController.recentActivities.length,
                    itemBuilder: (context, index) {
                      final activity =
                          activityController.recentActivities[index];
                      return Card(
                        margin: const EdgeInsets.only(bottom: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 2,
                        child: ListTile(
                          leading: CircleAvatar(
                            radius: 22,
                            backgroundColor: Colors.blue.shade100,
                            child: Icon(
                              Icons.local_parking,
                              color: Colors.blue,
                              size: isPortrait ? 24 : 20,
                            ),
                          ),
                          title: Text(
                            activity.title,
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: isPortrait ? 16 : 14,
                            ),
                          ),
                          subtitle: Text(
                            activity.subtitle,
                            style: TextStyle(
                              fontSize: isPortrait ? 14 : 12,
                              color: Colors.grey[700],
                            ),
                          ),
                          trailing: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                activity.amount,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: activity.amount.startsWith('-')
                                      ? Colors.red
                                      : Colors.green,
                                  fontSize: isPortrait ? 16 : 14,
                                ),
                              ),
                              Text(
                                activity.status,
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontSize: isPortrait ? 12 : 10,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
