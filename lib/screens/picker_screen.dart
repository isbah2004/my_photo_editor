import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_photo_editor/constants/constants.dart';
import 'package:my_photo_editor/provider/image_provider.dart';
import 'package:my_photo_editor/reusablecode/reusablefunctions/pick_image.dart';
import 'package:my_photo_editor/screens/home_screen.dart';
import 'package:my_photo_editor/theme/theme_data.dart';
import 'package:provider/provider.dart';

class PickerScreen extends StatelessWidget {
  const PickerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: AppTheme.transparent,
      //   foregroundColor: AppTheme.transparent,
      //   surfaceTintColor: AppTheme.transparent,
      //   shadowColor: AppTheme.transparent,
      //   title: Text(
      //     'Photo Editor',
      //     style: AppTheme.displayLarge,
      //   ),
      // ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.fill,
            image: AssetImage(Constants.pickerBackground),
          ),
        ),
        child: Center(
          child: Consumer<AppImageProvider>(
            builder: (context, value, index) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      PickImage(source: ImageSource.gallery).pickImage(
                        onPick: (File? image) {
                          if (image != null) {
                            value.changeImageFile(image);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const HomeScreen(),
                              ),
                            );
                          }
                        },
                      );
                    },
                    child: const Image(
                      fit: BoxFit.contain,
                      height: 100,
                      width: 100,
                      color: AppTheme.whiteColor,
                      image: AssetImage(Constants.galleryIcon),
                    ),
                  ),
                  const SizedBox(
                    width: 50,
                  ),
                  InkWell(
                    onTap: () {
                      PickImage(source: ImageSource.camera).pickImage(
                        onPick: (File? image) {
                          if (image != null) {
                            value.changeImageFile(image);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const HomeScreen(),
                              ),
                            );
                          }
                        },
                      );
                    },
                    child: const Image(
                      height: 100,
                      width: 100,
                      color: AppTheme.whiteColor,
                      fit: BoxFit.contain,
                      image: AssetImage(Constants.cameraIcon),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
