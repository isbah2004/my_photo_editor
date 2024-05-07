import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';

class AppImageProvider extends ChangeNotifier {
  Uint8List? currentImage;
  Uint8List? backgroundImage;
  Color backgroundColor = Colors.white;
  
  changeImageFile(File image) {
    currentImage = image.readAsBytesSync();
    notifyListeners();
  }

  changeImage(Uint8List image) {
    currentImage = image;
    notifyListeners();
  }

  changeBackgroundImage(Uint8List image) {
    backgroundImage = image;
    notifyListeners();
  }

  changeBackgroundColor(Color color) {
    backgroundColor = color;
    notifyListeners();
  }
}
