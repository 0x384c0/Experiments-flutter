import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// if parent context does not contain required bloc of [T] will [create] this bloc
/// used for embedded widgets
class OptionalBlocProvider<T extends Cubit<Object>> extends StatelessWidget {
  final T Function(BuildContext context) create;
  final Widget child;

  const OptionalBlocProvider({
    super.key,
    required this.create,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final existingBloc = context.read<T?>();

    if (existingBloc != null) {
      return child;
    }

    return BlocProvider<T>(
      create: create,
      child: child,
    );
  }
}
