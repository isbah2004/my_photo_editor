import 'package:flutter/material.dart';

class CropProvider extends ChangeNotifier {
  bool _freeVisibility = true;

  bool get freeVisibility => _freeVisibility;
  bool _squareVisibility = false;

  bool get squareVisibility => _squareVisibility;
  bool _ratio1Visibility = false;

  bool get ratio1Visibility => _ratio1Visibility;
  bool _ratio2Visibility = false;

  bool get ratio2Visibility => _ratio2Visibility;
  bool _ratio3Visibility = false;

  bool get ratio3Visibility => _ratio3Visibility;
  bool _ratio4Visibility = false;

  bool get ratio4Visibility => _ratio4Visibility;
  void setFreeVisibility() {
    _ratio1Visibility = false;
    _ratio2Visibility = false;
    _squareVisibility = false;_ratio4Visibility = false;
    _ratio3Visibility = false;
    _freeVisibility = true;
    notifyListeners();
  }

  void setSquareVisibility() {
    _freeVisibility = false;
    _ratio1Visibility = false;
    _ratio2Visibility = false;
    _ratio3Visibility = false;_ratio4Visibility = false;
    _squareVisibility = true;
    notifyListeners();
  }

  void setRatio1Visibility() {
    _freeVisibility = false;

    _ratio2Visibility = false;
    _squareVisibility = false;
    _ratio3Visibility = false;_ratio4Visibility = false;
    _ratio1Visibility = true;
    notifyListeners();
  }

  void setRatio2Visibility() {
    _freeVisibility = false;
    _ratio1Visibility = false;

    _squareVisibility = false;
    _ratio3Visibility = false;_ratio4Visibility = false;
    _ratio2Visibility = true;
    notifyListeners();
  }

  void setRatio3Visibility() {
    _freeVisibility = false;
    _ratio1Visibility = false;
    _ratio2Visibility = false;
    _squareVisibility = false;_ratio4Visibility = false;
    _ratio3Visibility = true;
    notifyListeners();
  }

  void setRatio4Visibility() {
    _freeVisibility = false;
    _ratio1Visibility = false;
    _ratio2Visibility = false;
    _squareVisibility = false;
    _ratio3Visibility = false;
    _ratio4Visibility = true;
    notifyListeners();
  }
}
