import 'package:flutter/material.dart';

class ReusableSlider extends StatelessWidget {
  final bool? visible;
  final double value,min ,max;
  final void Function(double)? onChanged; 

   const ReusableSlider({
    super.key,
     this.visible,
    required this.value,
    required this.onChanged, required this.min, required this.max,
  });

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: visible ?? true,
      child: Slider(
        label: value.toStringAsFixed(2),
        value: value,
        onChanged: onChanged,
        min:min,
        max: max,
      ),
    );
  }
}
