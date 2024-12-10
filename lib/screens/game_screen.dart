import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:second_project/game/game.dart';

class GameScreen extends StatelessWidget {
  final int level;

  const GameScreen({super.key, required this.level});

  @override
  Widget build(BuildContext context) {
    // Create your Flame game instance here, passing the level as a parameter
    final game = SimplePlatformer(level: level);

    return Scaffold(
      body: GameWidget(game: game),
    );
  }
}
