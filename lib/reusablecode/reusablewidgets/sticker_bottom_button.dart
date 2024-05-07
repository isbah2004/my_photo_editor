import 'package:flutter/material.dart';
import 'package:my_photo_editor/provider/sticker_provider.dart';
import 'package:provider/provider.dart';

class StickerBottomButton extends StatelessWidget {
  final int ind;
  final String icon;
  const StickerBottomButton(
      {super.key, required this.ind, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Consumer<StickerProvider>(
      builder: (context, value, child) {
        return InkWell(
          onTap: () {
            value.setIndex(ind);
          },
          child: Padding(
            padding: const EdgeInsets.only(),
            child: Column(
              children: [
                Container(
                  width: 20,
                  height: 2,
                  decoration: BoxDecoration(
                    color: ind == value.index ? Colors.blue : Colors.white,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 10,
                  ),
                  child: Image.asset(
                    icon,
                    width: 30,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
