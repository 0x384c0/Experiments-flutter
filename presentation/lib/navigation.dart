
//region navigator
abstract class Navigator {
  toSecondPage(String name);

  back();
}

class _NavigatorImpl extends Navigator {
  // @override
  // List<ModularRoute> get routes => [
  //   ChildRoute('/', child: (context, args) => HomePage()),
  //   ChildRoute(
  //       '/second/:name',
  //       child: (context, args) => SecondPage(args.params['name']),
  //       transition: TransitionType.defaultTransition
  //   ),
  //   WildcardRoute(child: (context, args) => HomePage()),
  // ];

  @override
  toSecondPage(String name) {
    // Modular.to.pushNamed('/second/$name');
  }

  @override
  back() {
    // Modular.to.pop();
  }
}
//endregion
