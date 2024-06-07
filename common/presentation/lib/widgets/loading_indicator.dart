import 'package:flutter/material.dart';

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({super.key});

  @override
  Widget build(BuildContext context) => Semantics(
        label: "loading",
        child: Container(
          alignment: AlignmentDirectional.center,
          color: Theme.of(context).colorScheme.background,
          child: const CircularProgressIndicator(),
        ),
      );
}
