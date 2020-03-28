import 'package:flutter/material.dart';

import './label.dart';
import './button.dart';

class GameOverOverlay extends StatelessWidget {

  final double width;
  final double height;

  GameOverOverlay({
    this.width,
    this.height,
  });

  @override
  Widget build(_) {
    return Center(
        child: Container(
            width: this.width,
            height: this.height,
            color: Color(0xff5e5b8c),

            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Label(label: "Game Over", fontSize: 50),
                  PrimaryButton(label: "Restart"),
                  SecondaryButton(label: "Exit"),
                ]
            ),
        ),
    );
  }
}
