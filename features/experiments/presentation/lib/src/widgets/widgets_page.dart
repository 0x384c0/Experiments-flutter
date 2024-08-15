import 'dart:ui';

import 'package:features_experiments_presentation/src/utils/data_generators.dart';
import 'package:flutter/material.dart';

class WidgetsPage extends StatefulWidget {
  const WidgetsPage({super.key});

  @override
  State<StatefulWidget> createState() => _WidgetsPageState();
}

class _WidgetsPageState extends State<WidgetsPage> {
  final _statefulWidgetStateKey = GlobalKey<_TestStatefulWidgetState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Widgets")),
      body: SafeArea(
        minimum: const EdgeInsets.only(left: 8, right: 8),
        child: ListView(
          children: [
            _card(_testInheritedWidget()),
            _card(_testStatefulWidget(context), onTap: () => _statefulWidgetStateKey.currentState?.grow()),
            _card(_CustomWidget()),
          ],
        ),
      ),
    );
  }

  _card(Widget child, {GestureTapCallback? onTap}) => Card.filled(
        clipBehavior: Clip.hardEdge,
        child: InkWell(
          onTap: onTap,
          child: Padding(padding: const EdgeInsets.all(8.0), child: child),
        ),
      );

  _testInheritedWidget() {
    final testData = generateRandomString(10);
    return _TestInheritedWidget(
      testData: testData,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Data for InheritedWidget: $testData"),
          _DataFromInheritedWidget(),
        ],
      ),
    );
  }

  _testStatefulWidget(BuildContext context) => _TestStatefulWidget(
        key: _statefulWidgetStateKey,
        color: Theme.of(context).colorScheme.primary,
        child: const Text("Test Stateful Widget"),
      );
}

//region InheritedWidget
class _TestInheritedWidget extends InheritedWidget {
  const _TestInheritedWidget({
    required super.child,
    required this.testData,
  });

  final String testData;

  static _TestInheritedWidget? maybeOf(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<_TestInheritedWidget>();

  @override
  bool updateShouldNotify(_TestInheritedWidget oldWidget) => testData != oldWidget.testData;
}

class _DataFromInheritedWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final testData = _TestInheritedWidget.maybeOf(context)?.testData;
    return Text("Data from InheritedWidget: $testData");
  }
}
//endregion

//region StatefulWidget
class _TestStatefulWidget extends StatefulWidget {
  const _TestStatefulWidget({
    super.key,
    required this.color,
    required this.child,
  });

  final Color color;
  final Widget child;

  @override
  State<_TestStatefulWidget> createState() => _TestStatefulWidgetState();
}

class _TestStatefulWidgetState extends State<_TestStatefulWidget> {
  double _size = 1.0;

  void grow() => setState(() => _size += 0.1);

  @override
  Widget build(BuildContext context) => Container(
        color: widget.color,
        transform: Matrix4.diagonal3Values(_size, _size, 1.0),
        child: widget.child,
      );
}
//endregion

//region Custom widget
class _CustomWidget extends LeafRenderObjectWidget {
  final count = 3;

  @override
  RenderObject createRenderObject(BuildContext context) => _CustomRenderObject()..count = count;
}

class _CustomRenderObject extends RenderBox {
  var _count = 3;

  var _widgetChanged = false;

  set count(int count) {
    _count = count;
    _widgetChanged = true;
    markNeedsLayout();
  }

  @override
  void performLayout() {
    if (!_widgetChanged && hasSize) return;
    _widgetChanged = false;

    size = constraints.constrain(Size(_count * 10, 20));
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    _loadShaderIfNeeded();
    final shader = _program?.fragmentShader();
    if (shader == null) return;
    shader.setFloat(0, size.width);
    shader.setFloat(1, size.height);
    context.canvas.drawPaint(Paint()..shader = shader);
  }

  FragmentProgram? _program;

  void _loadShaderIfNeeded() async {
    if (_program != null) return;
    _program = await FragmentProgram.fromAsset('packages/features_experiments_presentation/shaders/rainbow.frag');
    markNeedsLayout();
  }
}
//endregion
