import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Label extends Text {
  Label(
      {String label,
      Color fontColor = const Color(0xFF2C1E31),
      double fontSize = 12.0,
      TextAlign textAlign})
      : super(label,
            textAlign: textAlign,
            style: TextStyle(
                color: fontColor, fontSize: fontSize, fontFamily: 'CubeCavern'));
}
