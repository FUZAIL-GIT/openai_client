import 'package:flutter/material.dart';

class AppTheme {
  static const Color backgroundColor = Color(0xff121212);
  static Color surfaceColor = Colors.white.withOpacity(0.2);
  static const Color primaryColor = Color(0xffBB86FC);
  static const Color errorColor = Color(0xffCF6679);
  static const Color secondaryColor = Color(0xff03DAC6);
  static List<BoxShadow> neumorphismShadow = [
    BoxShadow(
      blurRadius: 17,
      spreadRadius: 1,
      offset: const Offset(8, 8),
      color: const Color(0xff000000).withOpacity(0.4),
    ),
    BoxShadow(
      blurRadius: 17,
      spreadRadius: 1,
      offset: const Offset(-8, -8),
      color: const Color(0xffA5A1A1).withOpacity(0.16),
    ),
  ];
  static const List<LinearGradient> linearGradient = [
    LinearGradient(
      colors: [
        Color.fromARGB(255, 46, 185, 190),
        Color.fromARGB(255, 9, 188, 107),
      ],
      begin: Alignment.bottomLeft,
      end: Alignment.topRight,
    ),
    LinearGradient(
      colors: [
        Color.fromARGB(255, 219, 77, 251),
        Color.fromARGB(255, 134, 10, 249),
      ],
      begin: Alignment.topRight,
      end: Alignment.bottomLeft,
    ),
    LinearGradient(
      colors: [
        Color.fromARGB(255, 12, 162, 232),
        Color.fromARGB(255, 10, 197, 249),
      ],
      begin: Alignment.bottomLeft,
      end: Alignment.topRight,
    ),
  ];
  static const LinearGradient darkLinearGradient = LinearGradient(
    colors: [
      Color(0xff33393E),
      Color(0xff474A4D),
    ],
    begin: Alignment.bottomLeft,
    end: Alignment.topRight,
  );
}
