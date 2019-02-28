import 'package:flutter/material.dart';

Gradient buttonGradient() {
  return LinearGradient(
    stops: [0, 1],
    colors: [
      Color.fromRGBO(1, 98, 152, 1),
      Color.fromRGBO(0, 176, 232, 1)
    ]
  );
}