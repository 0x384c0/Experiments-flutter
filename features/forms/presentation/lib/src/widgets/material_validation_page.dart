import 'package:common_presentation/extensions/build_context.dart';
import 'package:features_forms_presentation/l10n/app_localizations.g.dart';
import 'package:features_forms_presentation/src/navigation/navigator.dart';
import 'package:features_forms_presentation/src/validators/email.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:rxdart/rxdart.dart';
import 'package:widgets_modifiers/style/styling_widgets_modifiers.dart';

import 'form_inputs/file_form_input.dart';
import 'form_inputs/image_form_input.dart';
import 'form_inputs/picker_form_input.dart';

class MaterialValidationPage extends StatefulWidget {
  const MaterialValidationPage({super.key});

  @override
  createState() => _MaterialValidationPageState();
}

class _MaterialValidationPageState extends State<MaterialValidationPage> {
  final _formKey = GlobalKey<FormState>();
  late final FormsNavigator _navigator = Modular.get();
  final dropdownMenuEntries = List.generate(5, (i) => DropdownMenuEntry(label: "label $i", value: "value $i"));
  String? _imagePath;

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context)!;
    final commonLocale = context.commonLocalization!;
    return Scaffold(
      appBar: AppBar(title: Text(locale.forms_material_validation)),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ImageFormInput(
                imagePath: _imagePath,
                onImageSelected: (path) => setState(() => _imagePath = path),
                onRemove: () => setState(() => _imagePath = null),
              ).padding(all: 16),
              FileFormInput(
                label: locale.forms_select_file,
                validator: (value) {
                  if (value?.isEmpty == true) return commonLocale.common_empty_field;
                  return null;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: locale.forms_email),
                validator: (value) {
                  if (value?.isEmpty == true) return commonLocale.common_empty_field;
                  if (!emailRegExp.hasMatch(value!)) return commonLocale.common_invalid_field;
                  return null;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: locale.forms_password),
                validator: (value) {
                  if (value?.isEmpty == true) return commonLocale.common_empty_field;
                  return null;
                },
              ),
              LayoutBuilder(
                builder: (context, constraints) => DropdownMenu(
                  dropdownMenuEntries: dropdownMenuEntries,
                  width: constraints.maxWidth,
                  hintText: locale.forms_dropdown_menu,
                  inputDecorationTheme: Theme.of(context).inputDecorationTheme,
                ),
              ),
              PickerFormInput(
                labelText: locale.forms_picker,
                viewHintText: locale.forms_search_hint,
                getSuggestions: _debouncedGetSuggestions,
                validator: (value) {
                  if (value?.isEmpty == true) return commonLocale.common_empty_field;
                  return null;
                },
              ),
              const SizedBox(height: 24),
              ElevatedButton(onPressed: _onSubmit, child: Text(locale.forms_submit)),
            ],
          ).padding(all: 16),
        ),
      ),
    );
  }

  _onSubmit() {
    if (_formKey.currentState!.validate()) _navigator.back();
  }

  Future<Iterable<PickerMenuEntry<int>>> _getSuggestions(String text) async {
    if (text.isEmpty) return [];
    await Future.delayed(const Duration(milliseconds: 500));
    final millisecondsSinceEpoch = DateTime.now().millisecondsSinceEpoch;
    return List.generate(5, (i) => PickerMenuEntry(label: "Label $i $text", value: i + millisecondsSinceEpoch));
  }

  final _suggestionsSubject = PublishSubject<String>();
  late final _suggestionsSubscription =
      _suggestionsSubject.debounceTime(const Duration(milliseconds: 300)).asyncMap(_getSuggestions);

  Future<Iterable<PickerMenuEntry<int>>> _debouncedGetSuggestions(String text) {
    try {
      return _suggestionsSubscription.first;
    } finally {
      _suggestionsSubject.add(text); //TODO: find another way to add item to stream after subscription
    }
  }

  @override
  void dispose() {
    super.dispose();
    _suggestionsSubject.close();
  }
}
