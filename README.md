# bloc_todo_app

A Flutter starter template for building scalable apps using the
[BLoC pattern](https://bloclibrary.dev).

## Overview

This template is designed to help you kick off a Flutter project with:

- clear feature-based structure
- predictable state management with BLoC/Cubit
- reusable UI and configuration layers
- easy testability for business logic

## Tech Stack

- Flutter
- Dart
- `flutter_bloc`
- `equatable`

## Recommended Project Structure

```txt
lib/
  app.dart
  main.dart
  configs/
    app_colors.dart
    app_textstyles.dart
    assets.dart
  data/
    exceptions.dart
    dio_client files
  di/
    dependency_injection (getit)  
  core/
    constants/
    errors/
    utils/
  features/
    <feature_name>/
      data/
        data_source/
        models/
        repositories (Impl)/
      domain/
        entities/
        repositories/
        usecases/
      presentation/
        bloc/
          <feature>_bloc.dart
          <feature>_event.dart
          <feature>_state.dart
        view/
        widgets/
  services/
```

## Getting Started

### 1) Prerequisites

- Flutter SDK installed
- Dart SDK installed
- Android Studio / Xcode / VS Code (or Cursor)

Check setup:

```bash
flutter doctor
```

### 2) Install dependencies

```bash
flutter pub get
```

### 3) Run the app

```bash
flutter run
```

## BLoC Startup Checklist

- Create your feature folder under `lib/features/`
- Define events and states in `presentation/bloc/`
- Implement business logic inside your BLoC or Cubit
- Connect UI with `BlocProvider`, `BlocBuilder`, and `BlocListener`
- Keep UI dumb, move logic to BLoC/domain layers
- For the clean architecture implementation see the /home. 
- Else if you need to keep the api integration simple and clean use repository pattern as in /login (). 

## Useful Commands

Run tests:

```bash
flutter test
```

Analyze project:

```bash
flutter analyze
```

Format code:

```bash
dart format .
```

## Conventions

- Name blocs as `<Feature>Bloc`
- Name events as action verbs (`FetchTodos`, `AddTodo`)
- Name states by UI representation (`Loading`, `Loaded`, `Error`)
- Keep one source of truth per feature state

## Next Steps

- Add environment configuration (`dev`, `staging`, `prod`)
- Add repository abstraction per feature
- Add unit tests for blocs/cubits
- Add integration tests for critical user flows

## References

- [Flutter Documentation](https://docs.flutter.dev/)
- [Bloc Library](https://bloclibrary.dev)
- [Very Good CLI (optional scaffolding)](https://cli.vgv.dev/)
