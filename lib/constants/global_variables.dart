import 'package:flutter/material.dart';

class GlobalVariables {
  static const Color purple = Color(0XFF7B61FF);
  static const Color voilet = Color(0XFF7F3DFF);
  static const Color bg = Color(0XFFF6F6F6);
  static const Color lightbg = Color(0XFFEEE5FF);
  static const Color yellow = Color(0XFFfcb122);
  static const Color lyellow = Color(0XFFfceed4);
  static const Color red = Color(0xFFfd3c4a);
  static const Color green = Color(0xFF00a86b);
  static const Color load = Color.fromARGB(91, 138, 136, 131);

  static LinearGradient grad1 = LinearGradient(
    colors: [
      Color(0XFF7B61FF),
      Color.fromARGB(255, 216, 61, 255),
    ],
    stops: [0.5, 1],
  );
}
