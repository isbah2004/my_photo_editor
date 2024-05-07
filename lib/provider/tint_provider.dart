import 'package:flutter/material.dart';

class TintProvider extends ChangeNotifier {
  double _opacity = 0.5;
  double get opacity => _opacity;
  void setOpacity(double value) {
    _opacity = value;
    notifyListeners();
  }

  int _index = 0;
  int get index => _index;
  void setIndex(int value) {
    _index = value;
    notifyListeners();
  }
}
