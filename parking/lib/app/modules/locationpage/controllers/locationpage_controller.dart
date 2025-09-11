import 'package:get/get.dart';

class LocationController extends GetxController {
  var selectedLocation = ''.obs;
  var availableLocations = <String>[
    'Chattogram City Center',
    'Agrabad Commercial Area',
    'GEC Circle',
    'New Market Area',
    'Port Area',
  ].obs;

  void selectLocation(String location) {
    selectedLocation.value = location;
  }
}
