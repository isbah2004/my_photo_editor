import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:lindi_sticker_widget/lindi_controller.dart';
import 'package:lindi_sticker_widget/lindi_sticker_widget.dart';
import 'package:my_photo_editor/provider/image_provider.dart';
import 'package:my_photo_editor/repository/stickers.dart';
import 'package:provider/provider.dart';
import 'package:screenshot/screenshot.dart';

class StickerScreen extends StatefulWidget {
  const StickerScreen({super.key});

  @override
  State<StickerScreen> createState() => _StickerScreenState();
}

class _StickerScreenState extends State<StickerScreen> {
  late AppImageProvider imageProvider;
  ScreenshotController screenshotController = ScreenshotController();
  LindiController lindiController = LindiController();
  @override
  void initState() {
    super.initState();
    imageProvider = Provider.of<AppImageProvider>(context, listen: false);
  }

  int index = 0;
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
        height: 80,
        width: double.infinity,
        decoration: const BoxDecoration(color: Colors.black),
        child: SafeArea(
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: stickers.length,
            itemBuilder: (context, index) {
              String sticker = stickers[index];
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 10),
                width: 60,
                height: 60,
                child: InkWell(
                  onTap: () {
                    lindiController.addWidget(
                      Image.asset(sticker),
                    );
                  },
                  child: Image.asset(sticker),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
