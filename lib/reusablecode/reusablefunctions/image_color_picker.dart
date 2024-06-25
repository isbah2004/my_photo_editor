import 'package:flutter/material.dart';
import 'package:flutter_circle_color_picker/flutter_circle_color_picker.dart';
import 'package:my_photo_editor/provider/draw_provider.dart';
import 'package:my_photo_editor/theme/theme_data.dart';
import 'package:provider/provider.dart';

class ColorPicker {
  show(BuildContext context, {Color? backgroundColor, onPick}) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return Consumer<DrawProvider>(
          builder: (context, value, index) {
            return AlertDialog(
              backgroundColor: AppTheme.blackColor,
              shadowColor: AppTheme.blackColor,
              title: Text(
                'Pick a color',
                style: AppTheme.bodyLarge,
              ),
              content: CircleColorPicker(
                onChanged: (color) {
                  value.setTempColor(color);
                },
                size: const Size(240, 240),
                strokeWidth: 4,
                thumbSize: 36,
                textStyle: AppTheme.bodyLarge,
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    onPick(value.tempColor);

                    Navigator.pop(context);
                  },
                  child: const Text(
                    'Got it',
                    style: TextStyle(
                      color: AppTheme.whiteColor,
                    ),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
