import 'package:flutter/material.dart';
import 'package:solink_flutter/ui/screen/user_screen.dart';

import 'dart:math';

int getRandomNumber(int min, int max) {
  final random = Random();
  return min + random.nextInt(max - min + 1);
}

class HomeScreen extends StatelessWidget {

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            int randomNumber = getRandomNumber(1, 10);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => UserScreen(userId:randomNumber, pageNum:randomNumber, pagePer:randomNumber),
              ),
            );
          },
          child: Text('GoTo User Screen'),
        ),
      ),
    );
  }
}