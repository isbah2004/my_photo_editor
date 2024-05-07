import 'package:flutter/material.dart';
import 'package:my_photo_editor/theme/theme_data.dart';

class BottomButton extends StatelessWidget {
  final VoidCallback onTap;

  final IconData? icon;
  final String? title;
  final bool? setVisibility;
  const BottomButton({
    super.key,
    required this.onTap,
    this.icon,
    this.title,
    this.setVisibility,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 10, bottom: 5, top: 5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: setVisibility ?? false
              ? AppTheme.selectedButtonBackground
              : AppTheme.transparent),
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Builder(
                builder: (context) {
                  if (icon != null) {
                    return Icon(
                      icon,
                      color: AppTheme.whiteColor,
                    );
                  } else {
                    return const SizedBox();
                  }
                },
              ),
              Builder(
                builder: (context) {
                  if (title != null) {
                    return Text(
                      title ?? '',
                      style: const TextStyle(
                        color: AppTheme.whiteColor,
                      ),
                    );
                  } else {
                    return const SizedBox();
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
