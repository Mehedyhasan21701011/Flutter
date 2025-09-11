import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parking/app/modules/home/controllers/home_controller.dart';
import 'package:parking/app/modules/homepage/controllers/homepage_controller.dart';
import 'package:parking/app/routes/app_pages.dart';

class HomepageView extends StatelessWidget {
  const HomepageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final HomepageController homeController = Get.put(HomepageController());
    final MainController mainController = Get.find<MainController>();

    final size = MediaQuery.of(context).size;
    final isPortrait = size.height > size.width;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.center,
            colors: [Colors.blue.shade400, Colors.blue.shade100],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // 🔹 Header Section
              Container(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.location_on,
                          color: Colors.white,
                          size: isPortrait ? 24 : 20,
                        ),
                        const SizedBox(width: 8),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Your location',
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: isPortrait ? 14 : 12,
                              ),
                            ),
                            Obx(
                              () => Text(
                                mainController.userLocation.value,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: isPortrait ? 16 : 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),

                    // 🔹 Phone Illustration
                    SizedBox(
                      height: isPortrait
                          ? size.height * 0.25
                          : size.height * 0.35,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            width: isPortrait ? 200 : 250,
                            height: isPortrait ? 120 : 150,
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: Colors.white.withOpacity(0.3),
                                width: 2,
                              ),
                            ),
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Parking',
                                    style: TextStyle(
                                      color: Colors.orange,
                                      fontSize: isPortrait ? 24 : 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    'Easy',
                                    style: TextStyle(
                                      color: Colors.orange,
                                      fontSize: isPortrait ? 24 : 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      _buildCarIcon(),
                                      const SizedBox(width: 8),
                                      _buildCarIcon(),
                                      const SizedBox(width: 8),
                                      _buildCarIcon(isHighlighted: true),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Positioned(
                            top: 10,
                            right: 20,
                            child: Icon(
                              Icons.location_on,
                              color: Colors.orange,
                              size: isPortrait ? 30 : 25,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // 🔹 Content Section
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Section Title
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Nearby',
                              style: TextStyle(
                                fontSize: isPortrait ? 24 : 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                            TextButton(
                              onPressed: () => homeController.refreshParking(),
                              child: Text(
                                'See more',
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: isPortrait ? 16 : 14,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),

                        // 🔹 Parking List
                        Expanded(
                          child: Obx(() {
                            if (homeController.isSearching.value) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }

                            if (homeController.nearbyParkingLots.isEmpty) {
                              return Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.local_parking,
                                      size: isPortrait ? 80 : 60,
                                      color: Colors.grey[400],
                                    ),
                                    const SizedBox(height: 20),
                                    Text(
                                      'No parking lots near you',
                                      style: TextStyle(
                                        fontSize: isPortrait ? 20 : 18,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black54,
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    Text(
                                      'Try searching in a different area',
                                      style: TextStyle(
                                        fontSize: isPortrait ? 16 : 14,
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                    const SizedBox(height: 20),
                                    ElevatedButton(
                                      onPressed: () =>
                                          homeController.refreshParking(),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.blue,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            25,
                                          ),
                                        ),
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 30,
                                          vertical: 15,
                                        ),
                                      ),
                                      child: Text(
                                        'Search Again',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: isPortrait ? 16 : 14,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }

                            // ✅ Show list of parking cards
                            return ListView.builder(
                              itemCount:
                                  homeController.nearbyParkingLots.length,
                              itemBuilder: (context, index) {
                                final lot =
                                    homeController.nearbyParkingLots[index];
                                return Card(
                                  margin: const EdgeInsets.symmetric(
                                    vertical: 10,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  elevation: 3,
                                  child: ListTile(
                                    onTap: () {
                                      Get.toNamed(Routes.PARKINGDETAILS,arguments: {
                                        "name" : lot.name,
                                      });
                                    },
                                    leading: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.network(
                                        lot.image,
                                        width: 60,
                                        height: 60,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    title: Text(
                                      lot.name,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    subtitle: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(lot.address),
                                        Text(
                                          "${lot.distance} km • ${lot.availableSpots} spots",
                                        ),
                                      ],
                                    ),
                                    isThreeLine:
                                        false, // Let subtitle handle its own height
                                    trailing: Text(
                                      "৳${lot.pricePerHour}/hr",
                                      style: const TextStyle(
                                        color: Colors.blue,
                                        fontWeight: FontWeight.bold,
                                      ),
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
              ),
            ],
          ),
        ),
      ),
    );
  }

  static Widget _buildCarIcon({bool isHighlighted = false}) {
    return Container(
      width: 30,
      height: 20,
      decoration: BoxDecoration(
        color: isHighlighted ? Colors.orange : Colors.blue,
        borderRadius: BorderRadius.circular(4),
      ),
      child: const Icon(Icons.directions_car, color: Colors.white, size: 16),
    );
  }
}
