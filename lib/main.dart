import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

void main() {
  return runApp(ModularApp(module: AppModule(), child: const AppWidget()));
}

//region app
class AppModule extends Module {
  @override
  List<Bind> get binds => [
    Bind.factory<Navigator>((i) => _NavigatorImpl())
  ];

  @override
  List<ModularRoute> get routes => Modular.get<Navigator>().routes;
}
//endregion

//region widget
class AppWidget extends StatelessWidget {
  const AppWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context){
    return MaterialApp.router(
      title: 'My Smart App',
      theme: ThemeData(primarySwatch: Colors.green),
      routeInformationParser: Modular.routeInformationParser,
      routerDelegate: Modular.routerDelegate,
    );
  }
}
//endregion

//region pages
class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  final navigator = Modular.get<Navigator>();

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title: Text('Home Page')),
      body: Center(
        child: Column(children: [
          Text('This is initial page'),
          ElevatedButton(
            onPressed: () => navigator.toSecondPage("TEST"),
            child: Text('Navigate to Second Page'),
          ),
        ],)
      ),
    );
  }
}

class SecondPage extends StatelessWidget {
  SecondPage(this.name, {Key? key}) : super(key: key);

  final String name;
  final navigator = Modular.get<Navigator>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Second Page $name')),
      body: Center(
        child: ElevatedButton(
          onPressed: () => navigator.back(),
          child: Text('Back to Home'),
        ),
      ),
    );
  }
}
//endregion

//region navigator
abstract class Navigator {
  List<ModularRoute> get routes;
  toSecondPage(String name);
  back();
}

class _NavigatorImpl extends Navigator {

  @override
  List<ModularRoute> get routes => [
    ChildRoute('/', child: (context, args) => HomePage()),
    ChildRoute(
        '/second/:name',
        child: (context, args) => SecondPage(args.params['name']),
        transition: TransitionType.defaultTransition
    ),
    WildcardRoute(child: (context, args) => HomePage()),
  ];

  @override
  toSecondPage(String name){
    Modular.to.pushNamed('/second/$name');
  }

  @override
  back(){
    Modular.to.pop();
  }
}
//endregion