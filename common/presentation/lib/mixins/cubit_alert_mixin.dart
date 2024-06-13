import 'package:common_presentation/widgets/alert_dialog.dart';
import 'package:common_presentation/widgets/page_state/cubit_page_state_mixin.dart';

mixin CubitAlertMixin<T extends DataWithAlert> on CubitPageStateMixin<T> {
  emitAlertWithText(String text) => emitAlert(alertDialogState: SuccessAlertDialogState(null, text));

  emitAlert({required AlertDialogState alertDialogState}) {
    final stateData = this.stateData;
    if (stateData != null) {
      emitData(stateData.copyWith(alertDialogState: alertDialogState) as T);
    } else {
      emitData(null);
    }
  }

  closeAlert() => emitAlert(alertDialogState: AlertDialogState.noAlert);
}

abstract interface class DataWithAlert {
  AlertDialogState? get alertDialogState;

  DataWithAlert copyWith({AlertDialogState? alertDialogState});
}
