import 'package:flutter/material.dart';

import '../extensions/build_context_theme.dart';

class PromptDialog extends StatelessWidget {
  const PromptDialog._({
    required this.icon,
    required this.title,
    required this.subTitle,
    required this.positive,
    required this.negative,
  });

  final Widget icon;
  final String title;
  final String subTitle;
  final String positive;
  final String negative;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: EdgeInsets.all(context.dimensions.medium),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    Align(
                      alignment: Alignment.topRight,
                      child: IconButton(
                        onPressed: () => Navigator.pop(context),
                        style: const ButtonStyle(tapTargetSize: MaterialTapTargetSize.shrinkWrap),
                        icon: const Icon(Icons.close),
                      ),
                    ),
                    icon,
                  ],
                ),
                SizedBox(height: context.dimensions.small),
                Text(title, textAlign: TextAlign.center, style: context.theme.textTheme.titleLarge),
                SizedBox(height: context.dimensions.small),
                Text(subTitle, textAlign: TextAlign.center, style: context.theme.textTheme.bodyMedium),
              ],
            ),
          ),
          SizedBox(height: context.dimensions.small),
          const Divider(height: 1),
          Padding(
            padding: EdgeInsets.all(context.dimensions.medium),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                FilledButton(
                  onPressed: () => Navigator.pop(context, true),
                  style: context.theme.filledButtonTheme.style?.copyWith(
                    backgroundColor: WidgetStatePropertyAll(context.theme.colorScheme.tertiary),
                  ),
                  child: Text(positive),
                ),
                const SizedBox(height: 12),
                OutlinedButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text(negative),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  static Future<bool> show({
    required BuildContext context,
    required Widget icon,
    required String title,
    required String subTitle,
    required String positive,
    required String negative,
  }) =>
      showDialog(
          context: context,
          builder: (context) => PromptDialog._(
                icon: icon,
                title: title,
                subTitle: subTitle,
                positive: positive,
                negative: negative,
              )).then((value) => value == true);
}
