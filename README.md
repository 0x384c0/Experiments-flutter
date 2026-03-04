# Clean Architecture Modular Flutter App

A sample Flutter app that has multiple features.\
Inspired by [Clean Architecture](https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html) from [Uncle Bob](https://x.com/unclebobmartin)

[![melos](https://img.shields.io/badge/maintained%20with-melos-f700ff.svg?style=flat-square)](https://github.com/invertase/melos)
[![tests workflow](https://github.com/0x384c0/Experiments-flutter/actions/workflows/unit_tests.yml/badge.svg)](https://github.com/0x384c0/Experiments-flutter/actions/workflows/unit_tests.yml)
[![deploy_web workflow](https://github.com/0x384c0/Experiments-flutter/actions/workflows/deploy_web.yml/badge.svg)](https://github.com/0x384c0/Experiments-flutter/actions/workflows/deploy_web.yml)
[![deploy_android workflow](https://github.com/0x384c0/Experiments-flutter/actions/workflows/deploy_android.yml/badge.svg)](https://github.com/0x384c0/Experiments-flutter/actions/workflows/deploy_android.yml)

<img src="/media/mac_app_screenshot.jpg" height="300">

## Modules

App has multiple features - [posts](packages/features/reddit_posts), [weather](packages/features/weather). Each
feature is split into 3 layers

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
1. Cubit executes use cases
   from [Interactor](packages/features/reddit_posts/domain/lib/src/use_cases/interactor.dart).
1. Use case obtains data
   from [Repository](packages/features/reddit_posts/data/lib/src/repository/remote_repository.dart)
1. Repository returns data from an [Api](packages/features/reddit_posts/data/lib/src/api/reddit_api.dart).
1. Information flows back to the UI to be displayed.

Presentation and Data depend on Domain, but Domain knows nothing about them.

## Dependencies

1. [melos](https://pub.dev/packages/melos)
1. [rxdart](https://pub.dev/packages/rxdart)
1. [flutter_modular](https://pub.dev/packages/flutter_modular)
1. [auto_route](https://pub.dev/packages/auto_route)
1. [flutter_cubit](https://pub.dev/documentation/flutter_cubit/latest/)
1. [retrofit](https://pub.dev/packages/retrofit)
1. [json_annotation](https://pub.dev/packages/json_annotation)
1. [mocktail](https://pub.dev/packages/mocktail)

## Test coverage

- [data](packages/features/weather/data/test)
- [domain](packages/features/weather/domain/test/interactor_test.dart)
- [widgets](packages/features/weather/presentation/test)
- [UI tests](apps/app_main/ui_tests/features)
  - see [ui_tests/Readme.md](apps/app_main/ui_tests/Readme.md) for details

## Environment
```
[✓] Flutter (Channel stable, 3.41.3, on macOS 26.2 25C56 darwin-arm64, locale en-KG) [465ms]
    • Flutter version 3.41.3 on channel stable at ~/fvm/versions/3.41.3
    • Upstream repository https://github.com/flutter/flutter.git
    • Framework revision 48c32af034 (5 days ago), 2026-02-27 17:09:06 -0500
    • Engine revision 327ed81450
    • Dart version 3.11.1
    • DevTools version 2.54.1
    • Feature flags: enable-web, enable-linux-desktop, enable-macos-desktop, enable-windows-desktop, enable-android, enable-ios, cli-animations, enable-native-assets, omit-legacy-version-file, enable-lldb-debugging,
      enable-uiscene-migration

[✓] Android toolchain - develop for Android devices (Android SDK version 36.1.0) [2.8s]
    • Android SDK at ~/Library/Android/sdk
    • Emulator version 36.4.9.0 (build_id 14788078) (CL:N/A)
    • Platform android-36, build-tools 36.1.0
    • ANDROID_HOME = ~/Library/Android/sdk
    • Java binary at: /opt/homebrew/opt/openjdk@17/bin/java
      This JDK is specified in your Flutter configuration.
      To change the current JDK, run: `flutter config --jdk-dir="path/to/jdk"`.
    • Java version OpenJDK Runtime Environment Homebrew (build 17.0.14+0)
    • All Android licenses accepted.

[✓] Xcode - develop for iOS and macOS (Xcode 26.1.1) [1,465ms]
    • Xcode at /Applications/Xcode.app/Contents/Developer
    • Build 17B100
    • CocoaPods version 1.16.2
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
* remove flutter_modular
* fix cors for web
* https://pub.dev/packages/mapify_generator
* add Oauth2 example
* https://github.com/cfug/dio/issues/1653
* https://pub.dev/packages/app_links
* add loading indicators using [Lottie](https://pub.dev/packages/lottie)
