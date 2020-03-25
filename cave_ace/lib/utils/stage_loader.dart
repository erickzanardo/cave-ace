import 'package:flame/flame.dart';
import 'dart:convert';

import '../models/stage.dart';

class StageLoader {
  static Future<Stage> loadStageData(String filename) async {
    final raw = await Flame.assets.readFile("stages/$filename.json");
    final json = jsonDecode(raw);

    return Stage.fromJson(json);
  }
}
