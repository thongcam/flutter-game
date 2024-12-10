import 'package:hive/hive.dart';

part 'level_data.g.dart';

@HiveType(typeId: 0)
class LevelData {
  @HiveField(0)
  final int levelNumber;
  @HiveField(1)
  bool isCompleted;
  @HiveField(2)
  int score;

  LevelData({
    required this.levelNumber,
    this.isCompleted = false,
    this.score = 0,
  });
}
