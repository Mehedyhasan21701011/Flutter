import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parking/app/modules/accountpage/views/accountpage_view.dart';
import 'package:parking/app/modules/activitypage/views/activitypage_view.dart';
import 'package:parking/app/modules/homepage/views/homepage_view.dart';
import 'package:parking/app/modules/locationpage/views/locationpage_view.dart';
import '../controllers/home_controller.dart';

class HomeView extends StatelessWidget {
  final MainController mainController = Get.put(MainController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => IndexedStack(
          index: mainController.currentIndex.value,
          children: [
            HomepageView(),
            LocationpageView(),
            ActivitypageView(),
            AccountpageView(),
          ],
        ),
      ),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          currentIndex: mainController.currentIndex.value,
          onTap: mainController.changeTabIndex,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Colors.blue,
          unselectedItemColor: Colors.grey,
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(
              icon: Icon(Icons.location_on),
              label: 'Location',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.calendar_today),
              label: 'Activity',
            ),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Account'),
          ],
        ),
      ),
    );
  }
}
