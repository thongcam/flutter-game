import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/experimental.dart';
import 'package:flame/image_composition.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:get/get.dart';
import 'package:second_project/game/game.dart';
import 'package:second_project/level_controller.dart';
import 'package:second_project/screens/result_screen.dart';

import '../actors/door.dart';
import '../actors/platform.dart';
import '../actors/player.dart';
import '../actors/coin.dart';

class Level extends Component with HasGameRef<SimplePlatformer> {
  final LevelController levelController = Get.find<LevelController>();

  final String levelName;
  late Player _player;
  late Rect _levelBounds;
  late World world;

  Level(this.levelName, this.world) : super();

  @override
  FutureOr<void>? onLoad() async {
    // TODO: implement onLoad
    final level = await TiledComponent.load(levelName, Vector2.all(32));
    add(level);

    _levelBounds = Rect.fromLTWH(
        0,
        0,
        (level.tileMap.map.width * level.tileMap.map.tileWidth).toDouble(),
        (level.tileMap.map.height * level.tileMap.map.tileHeight).toDouble());

    _spawnActors(level.tileMap);
    _setupCamera();

    return super.onLoad();
  }

  void _spawnActors(RenderableTiledMap tileMap) {
    final platformsLayer = tileMap.getLayer<ObjectGroup>("Platforms");

    for (final platformObject in platformsLayer!.objects) {
      final platform = Platform(
          position: Vector2(platformObject.x, platformObject.y),
          size: Vector2(platformObject.width, platformObject.height));
      world.add(platform);
    }

    final spawnPointsLayer = tileMap.getLayer<ObjectGroup>("SpawnPoints");

    for (final spawnPoint in spawnPointsLayer!.objects) {
      switch (spawnPoint.type) {
        case 'Player':
          _player = Player(gameRef.spriteSheet,
              levelBounds: _levelBounds,
              anchor: Anchor.center,
              position: Vector2(spawnPoint.x, spawnPoint.y),
              size: Vector2(spawnPoint.width, spawnPoint.height));
          world.add(_player);
        case 'Coin':
          final coin = Coin(gameRef.spriteSheet,
              position: Vector2(spawnPoint.x, spawnPoint.y),
              size: Vector2(spawnPoint.width, spawnPoint.height));
          world.add(coin);
        case 'Door':
          final door = Door(gameRef.spriteSheet,
              position: Vector2(spawnPoint.x, spawnPoint.y),
              size: Vector2(spawnPoint.width, spawnPoint.height),
              onPlayerEnter: _finishLevel);
          world.add(door);
      }
    }
  }

  void _setupCamera() {
    gameRef.cameraComponent.follow(_player);
    gameRef.cameraComponent.setBounds(
        Rectangle.fromLTWH(0, 0, _levelBounds.width, _levelBounds.height),
        considerViewport: true);
  }

  void _finishLevel() {
    levelController.setLevelCompletion(
        gameRef.level, true, gameRef.playerData.score.value);
    Get.offAll(() => FinishScreen(
        level: gameRef.level, score: gameRef.playerData.score.value));
  }
}
