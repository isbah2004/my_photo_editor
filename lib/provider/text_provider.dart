import 'package:flutter/material.dart';

class TextProvider extends ChangeNotifier {
  bool _showEditor = false;
  bool get showEditor => _showEditor;
  void setEditor(bool value) {
    _showEditor = value;
    notifyListeners();
  }
}
