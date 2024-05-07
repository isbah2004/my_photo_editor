import 'dart:typed_data';
import 'package:blur/blur.dart';
import 'package:flutter/material.dart';
import 'package:my_photo_editor/provider/fit_provider.dart';
import 'package:my_photo_editor/provider/image_provider.dart';
import 'package:my_photo_editor/reusablecode/reusablewidgets/blur_widget.dart';
import 'package:my_photo_editor/reusablecode/reusablewidgets/bottom_button.dart';
import 'package:my_photo_editor/reusablecode/reusablewidgets/color_widget.dart';
import 'package:my_photo_editor/reusablecode/reusablewidgets/ratio_widget.dart';
import 'package:provider/provider.dart';
import 'package:screenshot/screenshot.dart';

class FitScreen extends StatefulWidget {
  const FitScreen({super.key});

  @override
  State<FitScreen> createState() => _FitScreenState();
}

class _FitScreenState extends State<FitScreen> {
  late AppImageProvider imageProvider;
  Uint8List? currentImage;
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
      body: Center(
        child: Consumer2<AppImageProvider, FitProvider>(
          builder: (context, value1, value2, child) {
            if (value1.currentImage != null) {
              currentImage = value1.currentImage;
              value1.backgroundImage ??= value1.currentImage;
              return AspectRatio(
                aspectRatio: value2.x / value2.y,
                child: Screenshot(
                  controller: screenshotController,
                  child: Stack(
                    children: [
                      if (value2.showColorBackground)
                        Container(
                          color: value1.backgroundColor,
                        ),
                      if (value2.showBlurBackground)
                        Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: MemoryImage(value1.backgroundImage!),
                            ),
                          ),
                        ).blurred(blur: value2.blur, colorOpacity: 0),
                      Center(
                        child: Image.memory(value1.currentImage!),
                      ),
                    ],
                  ),
                ),
              );
            } else {
              return Center(
                child: Image.memory(value1.backgroundImage!),
              );
            }
          },
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: SizedBox(
          height: 140,
          width: double.infinity,
          child: Consumer<FitProvider>(
            builder: (context, value, child) {
              return Column(
                children: [
                  Expanded(
                    child: Stack(
                      children: [
                        if (value.showRatio) const RatioWidget(),
                        if (value.showBlur) const BlurWidget(),
                        if (value.showColor) const ColorWidget(),
                      ],
                    ),
                  ),
                  Expanded(
                    
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        BottomButton(
                          onTap: () {
                            value.setShowRatio();
                          },
                          icon: Icons.aspect_ratio,
                          title: 'Ratio',
                        ),
                        BottomButton(
                          onTap: () {
                            value.setShowBlur();
                            value.setShowBlurBackground();
                          },
                          icon: Icons.blur_linear_outlined,
                          title: 'Blur',
                        ),
                        BottomButton(
                          onTap: () {
                            value.setShowColor();
                            value.setShowColorBackground();
                          },
                          icon: Icons.color_lens_outlined,
                          title: 'Color',
                        ),
                       ],
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
