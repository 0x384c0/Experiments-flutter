# Modular Flutter App
A sample flutter app that has mutliple features.

![tests workflow](https://github.com/0x384c0/Experiments-flutter/actions/workflows/unit_tests.yml/badge.svg)

<img src="/media/mac_app_screenshot.jpg" height="300">

### Build Requirements
* [flutter](https://github.com/flutter/flutter) 3.+
* Android Studio

### Modules
App has multiple features - [posts](/features/reddit_posts), [weather](/features/weather). Each feature split in to 3 modules
- [Presentation](/features/reddit_posts/presentation) - contains Presentation Layer (widgets and cubits)
- [Domain](/features/reddit_posts/domain) - contains Domain layer with business logic (interactors and interfaces)
- [Data](/features/reddit_posts/data) - contains Data layer with REST API requests

### Layers Scheme

![layers](/media/layers.jpg)

### Communication between layers

1. [UI](/features/reddit_posts/presentation/lib/widgets/posts_page.dart) sends signals to [Cubit](/features/reddit_posts/presentation/lib/widgets/posts_cubit.dart)
2. Cubit executes Use cases from [Interactor](/features/reddit_posts/domain/lib/usecases/interactor.dart).
3. Use case obtains data from [Repository](/features/reddit_posts/data/lib/repository/remote_repository.dart)
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
- [data](/test/features/weather/data/remote_repository_test.dart)
- [domain](/test/features/weather/domain/interactor_test.dart)
- [widgets](/test/features/weather/presentation)

### [.run](.run) scripts
* [build_runner](.run/build_runner.run.xml) - generate code for JSON Serializable 
* [clean_all](.run/clean_all.run.xml) - run `flutter clean` in all modules
* [pub_get_all](.run/pub_get_all.run.xml) - run `flutter pub get` in all modules
* [generate_translate_file](.run/generate_translate_file.run.xml) - regenerate localized strings
* [main.dart](.run/main.dart.run.xml) - run app

### Adding New module
- run `flutter create` in feature directory with unique project name. For example: `flutter create --template=package --project-name features_weather_presentation presentation`
- remove unused files. For example: `cd presentation && rm -rf android ios linux macos windows LICENSE CHANGELOG.md`
- replace `homepage:` with `publish_to: none` in `podspec.yaml`
- add dependencies from other modules
- add this module as dependency to other modules using `path:`

## TODO
* add paging
* on error dismiss previous errors and add option to refresh after error
* add loading indicators using [Lottie](https://pub.dev/packages/lottie)
* split localized string per module
* https://pub.dev/packages/easy_localization
* https://pub.dev/packages/auto_route
* https://pub.dev/packages/freezed
* create simple module as template
* fature module should not depend on eachother, all communication via small interfaces in common module
* replace helper methods with widgets