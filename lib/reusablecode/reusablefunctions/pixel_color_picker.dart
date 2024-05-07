import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:my_photo_editor/provider/draw_provider.dart';
import 'package:pixel_color_picker/pixel_color_picker.dart';
import 'package:provider/provider.dart';

class PixelColorImage {
  show(BuildContext context,
      {Color? backgroundColor, Uint8List? image, onPick}) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return Consumer<DrawProvider>(builder: (context, value, child) {
          return AlertDialog(
            title: const Text('Move your finger'),
            content: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                PixelColorPicker(
                  child: SizedBox(
                      width: MediaQuery.of(context).size.width / 1.05,
                      height: MediaQuery.of(context).size.height / 1.75,
                      child: Image.memory(
                        image!,
                        fit: BoxFit.contain,
                      )),
                  onChanged: (color) {
                    value.setTempColor(color);
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height / 13,
                  color: value.tempColor,
                )
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  onPick(value.tempColor);
                  Navigator.pop(context);
                },
                child: const Text('Pick'),
              ),
            ],
         
          );
        });
      },
    );
  }
}
