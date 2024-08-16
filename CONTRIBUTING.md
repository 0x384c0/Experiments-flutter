# Contribution Guidelines

## Branching Rules

* Direct pushes to the `master` and `develop` branches are forbidden.
* Each new feature must be developed in its dedicated branch and subsequently merged into the `develop` branch using a merge request.
* Feature branch names must include the corresponding JIRA task name. For example: `feature/CJDB-123_useful_feature`.

## Code Review Best Practices

* For significant changes, particularly those with over 1000 lines of code, consider to split them into multiple merge requests within the feature branch. This approach enhances the code review process and ensures better quality control.
  * An exception is a refactoring or other non-functional changes.
  * Once these smaller merge requests reviewed and merged in to feature branch, it can be merged into the `develop` branch without additional review.


## Localization Strings
* app localization implemented with [flutter_localizations](https://api.flutter.dev/flutter/flutter_localizations/flutter_localizations-library.html)
* all localized strings located in `/lib/l10n` directories for each module
* localized string key must start with module name, where it will be used

## Styles and Themes
* avoid styling widgets directly, use `ThemeData` from [app_theme.dart](/common/presentation/lib/theme/app_theme.dart) instead
* if new style was created and used to set `style` to widgets directly, it must be stored in [app_theme.dart](/common/presentation/lib/theme/app_theme.dart)
* for colors and dimensions it is preferred to use constants from [theme folder](/common/presentation/lib/theme)

## Unit Tests 
When contributing to this project, please ensure that your code adheres to the following guidelines for unit tests:

* Interactors and Data Mappers: All interactors and data mappers must be thoroughly covered with unit tests to maintain code quality and reliability.
* Complex Logic: Unit tests should be provided for any code containing complex logic. This helps ensure that the intricate parts of the codebase are well-tested and can catch potential issues.
* Trivial and Boilerplate Code: Trivial and boilerplate code, which is straightforward and contains no custom logic, does not need to be covered with unit tests. However, if you believe unit tests would provide value, feel free to add them at your discretion.
