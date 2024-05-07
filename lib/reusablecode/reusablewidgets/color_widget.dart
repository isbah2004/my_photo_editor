import 'package:flutter/material.dart';
import 'package:my_photo_editor/provider/fit_provider.dart';
import 'package:my_photo_editor/provider/image_provider.dart';
import 'package:my_photo_editor/reusablecode/reusablefunctions/image_color_picker.dart';
import 'package:my_photo_editor/reusablecode/reusablefunctions/pixel_color_picker.dart';
import 'package:provider/provider.dart';

class ColorWidget extends StatelessWidget {
  const ColorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.black,
        child: Consumer2<AppImageProvider, FitProvider>(
          builder: (context, value1, value2, child) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  onPressed: () {
                    ColorPicker().show(
                      context,
                      backgroundColor: value1.backgroundColor,
                      onPick: (color) {
                        value1.changeBackgroundColor(color);
                      },
                    );
                  },
                  icon: const Icon(
                    Icons.color_lens_outlined,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    PixelColorImage().show(context,
                        backgroundColor: value1.backgroundColor,
                        image: value1.currentImage, onPick: (color) {
                      value1.changeBackgroundColor(color);
                    });
                  },
                  icon: const Icon(
                    Icons.colorize_outlined,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
              ],
            );
          },
        ));
  }
}
