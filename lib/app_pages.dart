import 'package:get/get.dart';

import 'screens/home_screen.dart';
import 'screens/level_selection_screen.dart';

part 'app_routes.dart';

class AppPages {
  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeScreen(),
    ),
    GetPage(
      name: _Paths.LEVEL_SELECTION,
      page: () => LevelSelectionScreen(),
    ),
  ];

  static const INITIAL = _Paths.HOME;
  static const LEVEL_SELECTION = _Paths.LEVEL_SELECTION;
  static const HOME = _Paths.HOME;
}
