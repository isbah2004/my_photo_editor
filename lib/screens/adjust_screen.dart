import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:my_photo_editor/constants/constants.dart';
import 'package:my_photo_editor/provider/adjust_provider.dart';
import 'package:my_photo_editor/provider/image_provider.dart';
import 'package:my_photo_editor/reusablecode/reusablewidgets/bottom_button.dart';
import 'package:my_photo_editor/reusablecode/reusablewidgets/reusable_slider.dart';
import 'package:provider/provider.dart';
import 'package:screenshot/screenshot.dart';

class AdjustScreen extends StatefulWidget {
  const AdjustScreen({super.key});

  @override
  State<AdjustScreen> createState() => _AdjustScreenState();
}

class _AdjustScreenState extends State<AdjustScreen>
    with SingleTickerProviderStateMixin {
  late AppImageProvider imageProvider;
  late AdjustProvider adjustProvider;
  ScreenshotController screenshotController = ScreenshotController();
  late TransformationController transformationController;
  late AnimationController animationController;
  Animation<Matrix4>? animation;

  @override
  void initState() {
    super.initState();

    imageProvider = Provider.of<AppImageProvider>(context, listen: false);
    adjustProvider = Provider.of<AdjustProvider>(context, listen: false);
    adjustProvider.adjust();
    transformationController = TransformationController();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    )..addListener(() => transformationController.value = animation!.value);
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        actions: [
          Consumer<AppImageProvider>(
            builder: (context, value, child) {
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
            },
          ),
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
            child: Consumer2<AppImageProvider, AdjustProvider>(
              builder: (context, value1, value2, child) {
                return Screenshot(
                  controller: screenshotController,
                  child: ColorFiltered(
                    colorFilter:
                        ColorFilter.matrix(value2.colorFilterGenerator.matrix),
                    child: InteractiveViewer(
                      transformationController: transformationController,
                      minScale: Constants.minZoomScale,
                      maxScale: Constants.maxZoomScale,
                      onInteractionEnd: (details) {
                        resetAnimation();
                      },
                      child: Image.memory(value1.currentImage!),
                    ),
                  ),
                );
              },
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Consumer<AdjustProvider>(
              builder: (context, value, child) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ReusableSlider(
                      visible: value.brightnessVisibility,
                      value: value.brightness,
                      onChanged: (level) {
                        value.setBrightness(level);
                        adjustProvider.adjust(b: value.brightness);
                      },
                      min: -1,
                      max: 1,
                    ),
                    ReusableSlider(
                      visible: value.saturationVisibility,
                      value: value.saturation,
                      onChanged: (level) {
                        value.setSaturation(level);
                        adjustProvider.adjust(s: value.saturation);
                      },
                      min: -1,
                      max: 1,
                    ),
                    ReusableSlider(
                      visible: value.hueVisibility,
                      value: value.hue,
                      onChanged: (level) {
                        value.setHue(level);
                        adjustProvider.adjust(h: value.hue);
                      },
                      min: -1,
                      max: 1,
                    ),
                    ReusableSlider(
                      visible: value.sepiaVisibility,
                      value: value.sepia,
                      onChanged: (level) {
                        value.setSepia(level);
                        adjustProvider.adjust(se: value.sepia);
                      },
                      min: -1,
                      max: 1,
                    ),
                    ReusableSlider(
                      visible: value.contrastVisibility,
                      value: value.contrast,
                      onChanged: (level) {
                        value.setContrast(level);
                        adjustProvider.adjust(c: value.contrast);
                      },
                      max: 1,
                      min: -1,
                    ),
                  ],
                );
              },
            ),
          )
        ],
      ),
      bottomNavigationBar: SizedBox(
        height: 70,
        width: double.infinity,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Consumer<AdjustProvider>(
            builder: (context, value, child) {
              return Row(
                children: [
                  BottomButton(
                    onTap: () {
                      value.setBrightnessVisibility();
                    },
                    icon: Icons.brightness_5_rounded,
                    title: 'Brightness',
                    setVisibility: value.brightnessVisibility,
                  ),
                  BottomButton(
                    onTap: () {
                      value.setSaturationVisibility();
                    },
                    icon: Icons.water_drop,
                    title: 'Saturation',
                    setVisibility: value.saturationVisibility,
                  ),
                  BottomButton(
                    onTap: () {
                      value.setContrastVisibility();
                    },
                    icon: Icons.contrast,
                    title: 'Contrast',
                    setVisibility: value.contrastVisibility,
                  ),
                  BottomButton(
                    onTap: () {
                      value.setHueVisibility();
                    },
                    icon: Icons.filter_tilt_shift,
                    title: 'Hue',
                    setVisibility: value.hueVisibility,
                  ),
                  BottomButton(
                    onTap: () {
                      value.setSepiaVisibility();
                    },
                    icon: Icons.motion_photos_auto,
                    title: 'Sepia',
                    setVisibility: value.sepiaVisibility,
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  resetAnimation() {
    animation = Matrix4Tween(
      begin: transformationController.value,
      end: Matrix4.identity(),
    ).animate(
      CurvedAnimation(parent: animationController, curve: Curves.ease),
    );
    animationController.forward(from: 0);
  }
}
