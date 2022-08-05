import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

extension WidgetExtensions on Widget {
  void onError(dynamic error, BuildContext context) {
    final locale = AppLocalizations.of(context);
    if (locale == null) return;
    // set up the button
    Widget okButton = TextButton(
      child: Text(locale.button_ok),
      onPressed: () {
        Navigator.of(context, rootNavigator: true).pop();
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
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
