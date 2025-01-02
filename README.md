# Clean Architecture Modular Flutter App

A sample flutter app that has multiple features.\
Inspired by [Clean Architecture](https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html) from [Uncle Bob](https://x.com/unclebobmartin)

[![tests workflow](https://github.com/0x384c0/Experiments-flutter/actions/workflows/unit_tests.yml/badge.svg)](https://github.com/0x384c0/Experiments-flutter/actions/workflows/unit_tests.yml)
[![deploy_web workflow](https://github.com/0x384c0/Experiments-flutter/actions/workflows/deploy_web.yml/badge.svg)](https://github.com/0x384c0/Experiments-flutter/actions/workflows/deploy_web.yml)
[![deploy_android workflow](https://github.com/0x384c0/Experiments-flutter/actions/workflows/deploy_android.yml/badge.svg)](https://github.com/0x384c0/Experiments-flutter/actions/workflows/deploy_android.yml)

<img src="/media/mac_app_screenshot.jpg" height="300">

## Modules

App has multiple features - [posts](packages/features/reddit_posts), [weather](packages/features/weather). Each
feature split in to 3 layers

- [Presentation](packages/features/reddit_posts/presentation) - contains Presentation Layer (widgets and
  cubits)
- [Domain](packages/features/reddit_posts/domain) - contains Domain layer with business logic (interactors
  and interfaces)
- [Data](packages/features/reddit_posts/data) - contains Data layer with REST API requests

## Layers Scheme

![layers](/media/layers.jpg)

## Communication between layers

1. [UI](packages/features/reddit_posts/presentation/lib/src/widgets/posts_screen.dart) sends signals
   to [Cubit](packages/features/reddit_posts/presentation/lib/src/widgets/posts_cubit.dart)
2. Cubit executes Use cases
   from [Interactor](packages/features/reddit_posts/domain/lib/src/use_cases/interactor.dart).
3. Use case obtains data
   from [Repository](packages/features/reddit_posts/data/lib/repository/remote_repository.dart)
4. Repository returns data from a [Api](packages/features/reddit_posts/data/lib/api/reddit_api.dart).
5. Information flows back to the UI to be displayed.

Presentation and Data depends on Domain, but Domain know nothing about them.

## Dependencies

1. [melos](https://pub.dev/packages/melos)
1. [rxdart](https://pub.dev/packages/rxdart)
1. [flutter_modular](https://pub.dev/packages/flutter_modular)
1. [flutter_cubit](https://pub.dev/documentation/flutter_cubit/latest/)
1. [retrofit](https://pub.dev/packages/retrofit)
1. [json_annotation](https://pub.dev/packages/json_annotation)
1. [mocktail](https://pub.dev/packages/mocktail)

## Test coverage

- [data](packages/features/weather/data/test)
- [domain](packages/features/weather/domain/test/interactor_test.dart)
- [widgets](packages/features/weather/presentation/test)
- [UI tests](apps/app_main/ui_tests/features)

## Environment
```
[✓] Flutter (Channel stable, 3.24.5, on macOS 15.1 24B83 darwin-arm64, locale en-KG)
    • Flutter version 3.24.5 on channel stable at /Users/user/fvm/versions/3.24.5
    • Upstream repository https://github.com/flutter/flutter.git
    • Framework revision dec2ee5c1f (6 days ago), 2024-11-13 11:13:06 -0800
    • Engine revision a18df97ca5
    • Dart version 3.5.4
    • DevTools version 2.37.3

[✓] Android toolchain - develop for Android devices (Android SDK version 34.0.0)
    • Android SDK at /Users/user/Library/Android/sdk
    • Platform android-34, build-tools 34.0.0
    • ANDROID_HOME = /Users/user/Library/Android/sdk
    • Java binary at: /opt/homebrew/opt/openjdk@17/bin/java
    • Java version OpenJDK Runtime Environment Homebrew (build 17.0.13+0)
    • All Android licenses accepted.

[✓] Xcode - develop for iOS and macOS (Xcode 16.1)
    • Xcode at /Applications/Xcode.app/Contents/Developer
    • Build 16B40
    • CocoaPods version 1.15.2

[✓] Android Studio (version 2024.2)
```

## Build project
* install [flutter](https://docs.flutter.dev/get-started/install)
* `dart pub global activate melos`
* `dart run melos bootstrap`
* `cd apps/app_main` 
* `flutter run `

## Contributing
* [CONTRIBUTING.md](CONTRIBUTING.md) contains information about frameworks and libraries in app

# TODO
* fix UI tests
* add Oauth2
* https://github.com/cfug/dio/issues/1653
* https://pub.dev/packages/auto_route
* https://pub.dev/packages/app_links
* https://pub.dev/packages/mapify_generator
* add loading indicators using [Lottie](https://pub.dev/packages/lottie)
