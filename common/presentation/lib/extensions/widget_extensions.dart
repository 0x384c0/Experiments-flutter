import 'package:common_presentation/l10n/app_localizations.g.dart';
import 'package:flutter/material.dart';

extension WidgetExtensions on Widget {
  /// default [error] handler, will show [AlertDialog]
  Future<void> onError(dynamic error, BuildContext context) {
      final locale = AppLocalizations.of(context);
      if (locale == null) return Future.value(null);
      // set up the button
      Widget okButton = TextButton(
        child: Text(locale.common_ok),
        onPressed: () {
          Navigator.pop(context, locale.common_ok);
        },
      );

      // set up the AlertDialog
      AlertDialog alert = AlertDialog(
        title: Text(locale.common_error),
        content: Text(error.toString()),
        actions: [
          okButton,
        ],
      );

      // show the dialog
    return Future.delayed(
        const Duration(),
        () => showDialog(
              context: context,
              builder: (BuildContext context) {
                return alert;
              },
            ));
  }
}
