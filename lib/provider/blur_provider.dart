import 'package:flutter/material.dart';

class BlurProvider extends ChangeNotifier {
  double _sigmaX = 0.0;
  double _sigmaY = 0.0;
  TileMode _tileMode = TileMode.decal;
  double get sigmaX => _sigmaX;
  double get sigmaY => _sigmaY;
  TileMode get tileMode => _tileMode;
  bool _decalVisibility = true;
  bool get decalVisibility => _decalVisibility;
  bool _clampVisibility = false;
  bool get clampVisibility => _clampVisibility;
  bool _mirrorVisibility = false;
  bool get mirrorVisibility => _mirrorVisibility;
  bool _repeatedVisibility = false;
  bool get repeatedVisibility => _repeatedVisibility;
  setDecalVisibility() {
    _decalVisibility = true;
    _clampVisibility = false;
    _mirrorVisibility = false;
    _repeatedVisibility = false;
    _tileMode = TileMode.decal;
    notifyListeners();
  }

  setClampVisibility() {
    _decalVisibility = false;
    _clampVisibility = true;
    _mirrorVisibility = false;
    _repeatedVisibility = false;
    _tileMode = TileMode.clamp;
    notifyListeners();
  }

  setMirrorVisibility() {
    _decalVisibility = false;
    _clampVisibility = false;
    _mirrorVisibility = true;
    _repeatedVisibility = false;
    _tileMode = TileMode.mirror;
    notifyListeners();
  }

  setRepeatedVisibility() {
    _decalVisibility = false;
    _clampVisibility = false;
    _mirrorVisibility = false;
    _repeatedVisibility = true;
    _tileMode = TileMode.repeated;
    notifyListeners();
  }

  setSigmaXBlur(double value) {
    _sigmaX = value;
    notifyListeners();
  }

  setSigmaYBlur(double value) {
    _sigmaY = value;
    notifyListeners();
  }
}
