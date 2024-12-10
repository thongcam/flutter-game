import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:second_project/app_pages.dart';
import 'package:second_project/level_controller.dart';
import 'package:second_project/screens/game_screen.dart';

class LevelSelectionScreen extends StatelessWidget {
  LevelSelectionScreen({super.key});

  final LevelController levelController = Get.find<LevelController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Levels'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Get.toNamed(AppPages.HOME);
          },
        ),
      ),
      body: Center(
        child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Level Selection',
                    style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.screen_rotation),
                      SizedBox(width: 10),
                      Flexible(
                        child: Text(
                          'If you wish to play the game in landscape mode, turn your phone before starting.',
                          textAlign: TextAlign.start,
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 40),
                  Wrap(
                    spacing: 8.0,
                    runSpacing: 8.0,
                    children: [
                      _buildLevelCard(
                        levelNumber: 1,
                        isCompleted: levelController.isLevelCompleted(1),
                        score: levelController
                            .getLevelScore(1), // Replace with actual score
                      ),
                      _buildLevelCard(
                        levelNumber: 2,
                        isCompleted: levelController.isLevelCompleted(2),
                        score: levelController
                            .getLevelScore(2), // Replace with actual score
                      ),
                      _buildLevelCard(
                        levelNumber: 3,
                        isCompleted: levelController.isLevelCompleted(3),
                        score: levelController
                            .getLevelScore(3), // Replace with actual score
                      ),
                    ],
                  ),
                ],
              ),
            )),
      ),
    );
  }

  Widget _buildLevelCard({
    required int levelNumber,
    required bool isCompleted,
    required int score,
  }) {
    return Card(
      elevation: 4, // Add elevation for a 3D effect
      child: Padding(
        padding: const EdgeInsets.all(24.0), // Increase padding
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                Get.to(() => GameScreen(level: levelNumber));
              },
              child: Text(
                'Level $levelNumber',
                style: TextStyle(fontSize: 20), // Increase font size
              ),
            ),
            SizedBox(height: 16),
            Text(
              isCompleted ? 'Score: $score' : 'Not Completed',
              style: TextStyle(
                fontSize: 16, // Increase font size
                color: isCompleted ? Colors.black : Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
