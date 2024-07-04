import 'package:features_forms_presentation/src/utils/chips_input_editing_controller.dart';
import 'package:features_forms_presentation/src/widgets/topping_input_chip.dart';
import 'package:flutter/material.dart';

class PickerFormInput<T> extends StatefulWidget {
  const PickerFormInput({
    super.key,
    required this.labelText,
    required this.viewHintText,
    required this.getSuggestions,
    this.listItemBuilder,
    this.chipBuilder,
    this.chipSeparator = const SizedBox(width: 6),
    this.validator,
  });

  final String labelText;
  final String viewHintText;
  final Future<Iterable<PickerMenuEntry<T>>> Function(String text) getSuggestions;
  final Function(PickerMenuEntry<T> entry, GestureTapCallback onTap)? listItemBuilder;
  final Widget Function(PickerMenuEntry<T> entry, Function() onChipDeleted)? chipBuilder;
  final Widget chipSeparator;
  final FormFieldValidator<List<PickerMenuEntry<T>>>? validator;

  @override
  State<StatefulWidget> createState() => _PickerFormInputState<T>();
}

class _PickerFormInputState<T> extends State<PickerFormInput<T>> {
  final List<PickerMenuEntry<T>> _selection = [];

  late final _textController = ChipsInputEditingController(
    values: _selection,
    chipBuilder: _chipBuilder,
    separator: widget.chipSeparator,
  );

  @override
  Widget build(BuildContext context) => SearchAnchor(
        builder: (BuildContext context, SearchController controller) => GestureDetector(
          onTap: controller.openView,
          child: TextFormField(
            controller: _textController,
            validator: (_) => widget.validator?.call(_selection),
            decoration: InputDecoration(labelText: widget.labelText),
            readOnly: true,
            onTap: controller.openView,
            strutStyle: const StrutStyle(fontSize: 15),
            maxLines: null,
          ),
        ),
        viewHintText: widget.viewHintText,
        suggestionsBuilder: (BuildContext context, SearchController controller) async {
          final suggestions = (await widget.getSuggestions(controller.text));
          return List.generate(
            suggestions.length,
            (int index) => (widget.listItemBuilder ?? _defaultListItemBuilder).call(
              suggestions.elementAt(index),
              () {
                controller.closeView(null);
                controller.clear();
                _onEntitySelected(suggestions.elementAt(index));
              },
            ),
          );
        },
      );

  Widget _chipBuilder(BuildContext context, PickerMenuEntry<T> entry) =>
      (widget.chipBuilder ?? _defaultChipBuilder).call(entry, () => _onChipDeleted(entry));

  _onChipDeleted(PickerMenuEntry<T> entry) => setState(() {
        _selection.remove(entry);
        _textController.updateValues(_selection);
      });

  _onEntitySelected(PickerMenuEntry<T> entry) => setState(() {
        _selection.add(entry);
        _textController.updateValues(_selection);
      });

  Widget _defaultChipBuilder(PickerMenuEntry<T> entry, Function() onChipDeleted) =>
      ToppingInputChip(label: entry.label, onDeleted: onChipDeleted);

  Widget _defaultListItemBuilder(PickerMenuEntry<T> entry, GestureTapCallback onTap) => ListTile(
        title: Text(entry.label),
        onTap: onTap,
      );
}

class PickerMenuEntry<T> {
  PickerMenuEntry({
    required this.value,
    required this.label,
  });

  final T value;
  final String label;
}
