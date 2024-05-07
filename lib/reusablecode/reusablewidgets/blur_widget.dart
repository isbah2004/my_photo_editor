import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_photo_editor/provider/fit_provider.dart';
import 'package:my_photo_editor/provider/image_provider.dart';
import 'package:my_photo_editor/reusablecode/reusablefunctions/pick_image.dart';
import 'package:provider/provider.dart';

class BlurWidget extends StatelessWidget {
  const BlurWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: Center(
        child: Consumer2<FitProvider, AppImageProvider>(
          builder: (context, value1, value2, child) {
            return Row(
              children: [
                IconButton(
                  onPressed: () {
                    PickImage(source: ImageSource.gallery).pickImage(
                        onPick: (File? image) async {
                      Uint8List backgroundImage = await image!.readAsBytes();
                      value2.changeBackgroundImage(backgroundImage);
                    });
                  },
                  icon: const Icon(
                    Icons.photo_library_outlined,
                    color: Colors.white,
                  ),
                ),
                Expanded(
                  child: Slider(
                    value: value1.blur,
                    onChanged: (level) {
                      value1.setBlur(level);
                    },
                    max: 100,
                    min: 0,
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
