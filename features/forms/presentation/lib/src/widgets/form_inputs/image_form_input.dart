import 'dart:io';

import 'package:common_presentation/extensions/flutterui_modifiers.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ImageFormInput extends StatelessWidget {
  final String? imagePath;
  final Function(String imagePath) onPick;
  final VoidCallback onRemove;

  ImageFormInput({
    super.key,
    required this.imagePath,
    required this.onPick,
    required this.onRemove,
  });

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
                    fit: BoxFit.fitHeight,
                    width: size,
                    height: size,
                  ).backgroundColor(Theme.of(context).colorScheme.surface),
                  Icon(Icons.clear, color: Theme.of(context).colorScheme.surface, size: 32.0)
                      .padding(all: 5)
                      .onTap(onRemove)
                ],
              ),
          ],
        ),
      ),
    ).onTap(() => _showDialog(context));
  }

  Future _showDialog(BuildContext context) async {
    final locale = AppLocalizations.of(context)!;
    await showDialog(
      context: context,
      builder: (BuildContext context) => Dialog(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                _pickImage(ImageSource.gallery);
              },
              child: Text(locale.forms_gallery),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                _pickImage(ImageSource.camera);
              },
              child: Text(locale.forms_camera),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context),
              style: TextButton.styleFrom(foregroundColor: Theme.of(context).colorScheme.error),
              child: Text(locale.common_cancel),
            ),
          ],
        ),
      ),
    );
  }

  final ImagePicker _picker = ImagePicker();

  _pickImage(ImageSource source) => _picker.pickImage(source: source).then(_mapFile).then(_callback);

  String? _mapFile(XFile? file) => file?.path;

  _callback(String? path) => path?.isNotEmpty == true ? onPick(path!) : null;
}
