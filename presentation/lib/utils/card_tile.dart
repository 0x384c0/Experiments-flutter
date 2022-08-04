
import 'package:flutter/material.dart';

abstract class CardTile extends ListTile {
  const CardTile(GestureTapCallback? onTap, {Key? key}) : super(onTap:onTap, key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final Set<MaterialState> states = <MaterialState>{
      if (!enabled || (onTap == null && onLongPress == null))
        MaterialState.disabled,
      if (selected) MaterialState.selected,
    };
    final ListTileThemeData tileTheme = ListTileTheme.of(context);
    final MouseCursor effectiveMouseCursor =
        MaterialStateProperty.resolveAs<MouseCursor?>(mouseCursor, states) ??
            tileTheme.mouseCursor?.resolve(states) ??
            MaterialStateMouseCursor.clickable.resolve(states);

    const EdgeInsets defaultContentPadding =
    EdgeInsets.symmetric(horizontal: 16.0);
    final TextDirection textDirection = Directionality.of(context);
    final EdgeInsets resolvedContentPadding =
        contentPadding?.resolve(textDirection) ??
            tileTheme.contentPadding?.resolve(textDirection) ??
            defaultContentPadding;
    return Card(
        child: InkWell(
      customBorder: shape ?? tileTheme.shape,
      onTap: enabled ? onTap : null,
      onLongPress: enabled ? onLongPress : null,
      mouseCursor: effectiveMouseCursor,
      canRequestFocus: enabled,
      focusNode: focusNode,
      focusColor: focusColor,
      hoverColor: hoverColor,
      autofocus: autofocus,
      enableFeedback: enableFeedback ?? tileTheme.enableFeedback ?? true,
      child: Semantics(
        selected: selected,
        enabled: enabled,
        child: Ink(
          decoration: ShapeDecoration(
            shape: shape ?? tileTheme.shape ?? const Border(),
            color: _tileBackgroundColor(theme, tileTheme),
          ),
          child: SafeArea(
            top: false,
            bottom: false,
            minimum: resolvedContentPadding,
            child: buildItem(context),
          ),
        ),
      ),
    ));
  }

  Color _tileBackgroundColor(ThemeData theme, ListTileThemeData tileTheme) {
    final Color? color = selected
        ? selectedTileColor ??
        tileTheme.selectedTileColor ??
        theme.listTileTheme.selectedTileColor
        : tileColor ?? tileTheme.tileColor ?? theme.listTileTheme.tileColor;
    return color ?? Colors.transparent;
  }

  Widget buildItem(BuildContext context);
}