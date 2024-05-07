import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:lindi_sticker_widget/lindi_controller.dart';
import 'package:lindi_sticker_widget/lindi_sticker_widget.dart';
import 'package:my_photo_editor/provider/image_provider.dart';
import 'package:my_photo_editor/provider/text_provider.dart';
import 'package:my_photo_editor/repository/fonts.dart';
import 'package:provider/provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:text_editor/text_editor.dart';

class TextScreen extends StatefulWidget {
  const TextScreen({super.key});

  @override
  State<TextScreen> createState() => _TextScreenState();
}

class _TextScreenState extends State<TextScreen> {
  late AppImageProvider imageProvider;
  ScreenshotController screenshotController = ScreenshotController();
  LindiController lindiController = LindiController();
  @override
  void initState() {
    super.initState();
    imageProvider = Provider.of<AppImageProvider>(context, listen: false);
  }

  // bool showEditor = false;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            centerTitle: true,
           
            actions: [
              Consumer<AppImageProvider>(builder: (context, value, child) {
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
                  return LindiStickerWidget(
                    controller: lindiController,
                    child: Image.memory(value.currentImage!),
                  );
                } else {
                  return const CircularProgressIndicator();
                }
              },
            ),
          ),
          bottomNavigationBar: Container(
            color: Colors.black,
            width: double.infinity,
            height: 70,
            alignment: Alignment.center,
            child: Consumer<TextProvider>(
              builder: (context, value, child) {
                return TextButton(
                  onPressed: () {
                    value.setEditor(true);
                  },
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.add,
                        color: Colors.white,
                      ),
                      Text(
                        'Add Text',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
        Consumer<TextProvider>(
          builder: (context, value, child) {
            if (value.showEditor) {
              return Scaffold(
                backgroundColor: Colors.black54,
                body: SafeArea(
                  child: TextEditor(
                    minFontSize: 10,
                    maxFontSize: 70,
                    fonts: Fonts().list(),
                    textStyle: const TextStyle(color: Colors.white),
                    onEditCompleted: (style, align, text) {
                      if (text.isNotEmpty) {
                        value.setEditor(false);

                        lindiController.addWidget(Text(
                          text,
                          style: style,
                          textAlign: align,
                        ));
                      } else {
                        value.setEditor(false);
                      }
                    },
                  ),
                ),
              );
            } else {
              return const SizedBox();
            }
          },
        )
      ],
    );
  }
}
