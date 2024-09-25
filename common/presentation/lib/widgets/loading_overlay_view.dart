import 'package:flutter/cupertino.dart';

import 'loading_indicator.dart';

class LoadingOverlayView extends StatelessWidget {
  final Widget child;
  final bool isLoading;

  const LoadingOverlayView({
    super.key,
    required this.child,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) => Stack(
        children: [
          child,
          Visibility(
            visible: isLoading,
            child: const LoadingIndicator(opacity: 0.5),
          ),
        ],
      );
}
