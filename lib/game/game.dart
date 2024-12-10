import 'dart:async';

import 'package:flame/camera.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/painting.dart';
import 'package:second_project/game/hud/hud.dart';
import 'package:second_project/game/jumpButton.dart';
import 'package:second_project/game/level/level.dart';
import 'package:flame/image_composition.dart';
import 'package:second_project/game/model/player_data.dart';

class SimplePlatformer extends FlameGame
    with
        HasCollisionDetection,
        HasKeyboardHandlerComponents,
        DragCallbacks,
        TapCallbacks {
  int level;
  SimplePlatformer({required this.level});
  late final CameraComponent cameraComponent;
  @override
  late final World world;
  late Image spriteSheet;
  final playerData = PlayerData();
  Level? _currentLevel;
  late JoystickComponent joystick;
  bool movingRight = false;
  bool movingLeft = false;
  bool jump = false;
  @override
  FutureOr<void>? onLoad() async {
    // TODO: implement onLoad
    await Flame.device.fullScreen();
    await Flame.device.setLandscape();
    await images.loadAllImages();

    spriteSheet = images.fromCache("Spritesheet.png");

    world = World();
    cameraComponent = CameraComponent.withFixedResolution(
      world: world,
      width: 680,
      height: 330,
    );
    cameraComponent.viewfinder.anchor = Anchor.center;

    addJoystick();
    add(JumpButton());

    loadLevel("Level${level}.tmx");
    addAll([world, cameraComponent]);

    cameraComponent.viewport.add(Hud(priority: 1));

    return super.onLoad();
  }

  void loadLevel(String levelName) {
    _currentLevel?.removeFromParent();
    _currentLevel = Level(levelName, world);
    world.add(_currentLevel!);
  }

  void addJoystick() {
    joystick = JoystickComponent(
      knob: SpriteComponent(
          sprite: Sprite(
        images.fromCache("Knob.png"),
      )),
      background:
          SpriteComponent(sprite: Sprite(images.fromCache("Joystick.png"))),
      margin: const EdgeInsets.only(left: 100, bottom: 100),
      priority: 10,
    );

    add(joystick);
  }

  @override
  void update(double dt) {
    // TODO: implement update
    updateJoystick();
    super.update(dt);
  }

  void updateJoystick() {
    switch (joystick.direction) {
      case JoystickDirection.left:
        movingRight = false;
        movingLeft = true;
        break;
      case JoystickDirection.right:
        movingRight = true;
        movingLeft = false;
        break;
      default:
        movingRight = false;
        movingLeft = false;
        break;
    }
  }
}
