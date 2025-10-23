<!-- Copilot / AI agent instructions for the Seed Flutter app -->
# Repository summary
Seed is a feature-driven Flutter app with **clean architecture** (data/domain/presentation layers within each feature). Core shared code lives in `lib/core/`. Major features have dedicated folders under `lib/features/` with complete DDD layering. Legacy presentation code remains in `lib/presentation/` during migration.

# Architecture Overview
- **Feature-based structure**: `lib/features/<feature_name>/` contains `data/`, `domain/`, `presentation/`
- **Domain layer**: Entities, repository interfaces, use cases (business logic)
- **Data layer**: Repository implementations, data sources (local/remote)
- **Presentation layer**: Screens, widgets, BLoCs (state management)
- **Core**: Shared utilities (`utils/`, `widgets/`, `constants/`, `repositories/`, `di/`)
- **Dependency Injection**: Uses `get_it` (see `lib/core/di/dependency_injection.dart`)
- **State Management**: Uses **BLoC pattern** (`flutter_bloc`) for business logic separation

# What an AI coding agent should know (concise)
- **Entry point**: `lib/main.dart` calls `initializeDependencies()` for DI setup and registers `AppBlocObserver`. Do not remove this.
- **Routing**: `AppRouterConfig.goRouter` (in `lib/core/routes/app_router_config.dart`) maps routes to screens. Update here when adding new features.
- **State Management**: Use **BLoC pattern** (`flutter_bloc`) - no `setState` for business logic. BLoCs go in `presentation/bloc/` folder.
- **BLoC Structure**: Each feature has `<feature>_event.dart`, `<feature>_state.dart`, `<feature>_bloc.dart` files.
- **BLoC Registration**: Register BLoCs in `lib/core/di/dependency_injection.dart` using `getIt.registerFactory()`.
- **BLoC Usage**: Wrap screens with `BlocProvider`, use `BlocBuilder`/`BlocConsumer`/`BlocListener` for state handling.
- **Event Transformers**: Use `bloc_concurrency` transformers - `restartable()`, `sequential()`, `droppable()` for smart event processing.
- **UI conventions**: Use `ScreenUtil` for sizing (`.w`, `.h`, `.r`, `.sp`). Use `getVerticalSpacing()`/`getHorizontalSpacing()` from `lib/core/helpers/spacing.dart`. Reference `AppColors` and `AppStyles` constants.
- **Form validation**: Use `Validators` class (`lib/core/utils/validators.dart`) and `CustomTextField` widget (`lib/core/widgets/enhanced_text_field.dart`).
- **Logging**: Use `LoggerService` (`lib/core/utils/logger_service.dart`) for debug/info/warning/error logs.
- **Error handling**: Use `Either<Failure, T>` pattern from `dartz`. All repository methods return `Either` for explicit error handling.
- **Repository pattern**: Interfaces in `domain/repositories/`, implementations in `data/repositories/`. Inject via `get_it`.
- **Lifecycle safety**: BLoC handles state lifecycle. Only use `mounted` checks for navigation/SnackBars.

# Developer workflows & commands (explicit)
- Install dependencies:

```powershell
flutter pub get
```

- Run app locally:

```powershell
flutter run -d <device>
```

- Build (Android release):

```powershell
flutter build apk --release
```

- Run tests:

```powershell
flutter test
```

- Analyze code:

```powershell
flutter analyze
```

- Generate mocks (for testing):

```powershell
flutter pub run build_runner build
```

# Project-specific conventions & gotchas
- **Responsive sizing**: All numeric sizes use `.w`/`.h` (dimensions), `.r` (radius), `.sp` (text) from `flutter_screenutil`.
- **const constructors**: Use `const` for stateless widgets and immutable values to optimize rebuilds.
- **Mounted checks**: Always add `if (!mounted) return;` before `setState()` in async callbacks to prevent disposed widget errors.
- **Null safety**: Check navigation results: `if (result == true && mounted)` before proceeding.
- **Colors & styles**: Never hard-code colors/fonts. Use `AppColors.*` and `AppStyles.*` constants.
- **Theme support**: MaterialApp has a theme defined in `main.dart` using `AppColors` and `AppStyles`.
- **Accessibility**: Add `Semantics` labels to interactive widgets and images.
- **Animations**: Prefer `AnimationController` with `AnimatedBuilder` over multiple nested `TweenAnimationBuilder`s for better performance.

