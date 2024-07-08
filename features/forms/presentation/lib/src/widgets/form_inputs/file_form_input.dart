import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class FileFormInput extends StatefulWidget {
  final String label;
  final ValueChanged<String?>? onFileSelected;
  final ValueChanged<Uint8List?>? onFileSelectedWeb;
  final FormFieldValidator<String?>? validator;

  const FileFormInput({
    super.key,
    required this.label,
    this.onFileSelected,
    this.onFileSelectedWeb,
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

  Future<void> _pickFile(BuildContext context) async {
    final result = await FilePicker.platform.pickFiles(type: FileType.custom, allowedExtensions: allowedExtensions);
    try {
      final path = result?.files.single.path;
      if (path != null) widget.onFileSelected?.call(path);
    } catch (_) {
      final bytes = result?.files.single.bytes;
      if (bytes != null) widget.onFileSelectedWeb?.call(bytes);
    }

    setState(() => _controller.text = result?.files.single.name ?? "");
  }

  _clear() => setState(() {
        _controller.clear();
        widget.onFileSelected?.call(null);
        widget.onFileSelectedWeb?.call(null);
      });
}
