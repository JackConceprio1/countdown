import 'package:flutter/material.dart';

var colorsLists = <ColorList>[
  ColorList(
    colorName: "Red",
    listColors: [
      const Color(0xFFEF5350).value,
      const Color(0xFFF44336).value,
      const Color(0xFFE53935).value,
    ],
  ),
  ColorList(
    colorName: "Pink",
    listColors: [
      const Color(0xFFEC407A).value,
      const Color(0xFFE91E63).value,
      const Color(0xFFD81B60).value,
    ],
  ),
  ColorList(
    colorName: "Purple",
    listColors: [
      const Color(0xFFAB47BC).value,
      const Color(0xFF9C27B0).value,
      const Color(0xFF8E24AA).value,
    ],
  ),
  ColorList(
    colorName: "Deep Purple",
    listColors: [
      const Color(0xFF7E57C2).value,
      const Color(0xFF673AB7).value,
      const Color(0xFF5E35B1).value,
    ],
  ),
  ColorList(
    colorName: "Indigo",
    listColors: [
      const Color(0xFF5C6BC0).value,
      const Color(0xFF3F51B5).value,
      const Color(0xFF3949AB).value,
    ],
  ),
  ColorList(
    colorName: "Blue",
    listColors: [
      const Color(0xFF42A5F5).value,
      const Color(0xFF2196F3).value,
      const Color(0xFF1E88E5).value,
    ],
  ),
  ColorList(
    colorName: "Light Blue",
    listColors: [
      const Color(0xFF29B6F6).value,
      const Color(0xFF03A9F4).value,
      const Color(0xFF039BE5).value,
    ],
  ),
  ColorList(
    colorName: "Pink",
    listColors: [
      const Color(0xFFEC407A).value,
      const Color(0xFFE91E63).value,
      const Color(0xFFD81B60).value,
    ],
  ),
  ColorList(
    colorName: "Cyan",
    listColors: [
      const Color(0xFF26C6DA).value,
      const Color(0xFF00BCD4).value,
      const Color(0xFF00ACC1).value,
    ],
  ),
  ColorList(
    colorName: "Teal",
    listColors: [
      const Color(0xFF26A69A).value,
      const Color(0xFF009688).value,
      const Color(0xFF00897B).value,
    ],
  ),
  ColorList(
    colorName: "Green",
    listColors: [
      const Color(0xFF66BB6A).value,
      const Color(0xFF4CAF50).value,
      const Color(0xFF43A047).value,
    ],
  ),
  ColorList(
    colorName: "Light Green",
    listColors: [
      const Color(0xFF9CCC65).value,
      const Color(0xFF8BC34A).value,
      const Color(0xFF7CB342).value,
    ],
  ),
  ColorList(
    colorName: "Lime",
    listColors: [
      const Color(0xFFD4E157).value,
      const Color(0xFFCDDC39).value,
      const Color(0xFFC0CA33).value,
    ],
  ),
  ColorList(
    colorName: "Yellow",
    listColors: [
      const Color(0xFFFFEE58).value,
      const Color(0xFFFFEB3B).value,
      const Color(0xFFFDD835).value,
    ],
  ),
  ColorList(
    colorName: "Amber",
    listColors: [
      const Color(0xFFFFCA28).value,
      const Color(0xFFFFC107).value,
      const Color(0xFFFFB300).value,
    ],
  ),
  ColorList(
    colorName: "Orange",
    listColors: [
      const Color(0xFFFFA726).value,
      const Color(0xFFFF9800).value,
      const Color(0xFFFB8C00).value,
    ],
  ),
  ColorList(
    colorName: "Deep Orange",
    listColors: [
      const Color(0xFFFF7043).value,
      const Color(0xFFFF5722).value,
      const Color(0xFFF4511E).value,
    ],
  ),
  ColorList(
    colorName: "Brown",
    listColors: [
      const Color(0xFF8D6E63).value,
      const Color(0xFF795548).value,
      const Color(0xFF6D4C41).value,
    ],
  ),
  ColorList(
    colorName: "Blue Grey",
    listColors: [
      const Color(0xFF78909C).value,
      const Color(0xFF607D8B).value,
      const Color(0xFF546E7A).value,
    ],
  ),
];

class ColorList {
  final String colorName;
  final List<int> listColors;

  ColorList({
    required this.colorName,
    required this.listColors,
  });
}
