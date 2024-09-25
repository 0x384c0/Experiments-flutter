import 'package:flutter/material.dart';

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({
    super.key,
    this.opacity = 1,
  });

  final double opacity;

  @override
  Widget build(BuildContext context) => Semantics(
    label: "loading",
    child: Container(
      alignment: AlignmentDirectional.center,
      color: Theme.of(context).colorScheme.surface.withOpacity(opacity),
      child: const CircularProgressIndicator(),
    ),
  );
}
