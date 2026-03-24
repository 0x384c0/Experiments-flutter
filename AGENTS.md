# AI Agent Guide: Experiments-flutter

This document provides essential context for AI agents to understand and work with this project efficiently.

## Project Overview
This is a **Clean Architecture Modular Flutter App** managed with **Melos**.

- **Apps**: Located in [apps](apps) (e.g., [app_main](apps/app_main)). This is the entry point.
- **Packages**: Located in [packages](packages).
    - [features](packages/features): Contains feature-specific modules (e.g., `reddit_posts`, `weather`).
    - [data](packages/common/data) [domain](packages/common/domain) [presentation](packages/common/presentation): Shared logic across features per layer.
- melos commands in [pubspec.yaml](pubspec.yaml)

## Architecture & Layers
- Described in [README.md](README.md)
- Look there only while working with large requests, affecting multiple files.

## AI-Agents Tips
- While running commands don't to listen to logs. Only look at error code. But if command finished with error code, only then analyze logs.
- When adding a new feature packages, ensure that:
  - it is added as in workspace in [pubspec.yaml](pubspec.yaml), with its dependencies
  - its presentation exports `init_micro_package.module.dart`, `src/navigation/router.dart` and `src/navigation/routes_provider.dart`
  - its DI module is registered in [configure_dependencies.dart](apps/app_main/lib/di/configure_dependencies.dart)
  - its router is registered in [app_router.dart](apps/app_main/lib/app_router.dart)
  - run `melos run build_runner` after making changes.
- After adding or modifying new Interactors and Mappers, cover it with Unit tests with mock injections
- For navigation use `@RoutePage()` and run `melos run build_runner` after making changes. During creation of AutoRoute provide only page. 
- For UI use [extensions](packages/common/presentation/lib/extensions).
- For Screens that uses async calls to API use [screen_state](packages/common/presentation/lib/widgets/screen_state)
- New Widgets in [common module](packages/common/presentation) must have the least amount of dependencies, ideally just a stateless or stateful widgets.
