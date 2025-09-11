import 'package:get/get.dart';
import 'package:parking/app/data/model/activity_model.dart';

class ActivityPageController extends GetxController {
  var recentActivities = <ActivityItem>[
    ActivityItem(
      title: 'Parking at GEC Circle',
      subtitle: '2 hours ago',
      amount: '৳50',
      status: 'Completed',
    ),
    ActivityItem(
      title: 'Parking at Agrabad',
      subtitle: '1 day ago',
      amount: '৳75',
      status: 'Completed',
    ),
    ActivityItem(
      title: 'Parking at New Market',
      subtitle: '3 days ago',
      amount: '৳40',
      status: 'Completed',
    ),
  ].obs;
}
