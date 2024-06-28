import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class FileFormInput extends StatelessWidget {
  static const allowedExtensions = [
    "tiff",
    "jpeg",
    "bmp",
    "gif",
    "png",
    "pdf",
    "doc",
    "docx",
    "rtf",
    "odt",
    "txt",
    "html"
  ];
  final String label;
  final String selectedFilePath;
  final ValueChanged<String> onFileSelected;

  const FileFormInput({
    Key? key,
    required this.label,
    required this.selectedFilePath,
    required this.onFileSelected,
  }) : super(key: key);

  Future<void> _pickFile(BuildContext context) async {
    final result = await FilePicker.platform.pickFiles(type: FileType.custom, allowedExtensions: allowedExtensions);
    final path = result?.files.single.path;

    if (path != null) {
      onFileSelected(path);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(label),
        const SizedBox(height: 8),
        InkWell(
            onTap: () => _pickFile(context),
            child: TextFormField(
              initialValue: selectedFilePath.split(Platform.pathSeparator).last,
              readOnly: true,
              onTap: () {
                _pickFile(context);
              },
            )),
        const SizedBox(height: 16),
      ],
    );
  }
}
