import 'package:auto_route/auto_route.dart';
import 'package:features_home_presentation/l10n/app_localizations.g.dart' as home_localizations;

import 'selected_page_state.dart';

class RouteInfoProvider {
  final PageInfo Function() getPageInfo;
  final PageRouteInfo Function() getRouteInfo;
  final String Function(home_localizations.AppLocalizations) getTitle;
  final SelectedPageState selectedPageState;

  RouteInfoProvider({
    required this.getPageInfo,
    required this.getRouteInfo,
    required this.selectedPageState,
    required this.getTitle,
  });
}
