import 'package:flutter/material.dart';

class MaskProvider extends ChangeNotifier {
  BlendMode _blendMode = BlendMode.dstIn;
  BlendMode get blendMode => _blendMode;
  void setBlendMode(BlendMode value) {
    _blendMode = value;
    notifyListeners();
  }

  IconData _maskIcon = Icons.circle;
  IconData get maskIcon =>  _maskIcon;
  void setMaskIcon(IconData icon) {
    _maskIcon = icon;
    notifyListeners();
  }
}
