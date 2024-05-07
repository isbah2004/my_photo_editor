import 'package:flutter/material.dart';
import 'package:my_photo_editor/theme/theme_data.dart';

class BottomHomeButton extends StatelessWidget {
  final VoidCallback onTap;

  final IconData icon;
  final String title;

  const BottomHomeButton({
    super.key,
    required this.onTap,
    required this.icon,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Icon(
              icon,
              color: AppTheme.whiteColor,
            ),
            Text(
              title ,
              style: const TextStyle(
                color: AppTheme.whiteColor,
              ),
            )
          ],
        ),
      ),
    );
  }
}
