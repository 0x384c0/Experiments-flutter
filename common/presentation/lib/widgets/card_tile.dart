import 'package:flutter/material.dart';

/// [ListTile] that wraps all its views in to card view
abstract class CardTile extends ListTile {
  const CardTile(GestureTapCallback? onTap, {super.key}) : super(onTap: onTap);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final Set<WidgetState> states = <WidgetState>{
      if (!enabled || (onTap == null && onLongPress == null)) WidgetState.disabled,
      if (selected) WidgetState.selected,
    };
    final ListTileThemeData tileTheme = ListTileTheme.of(context);
    final MouseCursor effectiveMouseCursor = WidgetStateProperty.resolveAs<MouseCursor?>(mouseCursor, states) ??
        tileTheme.mouseCursor?.resolve(states) ??
        WidgetStateMouseCursor.clickable.resolve(states);
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
