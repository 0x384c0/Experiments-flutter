# Weather App
A sample flutter app that shows today weather and forecast for current device location

### Build Requirements
* flutter 3.0
* Android Studio


### Modules
App has single feature - [weather](/features/weather). Feature split in to 3 modules
- [Presentation](/features/weather/presentation) - contains Presentation Layer (widgets and cubits)
- [Domain](/features/weather/domain) - contains Domain layer with business logic (interactors and interfaces)
- [Data](/features/weather/data) - contains Data layer with REST API requests

### Communication between layers

1. [UI](/features/weather/presentation/lib/widgets/weather_page.dart) sends signals to [Cubit](/features/weather/presentation/lib/widgets/weather_cubit.dart)
1. Cubit executes Use cases from [Interactor](/features/weather/domain/lib/usecases/interactor.dart).
1. Use case obtains data from [Repository](/features/weather/data/lib/repository/remote_repository.dart)
1. Repository returns data from a [Api](/features/weather/data/lib/api/weather_api.dart).
1. Information flows back to the UI to be displayed.


### Dependencies

1. [rxdart](https://pub.dev/packages/rxdart)
1. [flutter_modular](https://pub.dev/packages/flutter_modular)
1. [flutter_cubit](https://pub.dev/documentation/flutter_cubit/latest/)
1. [retrofit](https://pub.dev/packages/retrofit)
1. [json_annotation](https://pub.dev/packages/json_annotation)
1. [mocktail](https://pub.dev/packages/mocktail)

### Test coverage
- [data](/test/features/weather/data/remote_repository_tests.dart)
- [domain](/test/features/weather/domain/interactor_tests.dart)
- [widgets](/test/features/weather/presentation/)

## TODO
* add CI scripts and GitHub Actions
* review architecture, maybe Interactor is not needed