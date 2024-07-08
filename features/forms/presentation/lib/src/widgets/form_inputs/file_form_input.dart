import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class FileFormInput extends StatefulWidget {
  final String label;
  final ValueChanged<String?> onFileSelected;
  final FormFieldValidator<String?>? validator;

  const FileFormInput({
    super.key,
    required this.label,
    required this.onFileSelected,
    this.validator,
  });

  @override
  State<StatefulWidget> createState() => _FileFormInputState();
}

class _FileFormInputState extends State<FileFormInput> {
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

  late final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _pickFile(context),
      child: TextFormField(
        controller: _controller,
        readOnly: true,
        decoration: InputDecoration(
          labelText: widget.label,
          suffixIcon: _controller.text.isNotEmpty ? IconButton(onPressed: _clear, icon: const Icon(Icons.clear)) : null,
        ),
        validator: widget.validator,
        onTap: () => _pickFile(context),
      ),
    );
  }

  String? _getFileName(String? path) => path?.split(Platform.pathSeparator).last;

  Future<void> _pickFile(BuildContext context) async {
    final result = await FilePicker.platform.pickFiles(type: FileType.custom, allowedExtensions: allowedExtensions);
    final path = result?.files.single.path;

    if (path != null) {
      widget.onFileSelected(path);
      setState(() {
        _controller.text = _getFileName(path) ?? "";
      });
    }
  }

  _clear() => setState(() {
        _controller.clear();
        widget.onFileSelected(null);
      });
}
