import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/image_composition.dart';
import 'package:flutter/src/services/hardware_keyboard.dart';
import 'package:flutter/src/services/keyboard_key.g.dart';
import 'package:second_project/game/game.dart';

import 'platform.dart';

class Player extends SpriteComponent
    with CollisionCallbacks, KeyboardHandler, HasGameRef<SimplePlatformer> {
  final Vector2 _velocity = Vector2.zero();
  int _hAxisInput = 0;
  final double _moveSpeed = 200;
  final double _jumpSpeed = 320;
  bool _jumpInput = false;
  bool _isOnGround = false;
  final Vector2 _up = Vector2(0, -1);
  final double _gravity = 10;
  bool keysArePressed = false;
  late Vector2 _minClamp;
  late Vector2 _maxClamp;

  Player(
    Image image, {
    required Rect levelBounds,
    Vector2? position,
    Vector2? size,
    Vector2? scale,
    double? angle,
    Anchor? anchor,
    int? priority,
    ComponentKey? key,
  }) : super.fromImage(
          image,
          srcPosition: Vector2.zero(),
          srcSize: Vector2.all(32),
          position: position,
          size: size,
          scale: scale,
          angle: angle,
          anchor: anchor,
          priority: priority,
        ) {
    final halfSize = size! / 2;
    _minClamp = levelBounds.topLeft.toVector2() + halfSize;
    _maxClamp = levelBounds.bottomRight.toVector2() - halfSize;
  }

  @override
  FutureOr<void> onLoad() {
    // TODO: implement onLoad
    add(CircleHitbox());
    return super.onLoad();
  }

  @override
  void update(double dt) {
    _velocity.x = _hAxisInput * _moveSpeed;
    _velocity.y += _gravity;

    if (_jumpInput) {
      if (_isOnGround) {
        _velocity.y = -_jumpSpeed;
        _isOnGround = false;
      }
      _jumpInput = false;
    }

    _velocity.y = _velocity.y.clamp(-_jumpSpeed, 150);
    // TODO: implement onLoad
    position += _velocity * dt;

    position.clamp(_minClamp, _maxClamp);

    if (_hAxisInput < 0 && scale.x > 0) {
      flipHorizontallyAroundCenter();
    } else if (_hAxisInput > 0 && scale.x < 0) {
      flipHorizontallyAroundCenter();
    }

    if (gameRef.movingLeft || gameRef.movingRight) {
      _hAxisInput = 0;
      _hAxisInput += gameRef.movingLeft ? -1 : 0;
      _hAxisInput += gameRef.movingRight ? 1 : 0;
      keysArePressed = false;
    } else if (!keysArePressed) {
      _hAxisInput = 0;
    }

    _jumpInput = gameRef.jump;
    super.update(dt);
  }

  @override
  bool onKeyEvent(KeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    // TODO: implement onKeyEvent
    keysArePressed = true;
    _hAxisInput = 0;
    _hAxisInput += keysPressed.contains(LogicalKeyboardKey.keyA) ? -1 : 0;
    _hAxisInput += keysPressed.contains(LogicalKeyboardKey.keyD) ? 1 : 0;
    _jumpInput = keysPressed.contains(LogicalKeyboardKey.space);
    return super.onKeyEvent(event, keysPressed);
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    // TODO: implement onCollision
    if (other is Platform) {
      if (intersectionPoints.length == 2) {
        final mid = (intersectionPoints.elementAt(0) +
                intersectionPoints.elementAt(1)) /
            2;
        final collisionNormal = absoluteCenter - mid;
        final separationDistance = (size.x / 2) - collisionNormal.length + 1;

        collisionNormal.normalize();

        if (_up.dot(collisionNormal) > 0.9) {
          _isOnGround = true;
        }

        position += collisionNormal.scaled(separationDistance);
      }
    }
    super.onCollision(intersectionPoints, other);
  }
}
