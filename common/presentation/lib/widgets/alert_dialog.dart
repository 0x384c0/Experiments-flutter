import 'package:flutter/material.dart';

var _isShowingAlert = false;
// TODO: make as module with injections
alertDialog(BuildContext context, StateWithAlert? state, VoidCallback closeAlert) {
  final title = state?.alertDialogState?.getTitle(context);
  final content = state?.alertDialogState?.getContent(context);
  final shouldSHowAlert = title?.isNotEmpty == true || content?.isNotEmpty == true;
  ModalRoute.of(context);
  if (shouldSHowAlert && !_isShowingAlert) {
    _isShowingAlert = true;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: title != null && title.isNotEmpty ? Text(title) : null,
          content: content != null && content.isNotEmpty ? Text(content) : null,
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, MaterialLocalizations.of(context).okButtonLabel),
              child: Text(MaterialLocalizations.of(context).okButtonLabel),
            ),
          ],
        ),
      ).then((value) {
        closeAlert();
        _isShowingAlert = false;
      });
    });
  } else if (_isShowingAlert) {
    Navigator.pop(context, MaterialLocalizations.of(context).okButtonLabel);
    _isShowingAlert = false;
  }
}

abstract class StateWithAlert {
  AlertDialogState? get alertDialogState;

  /// if passing null to [alertDialogState] is impossible, [StateWithAlert.noAlert] can be used to close alerts
  static AlertDialogState noAlert = NoAlertDialogState();
}

abstract class AlertDialogState {
  String? getTitle(BuildContext context);

  String? getContent(BuildContext context);
}

class ErrorAlertDialogState extends AlertDialogState {
  ErrorAlertDialogState(this._text);

  final String? _text;

  @override
  String? getContent(BuildContext context) => _text; //TODO: inject custom error message map from _text

  @override
  String? getTitle(BuildContext context) => ""; //TODO: inject custom title
}

class SuccessAlertDialogState extends AlertDialogState {
  SuccessAlertDialogState(this._text);

  final String? _text;

  @override
  String? getContent(BuildContext context) => _text;

  @override
  String? getTitle(BuildContext context) => null;
}

class NoAlertDialogState extends AlertDialogState {
  @override
  String? getContent(BuildContext context) => null;

  @override
  String? getTitle(BuildContext context) => null;
}
