import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerLoadingView extends StatelessWidget {
  final TextStyle? style;
  final int lines;

  const ShimmerLoadingView({
    super.key,
    this.style,
    this.lines = 1,
  });

  @override
  Widget build(BuildContext context) {
    final containerHeight = style?.fontSize ?? 16.0;
    final spacing = containerHeight * 0.6; // Adjusted spacing between lines

    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: List.generate(
          lines,
          (index) => Padding(
            padding: EdgeInsets.only(bottom: index < lines - 1 ? spacing : 0),
            child: Container(
              height: containerHeight,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
