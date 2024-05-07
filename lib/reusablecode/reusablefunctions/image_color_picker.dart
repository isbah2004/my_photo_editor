import 'package:flutter/material.dart';
import 'package:flutter_circle_color_picker/flutter_circle_color_picker.dart';
import 'package:my_photo_editor/provider/draw_provider.dart';
import 'package:provider/provider.dart';

class ColorPicker {
  show(BuildContext context, {Color? backgroundColor, onPick}) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return Consumer<DrawProvider>(
          builder: (context, value, index) {
            return AlertDialog(
              title: const Text('Pick a color'),
              content: CircleColorPicker(
                onChanged: (color) {
                  value.setTempColor(color);
                },
                size: const Size(240, 240),
                strokeWidth: 4,
                thumbSize: 36,
              ),
              actions: [
                ElevatedButton(
                  onPressed: () {
                    onPick(value.tempColor);

                    Navigator.pop(context);
                  },
                  child: const Text('Got it'),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
