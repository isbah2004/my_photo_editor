import 'package:flutter/material.dart';

class FitProvider extends ChangeNotifier {
  bool _showRatio = true;
  bool _showBlur = false;
  bool _showColor = false;
  double _blur = 0.0;
  int _x = 1;
  int _y = 1;
  bool _showColorBackground = false;
  bool _showBlurBackground = false;

  bool get showRatio => _showRatio;
  bool get showBlur => _showBlur;
  bool get showColor => _showColor;
  double get blur => _blur;
  int get x => _x;
  int get y => _y;
  bool get showColorBackground => _showColorBackground;
  bool get showBlurBackground => _showBlurBackground;

  void setShowRatio() {
    _showRatio = true;
    _showBlur = false;
    _showColor = false;

    notifyListeners();
  }

  void setBlur(double value) {
    _blur = value;
    notifyListeners();
  }

  void setAspectRatio(int x, int y) {
    _x = x;
    _y = y;
    notifyListeners();
  }

  void setShowBlur() {
    _showRatio = false;
    _showBlur = true;
    _showColor = false;
    notifyListeners();
  }

  void setShowTexture() {
    _showRatio = false;
    _showBlur = false;
    _showColor = false;
    notifyListeners();
  }

  void setShowColor() {
    _showRatio = false;
    _showBlur = false;
    _showColor = true;
    notifyListeners();
  }

  void setShowColorBackground() {
    _showColorBackground = true;
    _showBlurBackground = false;
    notifyListeners();
  }

  void setShowBlurBackground() {
    _showColorBackground = false;
    _showBlurBackground = true;
    notifyListeners();
  }

}
