import 'package:flutter/widgets.dart';

/// View that can be placed in [SingleChildScrollView] and it will expand to fill its parent if necessary, like [SliverFillRemaining]
class ScrollColumnExpandable extends StatelessWidget {
  final List<Widget> children;
  final CrossAxisAlignment? crossAxisAlignment;
  final MainAxisAlignment? mainAxisAlignment;
  final VerticalDirection? verticalDirection;
  final TextDirection? textDirection;
  final TextBaseline? textBaseline;

  const ScrollColumnExpandable({
    super.key,
    required this.children,
    this.crossAxisAlignment,
    this.mainAxisAlignment,
    this.verticalDirection,
    this.textDirection,
    this.textBaseline,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraint) {
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraint.maxHeight),
            child: IntrinsicHeight(
              child: Column(
                mainAxisAlignment: mainAxisAlignment ?? MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: crossAxisAlignment ?? CrossAxisAlignment.center,
                verticalDirection: verticalDirection ?? VerticalDirection.down,
                textBaseline: textBaseline,
                textDirection: textDirection,
                children: children,
              ),
            ),
          ),
        );
      },
    );
  }
}
