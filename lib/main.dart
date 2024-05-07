import 'package:flutter/material.dart';
import 'package:my_photo_editor/provider/adjust_provider.dart';
import 'package:my_photo_editor/provider/blur_provider.dart';
import 'package:my_photo_editor/provider/crop_provider.dart';
import 'package:my_photo_editor/provider/draw_provider.dart';
import 'package:my_photo_editor/provider/filter_provider.dart';
import 'package:my_photo_editor/provider/fit_provider.dart';
import 'package:my_photo_editor/provider/mask_provider.dart';
import 'package:my_photo_editor/provider/sticker_provider.dart';
import 'package:my_photo_editor/provider/text_provider.dart';
import 'package:my_photo_editor/provider/tint_provider.dart';
import 'package:my_photo_editor/screens/picker_screen.dart';
import 'package:my_photo_editor/provider/image_provider.dart';
import 'package:my_photo_editor/theme/theme_data.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AppImageProvider()),
        ChangeNotifierProvider(create: (context) => AdjustProvider()),
        ChangeNotifierProvider(create: (context) => BlurProvider()),
        ChangeNotifierProvider(create: (context) => CropProvider()),
        ChangeNotifierProvider(create: (context) => DrawProvider()),
        ChangeNotifierProvider(create: (context) => FitProvider()),
        ChangeNotifierProvider(create: (context) => TintProvider()),
        ChangeNotifierProvider(create: (context) => FilterProvider()),
        ChangeNotifierProvider(create: (context) => StickerProvider()),
        ChangeNotifierProvider(create: (context) => TextProvider()),
        ChangeNotifierProvider(create: (context) => MaskProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: AppTheme.defaultTheme,
        title: 'Photo Editor',
        home: const PickerScreen(),
      ),
    ),
  );
}
