import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lindi_sticker_widget/lindi_controller.dart';
import 'package:lindi_sticker_widget/lindi_sticker_widget.dart';
import 'package:my_photo_editor/provider/draw_provider.dart';
import 'package:my_photo_editor/provider/image_provider.dart';
import 'package:my_photo_editor/reusablecode/reusablefunctions/pixel_color_picker.dart';
import 'package:my_photo_editor/reusablecode/reusablewidgets/bottom_button.dart';
import 'package:my_photo_editor/reusablecode/reusablefunctions/image_color_picker.dart';
import 'package:my_photo_editor/reusablecode/reusablewidgets/reusable_slider.dart';
import 'package:painter/painter.dart';
import 'package:provider/provider.dart';
import 'package:screenshot/screenshot.dart';

class DrawScreen extends StatefulWidget {
  const DrawScreen({super.key});

  @override
  State<DrawScreen> createState() => _DrawScreenState();
}

class _DrawScreenState extends State<DrawScreen> {
  late AppImageProvider imageProvider;
  ScreenshotController screenshotController = ScreenshotController();
  LindiController lindiController = LindiController();
  PainterController painterController = PainterController();
  @override
  void initState() {
    super.initState();
    imageProvider = Provider.of<AppImageProvider>(context, listen: false);
    painterController.backgroundColor = Colors.transparent;
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
                  Uint8List? bytes = await lindiController.saveAsUint8List();
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
        children: [
          Center(
            child: Consumer<AppImageProvider>(
              builder: (context, value, child) {
                if (value.currentImage != null) {
                  return LindiStickerWidget(
                    controller: lindiController,
                    child: Stack(
                      children: [
                        Image.memory(value.currentImage!),
                        Positioned.fill(
                          child: Painter(painterController),
                        ),
                      ],
                    ),
                  );
                } else {
                  return const CircularProgressIndicator();
                }
              },
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: [
                Consumer<DrawProvider>(builder: (context, value, child) {
                 
                  return ReusableSlider(
                    value: value.thickness,
                    onChanged: (level) {
                      value.setPointerThickness(level);
                      painterController.thickness = value.thickness;
                    },
                    min: 0.5,
                    max: 20,
                  );
                })
              ],
            ),
          )
        ],
      ),
      bottomNavigationBar: Container(
        width: double.infinity,
        height: 50,
        color: Colors.black,
        child: SafeArea(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              BottomButton(
                onTap: () {
                  if (!painterController.isEmpty) {
                    painterController.undo();
                  }
                },
                icon: Icons.undo,
                setVisibility: false,
              ),
              BottomButton(
                onTap: () {
                  ColorPicker().show(
                    context,
                    backgroundColor: painterController.drawColor,
                    onPick: (color) {
                   
                        painterController.drawColor = color;
                     
                    },
                  );
                },
                icon: Icons.color_lens_outlined,
                setVisibility: false,
              ),
              BottomButton(
                onTap: () {
                  PixelColorImage().show(
                    context,
                    backgroundColor: painterController.drawColor,
                    image: imageProvider.currentImage,
                    onPick: (color) {
                    
                        painterController.drawColor = color;
                    
                    },
                  );
                },
                icon: Icons.colorize,
                setVisibility: false,
              ),
              BottomButton(
                onTap: () {
                  if (!painterController.isEmpty) {
                    painterController.clear();
                  }
                },
                icon: Icons.delete,
                setVisibility: false,
              ),
              BottomButton(
                onTap: () {
                 
                    painterController.eraseMode = !painterController.eraseMode;
                  
                },
                icon: FontAwesomeIcons.eraser,
                setVisibility: false,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
