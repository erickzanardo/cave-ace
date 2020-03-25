import 'package:flutter/material.dart';
import 'package:flame/flame.dart';

import './game.dart';

import './utils/stage_loader.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Flame.util.fullScreen();

  final stage = await StageLoader.loadStageData('test');
  runApp(CaveAce(stage).widget);
}

