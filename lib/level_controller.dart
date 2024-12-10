import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:second_project/level_data.dart';

class LevelController extends GetxController {
  static const String boxName = 'level_data';

  late Box<LevelData> _box;

  @override
  void onInit() async {
    // Initialize Hive

    _box = Hive.box(boxName);

    // Open the box

    // Initialize the box if it's empty
    if (_box.isEmpty) {
      for (int i = 1; i <= 3; i++) {
        _box.add(LevelData(levelNumber: i));
      }
    }
    super.onInit();
  }

  bool isLevelCompleted(int levelNumber) {
    final levelData = _box.get(levelNumber - 1);
    return levelData?.isCompleted ?? false;
  }

  int getLevelScore(int levelNumber) {
    final levelData = _box.get(levelNumber - 1);
    return levelData?.score ?? 0;
  }

  void setLevelCompletion(int levelNumber, bool isCompleted, int score) {
    final levelData = _box.get(levelNumber - 1);
    levelData?.isCompleted = isCompleted;
    levelData?.score = score;
    _box.put(levelNumber - 1, levelData!);
  }
}
