import 'package:flutter/material.dart';

/// Class to manage alert via state
/// Must be singleton
class AlertDialogPresenter {
  static final instance = AlertDialogPresenter();

  AlertDialogState? _presentedAlertDialogState;

  onBuild({
    required BuildContext context,
    required AlertDialogState? alertDialogState,
    required VoidCallback onCloseAlert,
  }) {

    final presentedTitle = _presentedAlertDialogState?.getTitle(context);
    final presentedContent = _presentedAlertDialogState?.getContent(context);

    final title = alertDialogState?.getTitle(context);
    final content = alertDialogState?.getContent(context);
    final shouldBePresented = title?.isNotEmpty == true || content?.isNotEmpty == true;
    final isPresented = _presentedAlertDialogState != null;
    final isDifferentState = presentedTitle != title || presentedContent != content;
    final shouldDoNothing = isPresented && !isDifferentState;
    final shouldClose = isPresented && (!shouldBePresented || isDifferentState);
    final shouldPresent = !isPresented && shouldBePresented;

    if (shouldDoNothing) return;

    if (shouldClose) {
      _presentedAlertDialogState = null;
      Navigator.pop(context);
    }

    if (shouldPresent) {
      _presentedAlertDialogState = alertDialogState;
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
          onCloseAlert.call();
          _presentedAlertDialogState = null;
        });
      });
    }
  }
}

abstract class AlertDialogState {
  String? getTitle(BuildContext context);

  String? getContent(BuildContext context);

  static NoAlertDialogState noAlert = NoAlertDialogState();
}

class ErrorAlertDialogState extends AlertDialogState {
  ErrorAlertDialogState(this._title, this._text);

  final String? _title;
  final String? _text;

  @override
  String? getContent(BuildContext context) => _text;

  @override
  String? getTitle(BuildContext context) => _title;
}

class SuccessAlertDialogState extends AlertDialogState {
  SuccessAlertDialogState(this._title, this._text);

  final String? _text;
  final String? _title;

  @override
  String? getContent(BuildContext context) => _text;

  @override
  String? getTitle(BuildContext context) => _title;
}

class NoAlertDialogState extends AlertDialogState {
  @override
  String? getContent(BuildContext context) => null;

  @override
  String? getTitle(BuildContext context) => null;
}
