import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

extension WidgetExtensions on Widget {
  Future<void>  onError(dynamic error, BuildContext context) {
      final locale = AppLocalizations.of(context);
      if (locale == null) return Future.value(null);
      // set up the button
      Widget okButton = TextButton(
        child: Text(locale.button_ok),
        onPressed: () {
          Navigator.pop(context, locale.button_ok);
        },
      );

      // set up the AlertDialog
      AlertDialog alert = AlertDialog(
        title: Text(locale.alert_error_title),
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
