import 'package:flutter/material.dart';
import 'package:my_photo_editor/provider/image_provider.dart';
import 'package:my_photo_editor/reusablecode/reusablewidgets/bottom_home_button.dart';
import 'package:my_photo_editor/screens/adjust_screen.dart';
import 'package:my_photo_editor/screens/crop_screen.dart';
import 'package:my_photo_editor/screens/blur_screen.dart';
import 'package:my_photo_editor/screens/draw_screen.dart';
import 'package:my_photo_editor/screens/filter_screen.dart';
import 'package:my_photo_editor/screens/fit_screen.dart';
import 'package:my_photo_editor/screens/tint_screen.dart';
import 'package:my_photo_editor/screens/sticker_screen.dart';
import 'package:my_photo_editor/screens/text_screen.dart';
import 'package:my_photo_editor/screens/mask_screen.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          iconSize: 30,
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.home_rounded,
            color: Colors.white,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {},
            child: const Text(
              'Done',
              style: TextStyle(color: Colors.white, fontSize: 15),
            ),
          ),
        ],
      ),
      body: Center(
        child: Consumer<AppImageProvider>(
          builder: (context, value, child) {
            return Image.memory(value.currentImage!);
          },
        ),
      ),
      bottomNavigationBar: SizedBox(
        height: 70,
        width: double.infinity,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              BottomHomeButton(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AdjustScreen(),
                    ),
                  );
                },
                icon: Icons.tune,
                title: 'Adjust',
              ),
              BottomHomeButton(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const BlurScreen(),
                    ),
                  );
                },
                icon: Icons.blur_circular,
                title: 'Blur',
              ),
              BottomHomeButton(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const CropScreen(),
                    ),
                  );
                },
                icon: Icons.crop,
                title: 'Crop',
              ),
              BottomHomeButton(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const DrawScreen(),
                    ),
                  );
                },
                icon: Icons.draw_outlined,
                title: 'Draw',
              ),
              BottomHomeButton(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const FilterScreen(),
                    ),
                  );
                },
                icon: Icons.filter,
                title: 'Filter',
              ),
              BottomHomeButton(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const FitScreen(),
                    ),
                  );
                },
                icon: Icons.fit_screen,
                title: 'Fit',
              ),
              BottomHomeButton(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const MaskScreen(),
                    ),
                  );
                },
                icon: Icons.star_border,
                title: 'Mask',
              ),
              BottomHomeButton(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const StickerScreen(),
                    ),
                  );
                },
                icon: Icons.emoji_emotions_outlined,
                title: 'Stickers',
              ),
              BottomHomeButton(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const TextScreen(),
                    ),
                  );
                },
                icon: Icons.text_fields_rounded,
                title: 'Text',
              ),
              BottomHomeButton(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const TintScreen(),
                    ),
                  );
                },
                icon: Icons.border_color_outlined,
                title: 'Tint',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
