import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:my_photo_editor/provider/blur_provider.dart';
import 'package:my_photo_editor/provider/image_provider.dart';
import 'package:my_photo_editor/reusablecode/reusablewidgets/bottom_button.dart';
import 'package:my_photo_editor/reusablecode/reusablewidgets/reusable_slider.dart';
import 'package:provider/provider.dart';
import 'package:screenshot/screenshot.dart';

class BlurScreen extends StatefulWidget {
  const BlurScreen({super.key});

  @override
  State<BlurScreen> createState() => _BlurScreenState();
}

class _BlurScreenState extends State<BlurScreen> {
  late AppImageProvider imageProvider;
  ScreenshotController screenshotController = ScreenshotController();

  @override
  void initState() {
    super.initState();
    imageProvider = Provider.of<AppImageProvider>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,

        actions: [
          Consumer<AppImageProvider>(builder: (context, value, child) {
            return IconButton(
              icon: const Icon(Icons.done),
              color: Colors.white,
              onPressed: () async {
                Uint8List? bytes = await screenshotController.capture();
                imageProvider.changeImage(bytes!);
                if (!mounted) return;
                Navigator.pop(context);
              },
            );
          })
        ],
        leading: CloseButton(
          color: Colors.white,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Center(
            child: Consumer2<AppImageProvider, BlurProvider>(
              builder: (context, value1, value2, child) {
                if (value1.currentImage != null) {
                  return Screenshot(
                    controller: screenshotController,
                    child: ImageFiltered(
                      imageFilter: ImageFilter.blur(
                          sigmaX: value2.sigmaX,
                          sigmaY: value2.sigmaY,
                          tileMode: value2.tileMode),
                      child: Image.memory(value1.currentImage!),
                    ),
                  );
                } else {
                  return const CircularProgressIndicator();
                }
              },
            ),
          ),
          Consumer<BlurProvider>(
            builder: (context, value, child) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: ReusableSlider(
                      value: value.sigmaX,
                      onChanged: (level) {
                        value.setSigmaXBlur(level);
                      },
                      min: 0,
                      max: 10,
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: ReusableSlider(
                      value: value.sigmaY,
                      onChanged: (level) {
                        value.setSigmaYBlur(level);
                      },
                      min: 0,
                      max: 10,
                    ),
                  )
                ],
              );
            },
          )
        ],
      ),
      bottomNavigationBar: Container(
        width: double.infinity,
        height: 60,
        color: Colors.black,
        child: SafeArea(child: Consumer<BlurProvider>(
          builder: (context, value, child) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                BottomButton(
                  setVisibility: value.decalVisibility,
                  onTap: () {
                    value.setDecalVisibility();
                  },
                  title: 'Decal',
                ),
                BottomButton(
                  setVisibility: value.clampVisibility,
                  onTap: () {
                    value.setClampVisibility();
                  },
                  title: 'Clamp',
                ),
                BottomButton(
                  setVisibility: value.mirrorVisibility,
                  onTap: () {
                    value.setMirrorVisibility();
                  },
                  title: 'Mirror',
                ),
                BottomButton(
                  onTap: () {
                    value.setRepeatedVisibility();
                  },
                  title: 'Repeated',
                  setVisibility: value.repeatedVisibility,
                ),
              ],
            );
          },
        )),
      ),
    );
  }
}
