import 'package:flutter/material.dart';

abstract class TextStyles {
  static const TextStyle nameTextStyle = TextStyle(
    color: Colors.white,
    fontSize: 24,
  );

  static const TextStyle helpTextStyle = TextStyle(
    color: Colors.white,
    fontSize: 14,
  );

  static const TextStyle helpTextUnderlineStyle = TextStyle(
    color: Colors.white,
    fontSize: 24,
    decoration: TextDecoration.underline
  );

  static const TextStyle helpGreyTextStyle = TextStyle(
    color: Colors.grey,
    fontSize: 14,
  );
}