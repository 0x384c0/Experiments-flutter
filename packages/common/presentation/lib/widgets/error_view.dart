import 'package:flutter/material.dart';

class ErrorView extends StatelessWidget {
  const ErrorView({
    super.key,
    this.errorDescription,
    this.transparent = true,
    this.refresh,
  });

  final RefreshCallback? refresh;

  final String? errorDescription;

  final bool transparent;

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
        child: Container(
          color: transparent ? null : Theme.of(context).colorScheme.surface,
          alignment: AlignmentDirectional.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                errorDescription?.isNotEmpty == true
                    ? errorDescription!
                    : MaterialLocalizations.of(context).alertDialogLabel,
                textAlign: TextAlign.center,
                style: TextStyle(color: Theme.of(context).colorScheme.error),
              ),
              if (refresh != null)
                TextButton(onPressed: refresh, child: Text(MaterialLocalizations.of(context).continueButtonLabel)),
            ],
          ),
        ),
      );
}
