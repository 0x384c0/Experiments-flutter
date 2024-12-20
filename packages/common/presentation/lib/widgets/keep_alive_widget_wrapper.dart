import 'package:flutter/material.dart';

class KeepAliveWidgetWrapper extends StatefulWidget {
  const KeepAliveWidgetWrapper({
    super.key,
    required this.create,
  });

  final Widget Function(Key) create;

  @override
  State<StatefulWidget> createState() => _KeepAliveWidgetWrapperState();
}

class _KeepAliveWidgetWrapperState extends State<KeepAliveWidgetWrapper>
    with AutomaticKeepAliveClientMixin<KeepAliveWidgetWrapper> {
  final _key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return widget.create(_key);
  }

  @override
  bool get wantKeepAlive => true;
}