# Integration points & dependencies
- **Packages** (see `pubspec.yaml`):
  - `go_router`: Declarative routing
  - `flutter_screenutil`: Responsive sizing
  - `shared_preferences`: Local key-value storage
  - `get_it`: Dependency injection
  - `logger`: Structured logging
  - `equatable`: Value equality for entities
  - `dartz`: Functional programming (Either, Option)
  - `flutter_bloc`, `bloc`, `bloc_concurrency`: BLoC pattern state management
  - `mockito`, `build_runner`, `bloc_test`: Testing utilities
- **Platform support**: Multi-platform scaffolding exists (`android/`, `ios/`, `windows/`, `linux/`, `macos/`). Native configs are default Flutter templates.

# Examples (codebase references)
- **New feature setup**:
  1. Create `lib/features/<feature_name>/domain/entities/<entity>.dart`
  2. Create `lib/features/<feature_name>/domain/repositories/<repo>_repository.dart` (interface)
  3. Create `lib/features/<feature_name>/domain/usecases/<usecase>.dart`
  4. Create `lib/features/<feature_name>/data/repositories/<repo>_repository_impl.dart`
  5. Create `lib/features/<feature_name>/presentation/bloc/<feature>_event.dart`, `<feature>_state.dart`, `<feature>_bloc.dart`
  6. Register in `lib/core/di/dependency_injection.dart`
  7. Create `lib/features/<feature_name>/presentation/screens/<screen>.dart`
  8. Add route in `lib/core/routes/app_router_config.dart`

- **Assessment feature example**: See `lib/features/assessment/` for complete DDD structure with BLoC:
  - Entity: `domain/entities/assessment.dart`
  - Repository interface: `domain/repositories/assessment_repository.dart`
  - Use cases: `domain/usecases/assessment_usecases.dart`
  - Implementation: `data/repositories/assessment_repository_impl.dart`
  - BLoC: `presentation/bloc/assessment_bloc.dart` (with events, states)
  - Screen: `presentation/screens/test_your_skills_screen.dart`

- **Authentication feature example**: See `lib/features/authentication/` for BLoC pattern:
  - BLoC: `presentation/bloc/authentication_bloc.dart` (with events, states)
  - Screen: `presentation/screens/login_screen.dart` using BlocProvider

- **Dependency injection**: Register repositories and BLoCs in `lib/core/di/dependency_injection.dart`:
  ```dart
  // Repository
  getIt.registerLazySingleton<IMyRepository>(
    () => MyRepositoryImpl(getIt<IPreferencesRepository>()),
  );
  
  // Use case
  getIt.registerLazySingleton(() => MyUseCase(getIt()));
  
  // BLoC (use factory for proper lifecycle)
  getIt.registerFactory(() => MyBloc(
    myUseCase: getIt(),
  ));
  ```

- **BLoC in screen**:
  ```dart
  class MyScreen extends StatelessWidget {
    @override
    Widget build(BuildContext context) {
      return BlocProvider(
        create: (context) => getIt<MyBloc>()..add(const LoadData()),
        child: BlocConsumer<MyBloc, MyState>(
          listener: (context, state) {
            if (state is MySuccess) {
              context.push(AppRoutes.next);
            } else if (state is MyError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message)),
              );
            }
          },
          builder: (context, state) {
            if (state is MyLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is MyLoaded) {
              return MyDataWidget(data: state.data);
            }
            return const SizedBox();
          },
        ),
      );
    }
  }
  ```

- **Trigger BLoC event**:
  ```dart
  onPressed: () => context.read<MyBloc>().add(const MyEvent()),
  ```

# Safe edits and tests
- **UI changes**: Run `flutter run` and verify on phone-sized device (360x800 design size).
- **Repository changes**: Write unit tests using `mockito`. Repository interfaces enable easy mocking.
- **Breaking changes**: Search for usages (`Ctrl+Shift+F`) before renaming entities or repository methods.
- **Migration**: Legacy code in `lib/presentation/` will be gradually migrated to `lib/features/`. Keep old screens functional until migration is complete.

# When to ask the human
- Adding native platform permissions (Android manifest, iOS Info.plist) — ask before editing.
- Introducing new external services (API clients, analytics) — confirm architecture approach.
- Major dependency upgrades — verify compatibility first.
- Changing core navigation or DI structure — these are foundational decisions.

# Contact / follow-ups
- For unclear instructions, request a walkthrough with specific file paths.
- Keep suggestions concrete: include file locations and one-paragraph reasoning.
- When proposing large refactorings, provide a step-by-step migration plan.

