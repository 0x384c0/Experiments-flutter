import 'package:common_presentation/widgets/alert_dialog.dart';
import 'package:flutter/cupertino.dart';

import 'cubit_alert_mixin.dart';

mixin WidgetAlertMixin {
  onBuild(
    BuildContext context,
    CubitAlertMixin cubit,
  ) =>
      AlertDialogPresenter.instance.onBuild(
        context: context,
        alertDialogState: cubit.stateData?.alertDialogState,
        onCloseAlert: cubit.closeAlert,
      );
}
