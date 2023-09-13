import 'package:flutter/material.dart';

MaterialColor createMaterialColor(Color color) {
  int key = 0;
  Map<int, Color> swatch = {};

  for (var i = 0; i < 10; i++) {
    key = (i == 0) ? 50 : i * 100;

    const opacity = 0.1 * 1 + 0.1;
    swatch[key] = Color.fromRGBO(
      color.red,
      color.green,
      color.blue,
      opacity,
    );
  }

  return MaterialColor(color.value, swatch);
}
