import 'package:get/get.dart';

import '../modules/accountpage/bindings/accountpage_binding.dart';
import '../modules/accountpage/views/accountpage_view.dart';
import '../modules/activitypage/bindings/activitypage_binding.dart';
import '../modules/activitypage/views/activitypage_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/homepage/bindings/homepage_binding.dart';
import '../modules/homepage/views/homepage_view.dart';
import '../modules/location_details/bindings/location_details_binding.dart';
import '../modules/location_details/views/location_details_view.dart';
import '../modules/locationpage/bindings/locationpage_binding.dart';
import '../modules/locationpage/views/locationpage_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/parkingdetails/bindings/parkingdetails_binding.dart';
import '../modules/parkingdetails/views/parkingdetails_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.LOGIN;

  static final routes = [
    GetPage(name: _Paths.HOME, page: () => HomeView(), binding: HomeBinding()),
    GetPage(
      name: _Paths.LOCATIONPAGE,
      page: () => const LocationpageView(),
      binding: LocationpageBinding(),
    ),
    GetPage(
      name: _Paths.ACTIVITYPAGE,
      page: () => const ActivitypageView(),
      binding: ActivitypageBinding(),
    ),
    GetPage(
      name: _Paths.ACCOUNTPAGE,
      page: () => const AccountpageView(),
      binding: AccountpageBinding(),
    ),
    GetPage(
      name: _Paths.HOMEPAGE,
      page: () => HomepageView(),
      binding: HomepageBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.LOCATION_DETAILS,
      page: () => const LocationDetailsView(),
      binding: LocationDetailsBinding(),
    ),
    GetPage(
      name: _Paths.PARKINGDETAILS,
      page: () => const ParkingdetailsView(),
      binding: ParkingdetailsBinding(),
    ),
  ];
}
