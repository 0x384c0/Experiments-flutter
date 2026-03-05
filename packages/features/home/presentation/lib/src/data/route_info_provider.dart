import 'package:auto_route/auto_route.dart';

import 'selected_page_state.dart';

class RouteInfoProvider {
  final PageInfo Function() getPageInfo;
  final PageRouteInfo Function() getRouteInfo;
  final SelectedPageState selectedPageState;

  RouteInfoProvider({required this.getPageInfo, required this.getRouteInfo, required this.selectedPageState});
}
