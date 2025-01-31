import 'package:flutter/material.dart';

class Common {
  static Widget gap({double h = 10, double div = 1}) {
    return SizedBox(height: h / div);
  }

  static Matrix4 rotation(double deg) {
    return Matrix4.identity()
      ..setEntry(3, 2, 0.001)
      ..rotateZ(deg * 0.0174533);
  }
}
