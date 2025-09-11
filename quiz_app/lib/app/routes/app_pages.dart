import 'package:get/get.dart';
import 'package:quiz_app/app/modules/home/bindings/home_binding.dart';
import 'package:quiz_app/app/modules/home/views/home_view.dart';
import 'package:quiz_app/app/modules/onboardingPage/bindings/onboarding_page_binding.dart';
import 'package:quiz_app/app/modules/onboardingPage/views/onboarding_page_view.dart';
part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.ONBOARDING_PAGE;

  static final routes = [
    GetPage(
      name: _Paths.ONBOARDING_PAGE,
      page: () => const OnboardingPageView(),
      binding: OnboardingPageBinding(),
    ),
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
  ];
}
