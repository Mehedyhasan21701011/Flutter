import 'package:get/get.dart';
import 'package:parking/app/data/model/parking_model.dart';

class HomepageController extends GetxController {
  var nearbyParkingLots = <ParkingLot>[].obs;
  var isSearching = false.obs;

  final List<Map<String, dynamic>> parkingLots = [
    {
      "name": "GEC Circle Parking",
      "address": "GEC Circle, Chattogram",
      "distance": 1.2,
      "availableSpots": 25,
      "pricePerHour": 40.0,
      "image": "https://images.unsplash.com/photo-1502877338535-766e1452684a",
    },
    {
      "name": "Chittagong Railway Station Parking",
      "address": "Station Road, Chattogram",
      "distance": 2.5,
      "availableSpots": 40,
      "pricePerHour": 30.0,
      "image":
          "https://images.unsplash.com/photo-1545179605-1296651e9d43?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MzJ8fGNhciUyMHBhcmtpbmd8ZW58MHx8MHx8fDA%3D",
    },
    {
      "name": "Agrabad Commercial Parking",
      "address": "Agrabad, Chattogram",
      "distance": 3.0,
      "availableSpots": 60,
      "pricePerHour": 50.0,
      "image":
          "https://images.unsplash.com/photo-1611845129459-b85618b4f6e4?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MjB8fGNhciUyMHBhcmtpbmd8ZW58MHx8MHx8fDA%3D",
    },
    {
      "name": "Pahartali Bazar Parking",
      "address": "Pahartali, Chattogram",
      "distance": 4.1,
      "availableSpots": 15,
      "pricePerHour": 20.0,
      "image": "https://images.unsplash.com/photo-1493238792000-8113da705763",
    },
    {
      "name": "Chattogram Port Parking",
      "address": "Port Area, Chattogram",
      "distance": 6.8,
      "availableSpots": 120,
      "pricePerHour": 70.0,
      "image":
          "https://images.unsplash.com/photo-1562426509-5044a121aa49?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Nnx8Y2FyJTIwcGFya2luZ3xlbnwwfHwwfHx8MA%3D%3D",
    },
  ];

  @override
  void onInit() {
    super.onInit();
    loadNearbyParking();
  }

  void loadNearbyParking() async {
    isSearching.value = true;
    await Future.delayed(const Duration(seconds: 1));

    // 🔹 Convert map → ParkingLot objects
    nearbyParkingLots.value = parkingLots.map((lot) {
      return ParkingLot(
        name: lot["name"],
        address: lot["address"],
        distance: lot["distance"],
        availableSpots: lot["availableSpots"],
        pricePerHour: lot["pricePerHour"],
        image: lot["image"],
      );
    }).toList();

    isSearching.value = false;
  }

  void refreshParking() {
    loadNearbyParking();
  }
}
