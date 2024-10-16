import 'package:flutter/material.dart';

class OnLocaleChangeBuilder extends StatefulWidget {
  final Widget child;

  const OnLocaleChangeBuilder({required this.child, super.key});

  @override
  createState() => _OnLocaleChangeBuilderState();
}

class _OnLocaleChangeBuilderState extends State<OnLocaleChangeBuilder> {
  Locale? currentLocale;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (Localizations.localeOf(context) != currentLocale) {
      currentLocale = Localizations.localeOf(context);
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return KeyedSubtree(
      key: ValueKey(currentLocale),
      child: widget.child,
    );
  }
}
