import 'package:features_experiments_presentation/src/utils/data_generators.dart';
import 'package:flutter/material.dart';

class WidgetsPage extends StatelessWidget {
  const WidgetsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Widgets")),
      body: SafeArea(
        minimum: const EdgeInsets.only(left: 8, right: 8),
        child: ListView(
          children: [
            _card(_testInheritedWidget()),
          ],
        ),
      ),
    );
  }

  _card(Widget child) => Card.filled(child: Container(padding: const EdgeInsets.all(8.0), child: child));

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
}

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
