import 'package:flutter/material.dart';
import 'package:my_photo_editor/repository/fliters.dart';

class FilterProvider extends ChangeNotifier {
  List<double> _currentMatrix = colorFilterMatrix[0];
  List<double> get currentMatrix => _currentMatrix;
  void setCurrentMatrix(int index) {
    _currentMatrix = colorFilterMatrix[index];
    notifyListeners();
  }
}
