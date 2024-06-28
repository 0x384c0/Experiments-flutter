import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutterui_modifiers/flutterui_modifiers.dart';

class ImageFormInput extends StatelessWidget {
  final String? imagePath;
  final VoidCallback onTap;
  final VoidCallback onRemove;

  const ImageFormInput({
    Key? key,
    this.imagePath,
    required this.onTap,
    required this.onRemove,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const size = 130.0;
    return DecoratedBox(
      decoration:
          BoxDecoration(border: Border.fromBorderSide(BorderSide(color: Theme.of(context).colorScheme.primary))),
      child: SizedBox(
        width: size,
        height: size,
        child: Stack(
          alignment: Alignment.bottomRight,
          children: [
            const Center(child: Icon(Icons.image)),
            const Icon(Icons.add).padding(all: 5),
            if (imagePath != null)
              Stack(
                alignment: Alignment.bottomRight,
                children: [
                  Image.file(
                    File(imagePath!),
                    fit: BoxFit.cover,
                    width: size,
                    height: size,
                  ).backgroundColor(Theme.of(context).colorScheme.background),
                  Icon(Icons.clear, color: Theme.of(context).colorScheme.background, size: 32.0)
                      .padding(all: 5)
                      .onTap(onRemove)
                ],
              ),
          ],
        ),
      ),
    ).onTap(onTap);
  }
}