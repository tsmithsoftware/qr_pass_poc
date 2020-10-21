import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';

class QrButton extends StatelessWidget {
  final String text;
  final Color textColor;
  final Color buttonColor;
  final bool hasBorder;
  final Function() onPressed;
  final double padding;
  final double fontSize;
  final double borderRadius;

  static QrButton decide(String text, Function() onPressed, bool isPrimary) {
    return isPrimary
        ? QrButton.primary(text, onPressed)
        : QrButton.secondary(text, onPressed);
  }

  static QrButton secondary(String text, Function() onPressed) {
    return QrButton(
      text: text,
      onPressed: onPressed,
      buttonColor: Colors.white,
      textColor: kBPGreen,
    );
  }

  static QrButton secondaryBig(String text, Function() onPressed) {
    return QrButton(
      text: text,
      onPressed: onPressed,
      buttonColor: Colors.white,
      textColor: kBPGreen,
      padding: 12,
      fontSize: 26,
    );
  }

  static QrButton secondaryBorderless(String text, Function() onPressed) {
    return QrButton(
      text: text,
      hasBorder: false,
      onPressed: onPressed,
      buttonColor: Colors.white,
      textColor: kBPGreen,
    );
  }

  static QrButton primary(String text, Function() onPressed) {
    return QrButton(
      text: text,
      hasBorder: false,
      onPressed: onPressed,
      buttonColor: kBPGreen,
      textColor: Colors.white,
    );
  }

  static QrButton primaryBig(String text, Function() onPressed) {
    return QrButton(
      text: text,
      onPressed: onPressed,
      buttonColor: kBPGreen,
      hasBorder: false,
      textColor: Colors.white,
      padding: 12,
      fontSize: 26,
    );
  }

  static QrButton negative(String text, Function() onPressed) {
    return QrButton(
      text: text,
      onPressed: onPressed,
      buttonColor: kBPYellowOrange,
      textColor: Colors.white,
      hasBorder: false,
    );
  }

  static QrButton negativeBig(String text, Function() onPressed) {
    return QrButton(
      text: text,
      onPressed: onPressed,
      buttonColor: kBPOrange,
      textColor: Colors.white,
      hasBorder: false,
      padding: 12,
      fontSize: 26,
    );
  }

  QrButton(
      {@required this.text,
        this.buttonColor = const Color(0xFF000000),
        @required this.onPressed,
        this.hasBorder = true,
        this.textColor = const Color(0xFFDDDDDD),
        this.padding = 8,
        this.fontSize = 20,
        this.borderRadius = 100});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      color: buttonColor,
      padding: EdgeInsets.symmetric(vertical: padding, horizontal: padding * 2),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          side: hasBorder && onPressed != null
              ? BorderSide(color: kBPGreen, width: 2)
              : BorderSide.none),
      disabledColor: Colors.black12,
      disabledTextColor: Colors.black54,
      textColor: textColor,
      onPressed: onPressed,
      child: Text(text,
          style: TextStyle(
            fontSize: fontSize,
          )),
    );
  }
}
