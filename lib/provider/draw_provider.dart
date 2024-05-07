import 'package:flutter/material.dart';

class DrawProvider extends ChangeNotifier {
  double _thickness = 0.5;

  double get thickness => _thickness;
  setPointerThickness(double value) {
    _thickness = value;

    notifyListeners();
  }

  Color _tempColor = Colors.black;
  Color get tempColor => _tempColor;
  setTempColor(Color value) {
    _tempColor = value;
    notifyListeners();
  }
}
