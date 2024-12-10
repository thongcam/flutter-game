import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:second_project/app_pages.dart';

class FinishScreen extends StatelessWidget {
  final int level;
  final int score;

  const FinishScreen({super.key, required this.level, required this.score});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Platformer Game'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Level $level Completed!',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Text(
              'Score: $score',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                Get.toNamed(AppPages.LEVEL_SELECTION);
              },
              child: const Text(
                'Back to Levels',
                style: TextStyle(fontSize: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
