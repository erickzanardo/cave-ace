import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flame/flame.dart';

import './game.dart';

import 'widgets/label.dart';
import 'widgets/button.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (!kIsWeb) {
    await Flame.util.initialDimensions();
    await Flame.util.fullScreen();
  }
  final res = Size(360.0, 640.0);

  runApp(
      MaterialApp(
          home: TitleScreen(),
          routes: {
            "/game": (_) => GameScreen(res),
          },
      ),
  );

}

class GameScaffold extends StatelessWidget {
  final Widget child;

  GameScaffold({ this.child });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
            color: Color(0xFF8c78a5),
            child: Center(child: child),
        )
    );
  }
}

class TitleScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GameScaffold(child: Center(child:
            Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Label(label: "Cave Ace", fontSize: 30),
                  PrimaryButton(label: "Play", onPress: () {
                    Navigator.of(context).pushNamed("/game");
                  }),
                ],
            )
    ));
  }
}

class GameScreen extends StatelessWidget {
  final Size resolution;

  GameScreen(this.resolution);

  @override
  Widget build(BuildContext ctx) {
    final game = CaveAce(resolution, () {
      Navigator.of(ctx).pop();
    });

    return GameScaffold(
        child: ClipRect(child: Container(
            width: resolution.width,
            height: resolution.height,

            child: game.widget,
        )),
    );
  }
}
