import 'package:flutter/material.dart';

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({super.key, required this.backgroundColor});

  final Color backgroundColor;

  @override
  Widget build(BuildContext context) => Semantics(
        label: "loading",
        child: Container(
          alignment: AlignmentDirectional.center,
          color: backgroundColor,
          child: const CircularProgressIndicator(),
        ),
      );
}
