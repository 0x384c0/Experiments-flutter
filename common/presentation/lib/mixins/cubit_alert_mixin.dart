import 'package:common_presentation/widgets/alert_dialog.dart';
import 'package:common_presentation/widgets/screen_state/bloc_screen_state_mixin.dart';

mixin CubitAlertMixin<T extends StateWithAlert> on BlocScreenStateMixin<T> {
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
