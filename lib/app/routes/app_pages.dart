import 'package:get/get.dart';
import 'package:music_app/app/modules/lookup_module/lookup_binding.dart';
import 'package:music_app/app/modules/lookup_module/lookup_page.dart';

import 'package:music_app/app/modules/splash_module/splash_binding.dart';
import 'package:music_app/app/modules/splash_module/splash_page.dart';
import 'package:music_app/app/modules/player_module/player_binding.dart';
import 'package:music_app/app/modules/player_module/player_page.dart';
import 'package:music_app/app/modules/home_module/home_binding.dart';
import 'package:music_app/app/modules/home_module/home_page.dart';
import 'package:music_app/app/modules/splash_module/splash_page.dart';
part './app_routes.dart';

class AppPages {
  AppPages._();
  static final pages = [
    GetPage(
      name: AppRoutes.home,
      page: () => HomePage(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: AppRoutes.initial,
      page: () => const SplashPage(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: AppRoutes.player,
      page: () => const PlayerPage(),
      binding: PlayerBinding(),
    ),
    GetPage(
        name: AppRoutes.lookup,
        page: () => const LookupPage(),
        binding: LookupBinding(),
    ),
  ];
}
