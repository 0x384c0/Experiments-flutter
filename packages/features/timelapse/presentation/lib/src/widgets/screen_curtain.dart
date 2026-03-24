import 'package:flutter/material.dart';

class ScreenCurtain extends StatelessWidget {
  final double progress;
  final ValueChanged<double> onProgressChanged;

  const ScreenCurtain({
    super.key,
    required this.progress,
    required this.onProgressChanged,
  });

  void _handleDragUpdate(BuildContext context, DragUpdateDetails details) {
    final screenHeight = MediaQuery.of(context).size.height;
    onProgressChanged(progress - (details.delta.dy / screenHeight));
  }

  void _handleDragEnd(DragEndDetails details) {
    onProgressChanged(progress >= 0.5 ? 1.0 : 0.0);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: IgnorePointer(
            ignoring: progress == 0,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onVerticalDragUpdate: (details) =>
                    _handleDragUpdate(context, details),
                onVerticalDragEnd: _handleDragEnd,
                child: FractionallySizedBox(
                  heightFactor: progress,
                  widthFactor: 1,
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    color: Colors.black,
                    child: SafeArea(
                      bottom: false,
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: Container(
                          margin: const EdgeInsets.only(top: 12),
                          width: 48,
                          height: 5,
                          decoration: BoxDecoration(
                            color: Colors.white24,
                            borderRadius: BorderRadius.circular(999),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          child: IgnorePointer(
            ignoring: progress > 0,
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onVerticalDragUpdate: (details) =>
                  _handleDragUpdate(context, details),
              onVerticalDragEnd: _handleDragEnd,
              child: const SizedBox(height: 40),
            ),
          ),
        ),
      ],
    );
  }
}
