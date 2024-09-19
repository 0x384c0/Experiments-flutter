# Clean Architecture Modular Flutter App

A sample flutter app that has multiple features.\
Inspired by [Clean Architecture](https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html) from [Uncle Bob](https://x.com/unclebobmartin)

![tests workflow](https://github.com/0x384c0/Experiments-flutter/actions/workflows/unit_tests.yml/badge.svg)
![deploy_web workflow](https://github.com/0x384c0/Experiments-flutter/actions/workflows/deploy_web.yml/badge.svg)

<img src="/media/mac_app_screenshot.jpg" height="300">

### Build Requirements

* [flutter](https://github.com/flutter/flutter) 3.+
* Android Studio

### Modules

App has multiple features - [posts](/features/reddit_posts), [weather](/features/weather). Each
feature split in to 3 modules

- [Presentation](/features/reddit_posts/presentation) - contains Presentation Layer (widgets and
  cubits)
- [Domain](/features/reddit_posts/domain) - contains Domain layer with business logic (interactors
  and interfaces)
- [Data](/features/reddit_posts/data) - contains Data layer with REST API requests

### Layers Scheme

![layers](/media/layers.jpg)

### Communication between layers

1. [UI](/features/reddit_posts/presentation/lib/src/widgets/posts_page.dart) sends signals
   to [Cubit](/features/reddit_posts/presentation/lib/src/widgets/posts_cubit.dart)
2. Cubit executes Use cases
   from [Interactor](/features/reddit_posts/domain/lib/src/use_cases/interactor.dart).
3. Use case obtains data
   from [Repository](/features/reddit_posts/data/lib/repository/remote_repository.dart)
4. Repository returns data from a [Api](/features/reddit_posts/data/lib/api/reddit_api.dart).
5. Information flows back to the UI to be displayed.

Presentation and Data depends on Domain, but Domain know nothing about them.

### Dependencies

1. [rxdart](https://pub.dev/packages/rxdart)
1. [flutter_modular](https://pub.dev/packages/flutter_modular)
1. [flutter_cubit](https://pub.dev/documentation/flutter_cubit/latest/)
1. [retrofit](https://pub.dev/packages/retrofit)
1. [json_annotation](https://pub.dev/packages/json_annotation)
1. [mocktail](https://pub.dev/packages/mocktail)

### Test coverage

- [data](/features/weather/data/test)
- [domain](/features/weather/domain/test/interactor_test.dart)
- [widgets](/features/weather/presentation/test)
- [UI tests](/ui_tests/features)

### [.run](.run) scripts

* [build_runner](.run/build_runner.run.xml) - run `dart run build_runner build --delete-conflicting-outputs` in all modules with build_runner enabled
* [clean_all](.run/clean_all.run.xml) - run `flutter clean` in all modules
* [pub_get_all](.run/pub_get_all.run.xml) - run `flutter pub get` in all modules
* [generate_translate_file](.run/generate_translate_file.run.xml) - run `flutter gen-l10n` in all modules with l10n.yaml file
* [main.dart](.run/main.dart.run.xml) - run app

### Adding New module

- run `flutter create` in feature directory with unique project name. For
  example: `flutter create --template=package --project-name features_weather_presentation presentation`
- remove unused files. For
  example: `cd presentation && rm -rf android ios linux macos windows LICENSE CHANGELOG.md`
- replace `homepage:` with `publish_to: none` in `podspec.yaml`
- add dependencies from other modules
- add this module as dependency to other modules using `path:`

## TODO

* replace word `page` with `screen`
* https://pub.dev/packages/crdt
* https://github.com/cfug/dio/issues/1653
* https://pub.dev/packages/mapify_generator
* https://pub.dev/packages/auto_route
* https://pub.dev/packages/app_links
* add loading indicators using [Lottie](https://pub.dev/packages/lottie)
