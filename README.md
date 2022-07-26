# Weather App
A sample flutter app that shows today weather and forecast for current device location

![tests workflow](https://github.com/0x384c0/Experiments-flutter/actions/workflows/unit_tests.yml/badge.svg)

### Build Requirements
* flutter 3.0
* Android Studio

### Modules
App has single feature - [weather](/features/weather). Feature split in to 3 modules
- [Presentation](/features/weather/presentation) - contains Presentation Layer (widgets and cubits)
- [Domain](/features/weather/domain) - contains Domain layer with business logic (interactors and interfaces)
- [Data](/features/weather/data) - contains Data layer with REST API requests

### Layers Scheme

![layers](/media/layers.jpg)

### Communication between layers

1. [UI](/features/weather/presentation/lib/widgets/weather_page.dart) sends signals to [Cubit](/features/weather/presentation/lib/widgets/weather_cubit.dart)
2. Cubit executes Use cases from [Interactor](/features/weather/domain/lib/usecases/interactor.dart).
3. Use case obtains data from [Repository](/features/weather/data/lib/repository/remote_repository.dart)
4. Repository returns data from a [Api](/features/weather/data/lib/api/weather_api.dart).
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
- [widgets](/test/features/weather/presentation/)

## TODO
* add screenshots