import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/location_details_controller.dart';

class LocationDetailsView extends GetView<LocationDetailsController> {
  const LocationDetailsView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(controller.args['name'] ?? "location details"),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'LocationDetailsView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
