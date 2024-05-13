import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_photo_editor/constants/constants.dart';
import 'package:my_photo_editor/screens/home_screen.dart';
import 'package:my_photo_editor/provider/image_provider.dart';
import 'package:my_photo_editor/reusablecode/reusablefunctions/pick_image.dart';
import 'package:provider/provider.dart';

class PickerScreen extends StatelessWidget {
  const PickerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   centerTitle: true,
      //   title: const Text(
      //     'Photo Editor',
      //     style: TextStyle(
      //       color: Colors.white,
      //     ),
      //   ),
      // ),
      body: Container(
        decoration:  BoxDecoration(
          image: DecorationImage(fit: BoxFit.fill,
            image: AssetImage(Constants.pickerBackground),
          ),
        ),
        child: Center(
          child: Consumer<AppImageProvider>(
            builder: (context, value, index) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image(image: AssetImage(Constants.galleryIcon),),
                  Image(image: AssetImage(Constants.cameraIcon),),
               ],
              );
            },
          ),
        ),
      ),
    );
  }
}
    //  PickImage(source: ImageSource.camera).pickImage(
    //                     onPick: (File? image) {
    //                       if (image != null) {
    //                         value.changeImageFile(image);
    //                         Navigator.push(
    //                           context,
    //                           MaterialPageRoute(
    //                             builder: (context) => const HomeScreen(),
    //                           ),
    //                         );
    //                       }
    //                     },
    //                   );
    //                  PickImage(source: ImageSource.gallery).pickImage(
    //                     onPick: (File? image) {
    //                       if (image != null) {
    //                         value.changeImageFile(image);
    //                         Navigator.push(
    //                           context,
    //                           MaterialPageRoute(
    //                             builder: (context) => const HomeScreen(),
    //                           ),
    //                         );
    //                       }
    //                     },
    //                   );
                  