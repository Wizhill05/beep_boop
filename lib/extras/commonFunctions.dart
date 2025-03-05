import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

toColor(String hexColor) {
  hexColor = hexColor.toUpperCase().replaceAll("#", "");
  if (hexColor.length == 6) {
    hexColor = "ff$hexColor";
  }
  return Color(int.parse(hexColor, radix: 16));
}

Color bgC = toColor("090909");
Color lightC = toColor("#82ffe8");
Color textCDark = toColor("bebebe");

activeBox(turn, compare, tr, tl, br, bl) {
  return BoxDecoration(
    color: turn ? Colors.grey[900] : toColor("191919"),
    borderRadius: BorderRadius.only(
      topLeft: Radius.circular(double.parse(tl.toString())),
      topRight: Radius.circular(double.parse(tr.toString())),
      bottomLeft: Radius.circular(double.parse(bl.toString())),
      bottomRight: Radius.circular(double.parse(br.toString())),
    ),
    border: Border.all(color: turn ? lightC : Colors.transparent, width: 2),
    boxShadow: [
      BoxShadow(
        color: turn ? lightC.withOpacity(0.3) : Colors.transparent,
        blurRadius: 8,
        spreadRadius: 2,
      ),
    ],
  );
}
