import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MaskButton extends StatelessWidget {
  final VoidCallback onTap;
  final IconData icon;

  const MaskButton({super.key, required this.onTap, required this.icon});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 15),
        child: FaIcon(
          icon ,
          size: 40,
          color: Colors.white,
        ),
      ),
    );
  }
}
