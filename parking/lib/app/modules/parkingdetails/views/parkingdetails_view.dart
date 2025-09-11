import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/parkingdetails_controller.dart';

class ParkingdetailsView extends GetView<ParkingdetailsController> {
  const ParkingdetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Extract the 'name' field from the args map
        title: Text(
          controller.args['name'] ?? "parking details",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'ParkingdetailsView is working for ${controller.args["name"] ?? ""}',
          style: const TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
