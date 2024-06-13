import 'package:common_presentation/widgets/alert_dialog.dart';
import 'package:common_presentation/widgets/page_state/page_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

mixin CubitAlertMixin<T> on Cubit<PageState<T>> {
  emitAlertWithText(String text) => emitAlert(alertDialogState: SuccessAlertDialogState(null, text));

  emitAlert({required AlertDialogState alertDialogState}) => emit(state.copyWith(alertDialogState: alertDialogState));

  closeAlert() => emit(state.copyWith(alertDialogState: AlertDialogState.noAlert));
}
