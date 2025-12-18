import 'package:flutter/material.dart';

class Appcolor {
  static const Color black = Colors.black;
  static const Color white = Color.fromRGBO(251, 253, 255, 1);
  static const Color blue = Color.fromRGBO(233, 187, 18, 1);
  static const Color darkblue = Color.fromRGBO(233, 187, 18, 1);
  static const Color selectionblue = Color.fromRGBO(77, 210, 253, 1);
  static const Color lightblue = Color.fromRGBO(187, 227, 255, 1);
  static const Color grey = Color.fromRGBO(205, 205, 205, 1);
  static const Color transparent = Colors.transparent;
  static const Color red = Colors.red;
  static const Color green = Colors.green;
  static const Color lightgrey = Color.fromRGBO(240, 240, 240, 1);
  static const Color yellow = Colors.yellow;
  static const Color orange = Colors.orange;
}

class AppGradients {
  static const LinearGradient background = LinearGradient(
    colors: [Appcolor.white, Color.fromRGBO(225, 224, 176, 1)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
  static const LinearGradient scaffoldbackground = LinearGradient(
    colors: [Appcolor.darkblue, Color.fromRGBO(5, 55, 85, 1)],
    begin: Alignment.topCenter,
    end: Alignment.center,
  );
}
