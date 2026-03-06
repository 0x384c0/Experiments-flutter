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
- Never run the app.
- While running commands don't to listen to logs. Only look at error code. But if command finished with error code, only then analyze logs.
- When adding a new feature packages, ensure its DI module is registered in `apps/app_main/lib/di/configure_dependencies.dart` and run `melos run build_runner` after making changes.
- When added new Interactors and Mappers, cover it with Unit tests
- For navigation use `@RoutePage()` and run `melos run build_runner` after making changes.
- For UI use [extensions](packages/common/presentation/lib/extensions).
- For Screens that uses async calls to API use [screen_state](packages/common/presentation/lib/widgets/screen_state)
- New Widgets in [common module](packages/common/presentation) must have the least amount of dependencies, ideally just a stateless or stateful widgets.
