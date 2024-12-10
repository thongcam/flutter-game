import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:second_project/game/game.dart';

class JumpButton extends SpriteComponent
    with HasGameRef<SimplePlatformer>, TapCallbacks {
  JumpButton();
  @override
  FutureOr<void> onLoad() {
    // TODO: implement onLoad
    sprite = Sprite(gameRef.images.fromCache("JumpButton.png"));
    position = Vector2(game.size.x - 100 - 64, game.size.y - 100 - 64);
    priority = 10;
    return super.onLoad();
  }

  @override
  void onTapDown(TapDownEvent event) {
    // TODO: implement onTapDown
    game.jump = true;
    super.onTapDown(event);
  }

  @override
  void onTapUp(TapUpEvent event) {
    // TODO: implement onTapUp
    game.jump = false;
    super.onTapUp(event);
  }
}

class TapsCallback {}
