import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flame/flame.dart';
import 'package:flame_splash_screen/flame_splash_screen.dart';

import './game.dart';

import 'widgets/slide_in_container.dart';
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
          routes: {
            "/": (ctx) => FlameSplashScreen(
                theme: FlameSplashTheme.dark,
                showBefore: (BuildContext context) {
                  return Image.asset('assets/images/cptblackpixel.png',
                      width: 400);
                },
                onFinish: (BuildContext context) {
                  Navigator.pushNamed(context, "/tile");
                },
            ),
            "/tile": (_) => TitleScreen(),
            "/game": (_) => GameScreen(res),
          },
      ),
  );

}

class GameScaffold extends StatelessWidget {
  final Widget child;
  final Color color;

  GameScaffold({ this.child, this.color = const Color(0xFF8c78a5)});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
            color: color,
            child: Center(child: child),
        )
    );
  }
}

class TitleScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GameScaffold(color: Color(0xffe0b989), child: Center(child:
            Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                      flex: 7,
                      child: SlideInContainer(
                          from: Offset(0.0, -1.0),
                          child: Image.asset(
                              'assets/images/title_screen.png',
                              filterQuality: FilterQuality.high,
                              fit: BoxFit.fill
                          )
                      )
                  ),
                  SlideInContainer(
                      from: Offset(0.0, 1.0),
                      child: Container(
                          margin: EdgeInsets.only(bottom: 50),
                          child: PrimaryButton(label: "Play", onPress: () {
                            Navigator.of(context).pushNamed("/game");
                          })
                      ),
                  ),
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
