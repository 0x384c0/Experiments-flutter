import 'package:flutter/material.dart';

/// [ListTile] that wraps all its views in to card view
abstract class CardTile extends ListTile {
  const CardTile(GestureTapCallback? onTap, {Key? key}) : super(onTap: onTap, key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final Set<MaterialState> states = <MaterialState>{
      if (!enabled || (onTap == null && onLongPress == null)) MaterialState.disabled,
      if (selected) MaterialState.selected,
    };
    final ListTileThemeData tileTheme = ListTileTheme.of(context);
    final MouseCursor effectiveMouseCursor = MaterialStateProperty.resolveAs<MouseCursor?>(mouseCursor, states) ??
        tileTheme.mouseCursor?.resolve(states) ??
        MaterialStateMouseCursor.clickable.resolve(states);
    final cardShape = shape ?? tileTheme.shape ?? const Border();
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        customBorder: cardShape,
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
              shape: cardShape,
              color: _tileBackgroundColor(theme, tileTheme),
            ),
            child: buildItem(context),
          ),
        ),
        // ),
      ),
    );
  }

  Color _tileBackgroundColor(ThemeData theme, ListTileThemeData tileTheme) {
    final Color? color = selected
        ? selectedTileColor ?? tileTheme.selectedTileColor ?? theme.listTileTheme.selectedTileColor
        : tileColor ?? tileTheme.tileColor ?? theme.listTileTheme.tileColor;
    return color ?? Colors.transparent;
  }

  Widget buildItem(BuildContext context);
}