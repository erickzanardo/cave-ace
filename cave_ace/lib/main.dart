import 'package:flutter/material.dart';
import 'package:flame/flame.dart';

import './game.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Flame.util.fullScreen();
  runApp(CaveAce().widget);
}

