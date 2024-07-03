import 'package:features_forms_presentation/src/utils/chips_input_editing_controller.dart';
import 'package:flutter/material.dart';

class PickerFormInput<T> extends StatefulWidget {
  const PickerFormInput({
    super.key,
    required this.labelText,
    required this.viewHintText,
    required this.getSuggestions,
    this.validator,
  });

  final String labelText;
  final String viewHintText;
  final Future<Iterable<PickerMenuEntry<T>>> Function(String text) getSuggestions;
  final FormFieldValidator<List<PickerMenuEntry<T>>>? validator;

  @override
  State<StatefulWidget> createState() => _PickerFormInputState<T>();
}

class _PickerFormInputState<T> extends State<PickerFormInput<T>> {
  final List<PickerMenuEntry<T>> _selection = [];

  late final _textController = ChipsInputEditingController(_selection, _chipBuilder);

  @override
  Widget build(BuildContext context) => SearchAnchor(
        builder: (BuildContext context, SearchController controller) => GestureDetector(
          child: TextFormField(
            controller: _textController,
            validator: (_) => widget.validator?.call(_selection),
            decoration: InputDecoration(labelText: widget.labelText),
            readOnly: true,
            onTap: () => controller.openView(),
            strutStyle: const StrutStyle(fontSize: 15),
            maxLines: null,
          ),
          onTap: () => controller.openView,
        ),
        viewHintText: widget.viewHintText,
        suggestionsBuilder: (BuildContext context, SearchController controller) async {
          final options = (await widget.getSuggestions(controller.text));
          return List.generate(
            options.length,
            (int index) => ListTile(
              title: Text(options.elementAt(index).label),
              onTap: () {
                controller.closeView(null);
                controller.text = "";
                _onEntitySelected(options.elementAt(index));
              },
            ),
          );
        },
      );

  Widget _chipBuilder(BuildContext context, PickerMenuEntry<T> entry) => ToppingInputChip(
        label: entry.label,
        onDeleted: () => _onChipDeleted(entry),
      );

  _onChipDeleted(PickerMenuEntry<T> entry) => setState(() {
        _selection.remove(entry);
        _textController.text = _selection.isEmpty ? "" : " ";
      });

  _onEntitySelected(PickerMenuEntry<T> entity) => setState(() {
        _selection.add(entity);
        if (_selection.isEmpty) {
          _textController.clear();
        } else {
          _textController.text = " ";
        }
      });
}

class PickerMenuEntry<T> {
  PickerMenuEntry({
    required this.value,
    required this.label,
  });

  final T value;
  final String label;
}
