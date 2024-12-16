# Contribution Guidelines

## Branching Rules

* Direct pushes to the `master` and `develop` branches are forbidden.
* Each new feature must be developed in its dedicated branch and subsequently merged into the `develop` branch using a merge request.
* Feature branch names must include the corresponding JIRA task name. For example: `feature/CJDB-123_useful_feature`.

## Code Review Best Practices

* For significant changes, particularly those with over 1000 lines of code, consider to split them into multiple merge requests within the feature branch. This approach enhances the code review process and ensures better quality control.
  * An exception is a refactoring or other non-functional changes.
  * Once these smaller merge requests reviewed and merged in to feature branch, it can be merged into the `develop` branch without additional review.

## Unit Tests
When contributing to this project, please ensure that your code adheres to the following guidelines for unit tests:
* Interactors and Data Mappers: All interactors and data mappers must be thoroughly covered with unit tests to maintain code quality and reliability.
* Complex Logic: Unit tests should be provided for any code containing complex logic. This helps ensure that the intricate parts of the codebase are well-tested and can catch potential issues.
* Trivial and Boilerplate Code: Trivial and boilerplate code, which is straightforward and contains no custom logic, does not need to be covered with unit tests. However, if you believe unit tests would provide value, feel free to add them at your discretion.


### Adding New module

- run `flutter create` in feature directory with unique project name. For
  example: `flutter create --template=package --project-name features_weather_presentation presentation`
- remove unused files. For
  example: `cd presentation && rm -rf android ios linux macos windows LICENSE CHANGELOG.md`
- replace `homepage:` with `publish_to: none` in `podspec.yaml`
- add dependencies from other modules
- add this module as dependency to other modules using `path:`


# Frameworks and libraries

## Dependency Injection
* to provide and inject dependencies app uses [flutter_modular](https://modular.flutterando.com.br/docs/flutter_modular/dependency-injection) and [auto_injector](https://pub.dev/packages/auto_injector)
* dependencies provided by `Module` subclasses
* dependencies can be injected anywhere with `Modular.get<Type>()`
* optionally, dependencies can be injected automatically in the constructor, but only in classes, that are provided in `Module` subclasses.
* each layer in feature has it own `Module`, that provides its dependencies
* all modules are instantiated in [AppModule](lib/app_module.dart)

## Theme and Styles
* App theme provided by [ThemeProvider](lib/common/presentation/theme/theme_provider.dart) and can be accessed as `context.theme`
* Custom colors can be added to [ThemeColors](lib/common/presentation/theme/theme_colors.dart) and can be accessed as `context.themeColors.{color name}`
* Custom styles can be added to [Styles](lib/common/presentation/theme/styles.dart) and can be accessed as `context.style.{style name}`
* Common dimensions, paddings stored in [Dimensions](lib/common/presentation/theme/dimensions.dart) and can be accessed as `context.dimensions.{dimension name}`

## Navigation
* for navigation [flutter_modular](https://modular.flutterando.com.br/docs/flutter_modular/navegation/) is used
* classes for navigation are placed in `lib/features/{feature name}/navigation`
* to add new route modify `lib/features/{feature name}/navigation/module.dart` by providing route name, widget
* then add method to execute this route in `lib/features/{feature name}/navigation/navigator.dart` by its name and, optionally, arguments
* after that navigator can be accessed with Dependency Injection
* **Note:** Drawer menu navigation in [home_screen.dart](features/home/presentation/lib/src/screens/home_screen.dart) is not using any navigation library. It is a single screen with [PageView](https://api.flutter.dev/flutter/widgets/PageView-class.html)
  * new options in to drawer added by modifying [SelectedPageState](features/home/presentation/lib/src/data/selected_page_state.dart) and `HomeScreen._page`

## Localization
* app uses [flutter_localizations](https://docs.flutter.dev/ui/accessibility-and-internationalization/internationalization)
* translation stored in [lib/l10n](features/home/presentation/lib/l10n) directory in arb files
* translation can be accessed as `context.localizations`
* app supports switching language by user without changing system language
  * call `context.read<AppLocaleProvider>().changeLanguage(locale)` to switch locale
  * localized string will be changed automatically
  * By default data from API will not reload, but if widget wrapped in [wrapInEventListeners(localeChange = true, )](lib/common/presentation/extensions/widget_listener.dart) it will be recreated upon locale change and data from API will be reloaded

## API and Oauth2
* app uses [retrofit](https://pub.dev/packages/retrofit) to generate HTTP requests to API
* app uses [Dio interceptors](https://pub.dev/packages/dio#interceptors) to inject `access_token` to every HTTP request
* `access_token` management is performed in [oauth_interceptor.dart](common/data/lib/client/oauth_interceptor.dart) and [oauth_token_refresher_impl.dart](common/data/lib/client/oauth_token_refresher_impl.dart)
* instance of `Dio` is provided by Dependency Injection and used in almost every Api class, generated by [retrofit](https://pub.dev/packages/retrofit)

## Custom Utilities
* Utility classes, extensions and widgets are placed in [common](common/presentation/lib/widgets)
* [web_view](features/webview/presentation/lib/src/widgets/web_view) is a wrapper for [flutter_inappwebview](https://pub.dev/packages/flutter_inappwebview) and allows the creation of full screen WebViews (with navigation bar) and embed them in to other screens
* screens implemented with utilities from [screen_state](common/presentation/lib/widgets/screen_state/screen_state.dart) will automatically show loading indicators, errors and handle pagination, errors from API
  * it requires the use of [flutter_bloc](https://pub.dev/packages/flutter_bloc)
* App uses FCM for push notification and this logic is stored in [push_notification_provider.dart](lib/common/presentation/providers/push_notification_provider.dart)
* [wrapInEventListeners()](lib/common/presentation/extensions/widget_listener.dart) can recreate widgets when [AppStateNotifier.triggerEvent] is called or when locale is changed.
  * Configurable via function arguments
* [ErrorDtoMapper](common/data/lib/mapper/error_dto_mapper.dart) contains logic that tries to handle error from HTTP API and maps them to [ErrorModel](common/domain/lib/data/error_model.dart)
  * `.mapError(_errorDtoMapper.map)` is used to invoke tha mapper