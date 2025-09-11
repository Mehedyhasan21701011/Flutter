import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parking/app/modules/locationpage/controllers/locationpage_controller.dart';
import 'package:parking/app/routes/app_pages.dart';

class LocationpageView extends StatelessWidget {
  const LocationpageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final LocationController locationController = Get.put(LocationController());

    final size = MediaQuery.of(context).size;
    final isPortrait = size.height > size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Locations'),
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
                'Select Location',
                style: TextStyle(
                  fontSize: isPortrait ? 24 : 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: Obx(() {
                  if (locationController.availableLocations.isEmpty) {
                    return Center(
                      child: Text(
                        "No locations available",
                        style: TextStyle(
                          fontSize: isPortrait ? 18 : 16,
                          color: Colors.grey,
                        ),
                      ),
                    );
                  }

                  return ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: locationController.availableLocations.length,
                    itemBuilder: (context, index) {
                      final location =
                          locationController.availableLocations[index];
                      return Card(
                        margin: const EdgeInsets.only(bottom: 12),
                        child: ListTile(
                          leading: Icon(
                            Icons.location_on,
                            color: Colors.blue,
                            size: isPortrait ? 24 : 20,
                          ),
                          title: Text(
                            location,
                            style: TextStyle(fontSize: isPortrait ? 16 : 14),
                          ),
                          trailing: const Icon(Icons.arrow_forward_ios),
                          onTap: () {
                            locationController.selectLocation(location);
                            Get.snackbar(
                              'Location Selected',
                              'You selected $location',
                              backgroundColor: Colors.green,
                              colorText: Colors.white,
                              snackPosition: SnackPosition.BOTTOM,
                              margin: const EdgeInsets.all(12),
                              duration: const Duration(seconds: 2),
                            );
                            Get.toNamed(
                              Routes.LOCATION_DETAILS,
                              arguments: {"name": location},
                            );
                          },
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
