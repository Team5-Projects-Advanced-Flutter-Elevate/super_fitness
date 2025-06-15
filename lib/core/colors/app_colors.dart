import 'package:flutter/material.dart';

abstract class AppColors {
  static const Color _white = Color(0xFFFFFFFF);
  static const MaterialColor _mainColorLight = MaterialColor(0xFFFF4100, {
    10: Color(0xFFFFECE5),
    20: Color(0xFFFFD9CC),
    30: Color(0xFFFFC6B2),
    40: Color(0xFFFFB399),
    50: Color(0xFFFFA080),
    60: Color(0xFFFF8D66),
    70: Color(0xFFFF7A4D),
    80: Color(0xFFFF6733),
    90: Color(0xFFFF541A),
    100: Color(0xFFFF4100),
  });

  static const MaterialColor _mainColorDark = MaterialColor(0xFFFF4100, {
    10: Color(0xFFFF4100),
    20: Color(0xFFE52800),
    30: Color(0xFFCC0E00),
    40: Color(0xFFB20000),
    50: Color(0xFF990000),
    60: Color(0xFF800000),
    70: Color(0xFF660000),
    80: Color(0xFF4D0000),
    90: Color(0xFF330000),
    100: Color(0xFF1A0000),
  });

  static const MaterialColor _black = MaterialColor(0xFF242424, {
    10: Color(0xFFE9E9E9),
    20: Color(0xFFD3D3D3),
    30: Color(0xFFBDBDBD),
    40: Color(0xFFA7A7A7),
    50: Color(0xFF919191),
    60: Color(0xFF7C7C7C),
    70: Color(0xFF666666),
    80: Color(0xFF505050),
    90: Color(0xFF3A3A3A),
    100: Color(0xFF242424),
  });

  static Color get white => _white;

  static MaterialColor get mainColorDark => _mainColorDark;

  static MaterialColor get mainColorLight => _mainColorLight;

  static MaterialColor get black => _black;

  static Color get transparent => Colors.transparent;
}
