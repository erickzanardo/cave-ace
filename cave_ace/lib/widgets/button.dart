import 'package:flutter/material.dart';

typedef OnPress = void Function();

class PrimaryButton extends Button {
  PrimaryButton({String label, OnPress onPress})
      : super(
          label: label,
          onPress: onPress,
          fontColor: Color(0xff3859b3),
          backgroundColor: Color(0xff3e3b65),
        );
}

class SecondaryButton extends Button {
  SecondaryButton({String label, OnPress onPress})
      : super(
          label: label,
          onPress: onPress,
          fontColor: Color(0xffb0a7b8),
          backgroundColor: Color(0xffb0a7b8),
        );
}

class Button extends StatelessWidget {
  final String label;
  final OnPress onPress;
  final double minWidth;

  final Color fontColor;
  final Color backgroundColor;

  Button(
      {this.label,
      this.onPress,
      this.fontColor,
      this.backgroundColor,
      this.minWidth = 250});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(2.5),
      child: ButtonTheme(
        minWidth: minWidth,
        height: 36,
        child: RaisedButton(
          color: backgroundColor,
          onPressed: onPress,
          child: Text(
            label,
            style: TextStyle(
              color: fontColor,
              fontFamily: 'CubeCavern',
              fontSize: 28,
            ),
          ),
        ),
      ),
    );
  }
}
