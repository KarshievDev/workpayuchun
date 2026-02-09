import 'dart:math';
import 'package:flutter/material.dart';

Color getRandomColor() {
  final List<Color> colors = Colors.primaries;

  final random = Random();
  return colors[random.nextInt(colors.length)];
}
