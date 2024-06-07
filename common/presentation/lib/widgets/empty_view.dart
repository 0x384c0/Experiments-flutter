import 'package:flutter/material.dart';

class EmptyStateView extends StatelessWidget {
  const EmptyStateView({super.key, this.refresh});

  final RefreshCallback? refresh;

  @override
  Widget build(BuildContext context) {
    if (refresh != null) {
      return Stack(children: [
        _body(context),
        RefreshIndicator(
          onRefresh: refresh!,
          child: LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints) {
            return SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: ConstrainedBox(
                constraints: constraints.copyWith(minHeight: constraints.maxHeight, maxHeight: double.infinity),
                child: Container(),
              ),
            );
          }),
        ),
      ]);
    } else {
      return _body(context);
    }
  }

  Widget _body(BuildContext context) => Container(
      alignment: AlignmentDirectional.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Icon(Icons.cloud_off),
          const SizedBox(height: 20),
          Text(MaterialLocalizations.of(context).alertDialogLabel),
        ],
      ));
}
