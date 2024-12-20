import 'package:flutter/cupertino.dart';

import 'loading_indicator.dart';

class LoadingOverlayView extends StatelessWidget {
  final bool isLoading;

  const LoadingOverlayView({
    super.key,
    this.isLoading = true,
  });

  @override
  Widget build(BuildContext context) => Visibility(
        visible: isLoading,
        child: const LoadingIndicator(opacity: 0.5),
      );
}
