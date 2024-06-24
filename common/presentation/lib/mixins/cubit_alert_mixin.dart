import 'package:common_presentation/widgets/alert_dialog.dart';
import 'package:common_presentation/widgets/page_state/bloc_page_state_mixin.dart';

mixin CubitAlertMixin<T extends StateWithAlert> on BlocPageStateMixin<T> {
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

abstract interface class StateWithAlert {
  AlertDialogState? get alertDialogState;

  StateWithAlert copyWith({AlertDialogState? alertDialogState});
}
