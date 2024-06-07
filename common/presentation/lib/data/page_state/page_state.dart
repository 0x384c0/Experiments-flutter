import 'package:common_presentation/widgets/alert_dialog.dart';

abstract class PageState<T> implements StateWithAlert {
  PageState(this.alertDialogState);

  @override
  final AlertDialogState? alertDialogState;

  PageState<T> newWith({T? data}) {
    if (data == null) return PageStateEmptyLoading<T>();
    if (data is List && data.isEmpty) return PageStateEmpty<T>();
    return PageStatePopulated<T>(data: data);
  }

  PageState<T> copyWith({T? data, AlertDialogState? alertDialogState});
}

class PageStateEmpty<T> extends PageState<T> {
  PageStateEmpty({AlertDialogState? alertDialogState}) : super(alertDialogState);

  @override
  PageState<T> copyWith({T? data, AlertDialogState? alertDialogState}) =>
      PageStateEmpty(alertDialogState: alertDialogState ?? this.alertDialogState);
}

class PageStateEmptyLoading<T> extends PageState<T> {
  PageStateEmptyLoading({AlertDialogState? alertDialogState}) : super(alertDialogState);

  @override
  PageState<T> copyWith({T? data, AlertDialogState? alertDialogState}) =>
      PageStateEmptyLoading(alertDialogState: alertDialogState ?? this.alertDialogState);
}

class PageStateEmptyError<T> extends PageState<T> {
  PageStateEmptyError({AlertDialogState? alertDialogState, required this.errorDescription}) : super(alertDialogState);

  final String errorDescription;

  @override
  PageState<T> copyWith({T? data, AlertDialogState? alertDialogState}) => PageStateEmptyError(
      alertDialogState: alertDialogState ?? this.alertDialogState, errorDescription: errorDescription);
}

class PageStatePopulated<T> extends PageState<T> {
  PageStatePopulated({AlertDialogState? alertDialogState, required this.data}) : super(alertDialogState);

  T data;

  @override
  PageState<T> copyWith({T? data, AlertDialogState? alertDialogState}) =>
      PageStatePopulated<T>(alertDialogState: alertDialogState ?? this.alertDialogState, data: data ?? this.data);
}
