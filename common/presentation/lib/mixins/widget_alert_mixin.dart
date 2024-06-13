import 'package:common_presentation/widgets/alert_dialog.dart';
import 'package:flutter/cupertino.dart';

mixin WidgetAlertMixin {
  onBuild(
    BuildContext context,
    AlertDialogState? alertDialogState,
  ) =>
      AlertDialogPresenter.instance.onBuild(
        context: context,
        alertDialogState: alertDialogState,
      );
}
