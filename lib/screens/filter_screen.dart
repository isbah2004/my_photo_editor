import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:my_photo_editor/provider/filter_provider.dart';
import 'package:my_photo_editor/provider/image_provider.dart';
import 'package:my_photo_editor/repository/fliters.dart';
import 'package:provider/provider.dart';
import 'package:screenshot/screenshot.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({super.key});

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
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
      backgroundColor: Colors.black,
      appBar: AppBar(
        leading: CloseButton(
          color: Colors.white,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.black,
       
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
        ],  ),
      body: Center(
        child: Consumer2<AppImageProvider, FilterProvider>(
          builder: (context, value1, value2, child) {
            return Screenshot(
              controller: screenshotController,
              child: ColorFiltered(
                colorFilter: ColorFilter.matrix(value2.currentMatrix),
                child: Image.memory(value1.currentImage!),
              ),
            );
          },
        ),
      ),
      bottomNavigationBar: SizedBox(
        width: 50,
        height: 80,
        child: Consumer2<AppImageProvider, FilterProvider>(
          builder: (context, value1, value2, index) {
            return ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: colorFilterMatrix.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.all(5),
                  decoration: const BoxDecoration(color: Colors.white),
                  width: 80,
                  child: FittedBox(
                    fit: BoxFit.fill,
                    child: InkWell(
                      onTap: () {
                        value2.setCurrentMatrix(index);
                      },
                      child: ColorFiltered(
                        colorFilter:
                            ColorFilter.matrix(colorFilterMatrix[index]),
                        child: Image.memory(value1.currentImage!),
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
