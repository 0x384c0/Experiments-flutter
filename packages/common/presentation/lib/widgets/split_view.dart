import 'package:flutter/material.dart';

class SplitView extends StatefulWidget {
  final Widget left;
  final Widget right;
  final double initialRatio;
  final RangeValues ratioRange;
  final double dividerWidth;
  final double dividerGestureWidth;
  final Color? dividerColor;
  final bool syncRatio;

  const SplitView({
    super.key,
    required this.left,
    required this.right,
    this.initialRatio = 0.6,
    this.ratioRange = const RangeValues(0.2, 0.8),
    this.dividerWidth = 10.0,
    this.dividerGestureWidth = 30.0,
    this.dividerColor,
    this.syncRatio = true,
  });

  @override
  State<SplitView> createState() => _SplitViewState();

  static final ValueNotifier<double?> _globalRatio = ValueNotifier<double?>(null);
}

class _SplitViewState extends State<SplitView> {
  late double _ratio;
  ValueNotifier<double?>? _sharedNotifier;

  @override
  void initState() {
    super.initState();

    if (widget.syncRatio) {
      _sharedNotifier = SplitView._globalRatio;
      if (_sharedNotifier!.value == null) {
        _sharedNotifier!.value = widget.initialRatio.clamp(widget.ratioRange.start, widget.ratioRange.end);
      }
      _ratio = _sharedNotifier!.value!;

      _sharedNotifier!.addListener(_onSharedRatioChanged);
    } else {
      _ratio = widget.initialRatio.clamp(widget.ratioRange.start, widget.ratioRange.end);
    }
  }

  void _onSharedRatioChanged() {
    if (mounted) {
      setState(() {
        _ratio = _sharedNotifier!.value!;
      });
    }
  }

  @override
  void dispose() {
    _sharedNotifier?.removeListener(_onSharedRatioChanged);
    super.dispose();
  }

  void _updateRatio(double newRatio) {
    final clamped = newRatio.clamp(widget.ratioRange.start, widget.ratioRange.end);
    if (widget.syncRatio) {
      _sharedNotifier!.value = clamped;
    } else {
      setState(() {
        _ratio = clamped;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final leftWidth = constraints.maxWidth * _ratio;
        final rightWidth = constraints.maxWidth * (1 - _ratio) - widget.dividerWidth;

        return Stack(
          children: [
            Row(
              children: [
                SizedBox(width: leftWidth, child: widget.left),
                Container(
                  width: widget.dividerWidth,
                  height: double.infinity,
                  color: widget.dividerColor ?? Theme.of(context).colorScheme.outlineVariant,
                  child: const FittedBox(
                    fit: BoxFit.none,
                    child: Icon(Icons.drag_indicator, size: 15),
                  ),
                ),
                SizedBox(width: rightWidth, child: widget.right),
              ],
            ),
            // Overlay for drag gesture
            Positioned(
              left: leftWidth - (widget.dividerGestureWidth - widget.dividerWidth) / 2,
              width: widget.dividerGestureWidth,
              top: 0,
              bottom: 0,
              child: GestureDetector(
                behavior: HitTestBehavior.translucent,
                onHorizontalDragUpdate: (details) {
                  final newRatio = _ratio + details.delta.dx / constraints.maxWidth;
                  _updateRatio(newRatio);
                },
                child: Container(color: Colors.transparent),
              ),
            ),
          ],
        );
      },
    );
  }
}
