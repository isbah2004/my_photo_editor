import 'dart:typed_data';

import 'package:crop_image/crop_image.dart';
import 'package:flutter/material.dart';
import 'package:my_photo_editor/provider/crop_provider.dart';
import 'package:my_photo_editor/provider/image_provider.dart';
import 'package:my_photo_editor/reusablecode/reusablewidgets/bottom_button.dart';
import 'package:provider/provider.dart';
import 'dart:ui' as ui;

class CropScreen extends StatefulWidget {
  const CropScreen({super.key});

  @override
  State<CropScreen> createState() => _CropScreenState();
}

class _CropScreenState extends State<CropScreen> {
  late CropController cropController;
  @override
  void initState() {
    super.initState();
    cropController = CropController(
      aspectRatio: null,
      defaultCrop:  const Rect.fromLTRB(0.1, 0.1, 0.9, 0.9),
      
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black45,
      appBar: AppBar(
        actions: [
          Consumer<AppImageProvider>(builder: (context, value, child) {
            return IconButton(
              icon: const Icon(Icons.done),
              color: Colors.white,
              onPressed: () async {
                ui.Image bitMap = await cropController.croppedBitmap();
                ByteData? data =
                    await bitMap.toByteData(format: ui.ImageByteFormat.png);
                Uint8List bytes = data!.buffer.asUint8List();
                value.changeImage(bytes);
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
        child: Consumer<AppImageProvider>(
          builder: (context, value, child) {
            if (value.currentImage != null) {
              return CropImage(
                image: Image.memory(value.currentImage!),
                controller: cropController,
                gridColor: Colors.white,
                gridCornerColor: Colors.white,
                gridCornerSize: 50,
                gridThinWidth: 3,
                gridThickWidth: 6,
                scrimColor: Colors.grey.withOpacity(0.5),
                onCrop: (rect) => debugPrint(rect.toString()),
                minimumImageSize: 50,
                maximumImageSize: 2000,
              );
            } else {
              return const CircularProgressIndicator();
            }
          },
        ),
      ),
      bottomNavigationBar: SizedBox(
        height: 60,
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Consumer<CropProvider>(
            builder: (context, value, child) {
              return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        cropController.rotateLeft();
                      },
                      child: const Padding(
                        padding: EdgeInsets.all(15),
                        child: Icon(
                          Icons.rotate_90_degrees_ccw_outlined,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        cropController.rotateRight();
                      },
                      child: const Padding(
                        padding: EdgeInsets.all(15),
                        child: Icon(
                          Icons.rotate_90_degrees_cw_outlined,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    BottomButton(
                      title: 'Free',
                      onTap: () {
                        value.setFreeVisibility();
                        cropController.aspectRatio = null;
                        cropController.crop =
                            const Rect.fromLTRB(0.1, 0.1, 0.9, 0.9);
                      },
                      setVisibility: value.freeVisibility,
                    ),
                    BottomButton(
                      title: 'Square',
                      onTap: () {
                        value.setSquareVisibility();
                        cropController.aspectRatio = 1.0;
                      },
                      setVisibility: value.squareVisibility,
                    ),
                    BottomButton(
                      title: '1:2',
                      onTap: () {
                        cropController.aspectRatio = 0.5;
                        value.setRatio1Visibility();
                      },
                      setVisibility: value.ratio1Visibility,
                    ),
                    BottomButton(
                      title: '2:1',
                      onTap: () {
                        cropController.aspectRatio = 2.0 / 1;
                        value.setRatio2Visibility();
                      },
                      setVisibility: value.ratio2Visibility,
                    ),
                    BottomButton(
                      title: '16:9',
                      onTap: () {
                        cropController.aspectRatio = 16.0 / 9.0;
                        value.setRatio3Visibility();
                      },
                      setVisibility: value.ratio3Visibility,
                    ),
                    BottomButton(
                      title: '4:3',
                      onTap: () {
                        cropController.aspectRatio = 4.0 / 3.0;
                        value.setRatio4Visibility();
                      },
                      setVisibility: value.ratio4Visibility,
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
