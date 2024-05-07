import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:my_photo_editor/provider/image_provider.dart';
import 'package:my_photo_editor/provider/tint_provider.dart';
import 'package:my_photo_editor/repository/tints.dart';
import 'package:my_photo_editor/reusablecode/reusablewidgets/reusable_slider.dart';
import 'package:provider/provider.dart';
import 'package:screenshot/screenshot.dart';

class TintScreen extends StatefulWidget {
  const TintScreen({super.key});

  @override
  State<TintScreen> createState() => _TintScreenState();
}

class _TintScreenState extends State<TintScreen> {
  late AppImageProvider imageProvider;
  ScreenshotController screenshotController = ScreenshotController();

  late List<Color> tints;
  @override
  void initState() {
    super.initState();
    imageProvider = Provider.of<AppImageProvider>(context, listen: false);

    tints = Tints().tintsList;
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
      body: Stack(
        fit: StackFit.expand,
        children: [
          Center(
            child: Screenshot(
              controller: screenshotController,
              child: Consumer2<AppImageProvider, TintProvider>(
                builder: (context, value1, value2, child) {
                  if (value1.currentImage != null) {
                    return Image.memory(
                      value1.currentImage!,
                      color: tints[value2.index].withOpacity(value2.opacity),
                      colorBlendMode: BlendMode.color,
                    );
                  } else {
                    return const CircularProgressIndicator();
                  }
                },
              ),
            ),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Align(
                alignment: Alignment.bottomCenter,
                child: Consumer<TintProvider>(builder: (context, value, child) {
                  return ReusableSlider(
                    value: value.opacity,
                    onChanged: (level) {
                      value.setOpacity(level);
                    },
                    min: 0.0,
                    max: 1.0,
                  );
                }),
              )
            ],
          ),
        ],
      ),
      bottomNavigationBar: Container(
        width: double.infinity,
        height: 60,
        color: Colors.black,
        child: SafeArea(
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: tints.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, i) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Consumer<TintProvider>(builder: (context, value, child) {
                  return InkWell(
                    onTap: () {
                      value.setIndex(i);
                    },
                    child: CircleAvatar(
                      backgroundColor:
                          value.index == i ? Colors.white : Colors.transparent,
                      child: Padding(
                        padding: const EdgeInsets.all(3),
                        child: CircleAvatar(
                          backgroundColor: tints[i],
                        ),
                      ),
                    ),
                  );
                }),
              );
            },
          ),
        ),
      ),
    );
  }
}
