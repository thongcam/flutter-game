import 'dart:async';

import 'package:flame/components.dart';
import 'package:second_project/game/game.dart';

class Hud extends Component with HasGameRef<SimplePlatformer> {
  Hud({super.children, super.priority});

  @override
  FutureOr<void> onLoad() {
    // TODO: implement onLoad
    final scoreTextComponent =
        TextComponent(text: "Score: 0", position: Vector2.all(10));
    add(scoreTextComponent);

    gameRef.playerData.score.addListener(() {
      scoreTextComponent.text = "Score: ${gameRef.playerData.score.value}";
    });
    return super.onLoad();
  }
}
