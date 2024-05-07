import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:lindi_sticker_widget/lindi_controller.dart';
import 'package:my_photo_editor/provider/image_provider.dart';
import 'package:my_photo_editor/provider/mask_provider.dart';
import 'package:my_photo_editor/repository/blend_mode.dart';
import 'package:my_photo_editor/repository/shapes.dart';
import 'package:my_photo_editor/reusablecode/reusablewidgets/gesture_detector_widget.dart';
import 'package:my_photo_editor/reusablecode/reusablewidgets/mask_button.dart';
import 'package:provider/provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:widget_mask/widget_mask.dart';

class MaskScreen extends StatefulWidget {
  const MaskScreen({super.key});

  @override
  State<MaskScreen> createState() => _MaskScreenState();
}

class _MaskScreenState extends State<MaskScreen> {
  late AppImageProvider imageProvider;
  ScreenshotController screenshotController = ScreenshotController();
  LindiController lindiController = LindiController();
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
          )
        ],
        leading: CloseButton(
          color: Colors.white,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
         centerTitle: true,
      ),
      body: Center(
        child: Consumer2<AppImageProvider, MaskProvider>(
          builder: (context, value1, value2, child) {
            if (value1.currentImage != null) {
              return Screenshot(
                controller: screenshotController,
                child: WidgetMask(
                  childSaveLayer: true,
                  blendMode: value2.blendMode,
                  mask: Stack(
                    children: [
                      Container(
                        color: Colors.black.withOpacity(0.4),
                      ),
                      GestureDetectorWidget(
                        child: Icon(
                          value2.maskIcon,
                          size: 250,
                          color: Colors.white.withOpacity(0.7),
                        ),
                      ),
                    ],
                  ),
                  child: Image.memory(value1.currentImage!),
                ),
              );
            } else {
              return const CircularProgressIndicator();
            }
          },
        ),
      ),
      bottomNavigationBar: Container(
        height: 120,
        width: double.infinity,
        decoration: const BoxDecoration(color: Colors.black),
        child: SafeArea(
          child: Consumer<MaskProvider>(
            builder: (context, value, child) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      for (int i = 0;
                          i < BlendModeName().list().length;
                          i++)
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: InkWell(
                            onTap: () {
                              value.setBlendMode(BlendModes().list()[i]);
                            },
                            child: Text(
                              BlendModeName().list()[i],
                              style: const TextStyle(color: Colors.blue),
                            ),
                          ),
                        ),
                    ],
                  ),
                  SingleChildScrollView(scrollDirection: Axis.horizontal,
                    child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        for (int i = 0; i < Shapes().list().length; i++)
                          MaskButton(
                            onTap: () {
                              value.setMaskIcon(Shapes().list()[i]);
                            },
                            icon: Shapes().list()[i],
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
