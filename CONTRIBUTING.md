# Contribution Guidelines

## Branching Rules

* Direct pushes to the `master` and `develop` branches are forbidden.
* Each new feature must be developed in its dedicated branch and subsequently merged into the `develop` branch using a merge request.
* Feature branch names must include the corresponding JIRA task name. For example: `feature/CJDB-123_useful_feature`.

## Code Review Best Practices

* For significant changes, particularly those with over 1000 lines of code, consider splitting them into multiple merge requests within the feature branch. This approach enhances the code review process and ensures better quality control.
  * An exception is refactoring or other non-functional changes.
  * Once these smaller merge requests are reviewed and merged into the feature branch, it can be merged into the `develop` branch without additional review.

## Unit Tests
When contributing to this project, please ensure that your code adheres to the following guidelines for unit tests:
* Interactors and Data Mappers: All interactors and data mappers must be thoroughly covered with unit tests to maintain code quality and reliability.
* Complex Logic: Unit tests should be provided for any code containing complex logic. This helps ensure that the intricate parts of the codebase are well-tested and can catch potential issues.
* Trivial and Boilerplate Code: Trivial and boilerplate code, which is straightforward and contains no custom logic, does not need to be covered with unit tests. However, if you believe unit tests would provide value, feel free to add them at your discretion.

### Adding New Module

- Run `flutter create` in the feature directory with a unique project name. For
  example: `flutter create --template=package --project-name features_weather_presentation presentation`
- Remove unused files. For
  example: `cd presentation && rm -rf android ios linux macos windows LICENSE CHANGELOG.md`
- Replace `homepage:` with `publish_to: none` in `pubspec.yaml`
- Add dependencies from other modules.
- Add this module as a dependency to other modules using `path:`.

# Frameworks and Libraries

## Dependency Injection
* To provide and inject dependencies, the app uses [flutter_modular](https://modular.flutterando.com.br/docs/flutter_modular/dependency-injection) and [auto_injector](https://pub.dev/packages/auto_injector).
* Dependencies are provided by `Module` subclasses.
* Dependencies can be injected anywhere with `Modular.get<Type>()`.
* Optionally, dependencies can be injected automatically in the constructor, but only in classes that are provided in `Module` subclasses.
* Each layer in a feature has its own `Module`, which provides its dependencies.
* All modules are instantiated in [AppModule](lib/app_module.dart).

## Theme and Styles
* The app theme is provided by [ThemeProvider](packages/common/presentation/lib/theme/theme_provider.dart) and can be accessed as `context.theme`.
* Custom colors can be added to [ThemeColors](packages/common/presentation/lib/theme/theme_colors.dart) and can be accessed as `context.themeColors.{color name}`.
* Custom styles can be added to [Styles](packages/common/presentation/lib/theme/styles.dart) and can be accessed as `context.style.{style name}`.
* Common dimensions and paddings are stored in [Dimensions](packages/common/presentation/lib/theme/dimensions.dart) and can be accessed as `context.dimensions.{dimension name}`.

## Navigation
* For navigation, [flutter_modular](https://modular.flutterando.com.br/docs/flutter_modular/navegation/) is used.
* Classes for navigation are placed in `lib/packages/features/{feature name}/navigation`.
* To add a new route, modify `lib/packages/features/{feature name}/navigation/module.dart` by providing the route name and widget.
* Then add a method to execute this route in `lib/packages/features/{feature name}/navigation/navigator.dart` by its name and, optionally, arguments.
* After that, the navigator can be accessed with Dependency Injection.
* **Note:** Drawer menu navigation in [home_screen.dart](packages/features/home/presentation/lib/src/screens/home_screen.dart) is not using any navigation library. It is a single screen with [PageView](https://api.flutter.dev/flutter/widgets/PageView-class.html).
  * New options in the drawer are added by modifying [SelectedPageState](packages/features/home/presentation/lib/src/data/selected_page_state.dart) and `HomeScreen._page`.

## Localization
* The app uses [flutter_localizations](https://docs.flutter.dev/ui/accessibility-and-internationalization/internationalization).
* Translations are stored in [lib/l10n](packages/features/home/presentation/lib/l10n) directory in `.arb` files.
* Translations can be accessed as `context.localizations`.
* The app supports switching language by the user without changing the system language.
  * Call `context.read<AppLocaleProvider>().changeLanguage(locale)` to switch locales.
  * Localized strings will be changed automatically.
  * By default, data from the API will not reload, but if a widget is wrapped in [wrapInEventListeners(localeChange = true, )](packages/common/presentation/extensions/widget_listener.dart), it will be recreated upon locale change, and data from the API will be reloaded.

## API and OAuth2
* The app uses [retrofit](https://pub.dev/packages/retrofit) to generate HTTP requests to the API.
* The app uses [Dio interceptors](https://pub.dev/packages/dio#interceptors) to inject `access_token` into every HTTP request.
* `access_token` management is performed in [oauth_interceptor.dart](packages/common/data/lib/client/oauth_interceptor.dart) and [oauth_token_refresher_impl.dart](packages/common/data/lib/client/oauth_token_refresher_impl.dart).
* An instance of `Dio` is provided by Dependency Injection and used in almost every API class generated by [retrofit](https://pub.dev/packages/retrofit).

## Custom Utilities
* Utility classes, extensions, and widgets are placed in [common](packages/common/presentation/lib/widgets).
* [web_view](packages/features/webview/presentation/lib/src/widgets/web_view) is a wrapper for [flutter_inappwebview](https://pub.dev/packages/flutter_inappwebview) and allows the creation of full-screen WebViews (with a navigation bar) and embedding them into other screens.
* Screens implemented with utilities from [screen_state](packages/common/presentation/lib/widgets/screen_state/screen_state.dart) will automatically show loading indicators, errors, and handle pagination and errors from the API.
  * It requires the use of [flutter_bloc](https://pub.dev/packages/flutter_bloc).
* The app uses FCM for push notifications, and this logic is stored in [push_notification_provider.dart](packages/features/firebase_chat/presentation/lib/src/widgets/push_notification_provider.dart).
* [wrapInEventListeners()](packages/common/presentation/lib/extensions/widget_listener.dart) can recreate widgets when `AppStateNotifier.triggerEvent` is called or when the locale is changed.
  * Configurable via function arguments.
* [ErrorDtoMapper](packages/common/data/lib/mapper/error_dto_mapper.dart) contains logic that tries to handle errors from the HTTP API and maps them to [ErrorModel](packages/common/domain/lib/data/error_model.dart).
  * `.mapError(_errorDtoMapper.map)` is used to invoke the mapper.