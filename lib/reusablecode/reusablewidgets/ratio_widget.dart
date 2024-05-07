import 'package:flutter/material.dart';
import 'package:my_photo_editor/provider/fit_provider.dart';
import 'package:provider/provider.dart';

class RatioWidget extends StatelessWidget {
  const RatioWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(color: Colors.black),
      child: Consumer<FitProvider>(
        builder: (context, value, child) {
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () {
                    value.setAspectRatio(1, 1);
                  },
                  child: const Text(
                    '1:1',
                    style: TextStyle(
                      color: Colors.blue,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    value.setAspectRatio(2, 1);
                  },
                  child: const Text(
                    '2:1',
                    style: TextStyle(
                      color: Colors.blue,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    value.setAspectRatio(1, 2);
                  },
                  child: const Text(
                    '1:2',
                    style: TextStyle(
                      color: Colors.blue,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    value.setAspectRatio(4, 3);
                  },
                  child: const Text(
                    '4:3',
                    style: TextStyle(
                      color: Colors.blue,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    value.setAspectRatio(3, 4);
                  },
                  child: const Text(
                    '3:4',
                    style: TextStyle(
                      color: Colors.blue,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    value.setAspectRatio(16, 9);
                  },
                  child: const Text(
                    '16:9',
                    style: TextStyle(
                      color: Colors.blue,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    value.setAspectRatio(9, 16);
                  },
                  child: const Text(
                    '9:16',
                    style: TextStyle(
                      color: Colors.blue,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
