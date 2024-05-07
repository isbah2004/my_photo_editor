import 'package:colorfilter_generator/addons.dart';
import 'package:colorfilter_generator/colorfilter_generator.dart';
import 'package:flutter/material.dart';

class AdjustProvider extends ChangeNotifier {
  bool _brightnessVisibility = true;

  bool get brightnessVisibility => _brightnessVisibility;
  bool _saturationVisibility = false;

  bool get saturationVisibility => _saturationVisibility;
  bool _contrastVisibility = false;

  bool get contrastVisibility => _contrastVisibility;
  bool _hueVisibility = false;

  bool get hueVisibility => _hueVisibility;
  bool _sepiaVisibility = false;

  bool get sepiaVisibility => _sepiaVisibility;
  void setBrightnessVisibility() {
    _contrastVisibility = false;
    _hueVisibility = false;
    _saturationVisibility = false;
    _sepiaVisibility = false;
    _brightnessVisibility = true;
    notifyListeners();
  }

  void setSaturationVisibility() {
    _brightnessVisibility = false;
    _contrastVisibility = false;
    _hueVisibility = false;
    _sepiaVisibility = false;
    _saturationVisibility = true;
    notifyListeners();
  }

  void setContrastVisibility() {
    _brightnessVisibility = false;

    _hueVisibility = false;
    _saturationVisibility = false;
    _sepiaVisibility = false;
    _contrastVisibility = true;
    notifyListeners();
  }

  void setHueVisibility() {
    _brightnessVisibility = false;
    _contrastVisibility = false;

    _saturationVisibility = false;
    _sepiaVisibility = false;
    _hueVisibility = true;
    notifyListeners();
  }

  void setSepiaVisibility() {
    _brightnessVisibility = false;
    _contrastVisibility = false;
    _hueVisibility = false;
    _saturationVisibility = false;
    _sepiaVisibility = true;
    notifyListeners();
  }

  double _brightness = 0.0;
  double get brightness => _brightness;
  setBrightness(double value) {
    _brightness = value;
    notifyListeners();
  }

  double _contrast = 0.0;
  double get contrast => _contrast;
  setContrast(double value) {
    _contrast = value;
    notifyListeners();
  }

  double _hue = 0.0;
  double get hue => _hue;
  setHue(double value) {
    _hue = value;
    notifyListeners();
  }

  double _saturation = 0.0;
  double get saturation => _saturation;
  setSaturation(double value) {
    _saturation = value;
    notifyListeners();
  }

  double _sepia = 0.0;
  double get sepia => _sepia;
  setSepia(double value) {
    _sepia = value;
    notifyListeners();
  }

  late ColorFilterGenerator _colorFilterGenerator;
  ColorFilterGenerator get colorFilterGenerator => _colorFilterGenerator;
  adjust({b, c, s, h, se}) {
    _colorFilterGenerator = ColorFilterGenerator(
      filters: [
        ColorFilterAddons.brightness(b ?? brightness),
        ColorFilterAddons.contrast(c ?? contrast),
        ColorFilterAddons.hue(h ?? hue),
        ColorFilterAddons.sepia(se ?? sepia),
        ColorFilterAddons.saturation(s ?? saturation),
      ],
      name: 'Adjust',
    );
  }
}
