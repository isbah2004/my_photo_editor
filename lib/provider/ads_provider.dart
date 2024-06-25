import 'package:flutter/material.dart';

class HomeAdProvider extends ChangeNotifier {
 
  bool _homeAdLoaded = false;
  bool get homeAdLoaded => _homeAdLoaded;
  setHomeAdState(bool value) {
    _homeAdLoaded = value;
    notifyListeners();
  }
}
class PickerAdProvider extends ChangeNotifier {
   bool _pickerAdLoaded = false;
  bool get pickerAdLoaded => _pickerAdLoaded;
  setPickerAdState(bool value) {
    _pickerAdLoaded = value;
    notifyListeners();
  }
}