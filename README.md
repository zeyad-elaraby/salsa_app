# Salsa App Documentation

## Introduction
Salsa App is a cross-platform mobile application built with Flutter, designed to help users explore meal categories and recipes from around the world. It leverages the [TheMealDB](https://www.themealdb.com/api.php) API to provide rich data on categories and detailed instructions for meal preparation. The app offers an intuitive and visually appealing interface, supporting both Android and iOS (and other Flutter platforms).

## Main Features
- **Home Page**: Welcomes users and displays a featured random recipe.
- **Categories Browser**: Browse food categories with images and names.
- **Category Details**: View all meals under a selected category.
- **Meal Details**: Full recipe, ingredients, measures, and instructions for a selected meal.
- **Responsive UI**: Smooth grid, list layouts and loading skeletons.
- **State Management**: Uses BLoC for predictable, scalable state handling.
- **API Integration**: Uses Dio for HTTP API requests with robust error handling.
- **Theming**: Clean Material UI, customizable and easily maintainable.

## Quick Start
### Prerequisites
- [Flutter](https://flutter.dev/docs/get-started/install) (SDK, channel >= stable)
- Dart 3.8+

Install dependencies:
```sh
flutter pub get
```
Run the app:
```sh
flutter run
```

## Project Structure
```text
lib/
  core/
    config/     # API/Dio helpers, custom BLoC observer
    services/   # App-wide utilities
    utils/      # Constants, colors, styles, validator
    widgets/    # Shared reusable widgets
  features/
    home/               # Home screen logic, widgets
    category_details/   # Display meal list for a category
    meal_details/       # Detailed recipe page
  main.dart
```
- **android/, ios/, web/, linux/, macos/, windows/**: Platform-specific files and resources.
- **test/**: Unit and widget tests.

## Core Dependencies
- `flutter_bloc`: State management
- `dio`: HTTP client
- `pretty_dio_logger`: Network debug logs
- `shared_preferences`: Simple key-value storage
- `flutter_screenutil`: Responsive layouts
- `skeletonizer`: Loading skeletons
- `awesome_snackbar_content`: User notifications

_(See `pubspec.yaml` for exact versions)_

## How It Works
- **Startup:** Initializes Dio for API, sets up custom bloc observer, and launches `HomeView`.
- **Home Screen:** Loads categories and a random meal. Tapping a category navigates to its details; tapping a meal opens its recipe.
- **Category Details:** Lists meals in a selected category with navigation to detailed recipe pages.
- **Meal Details:** Fetches and displays all instructions, video link, ingredients, and more for a given recipe.
- **Error Handling and Loading Skeletons:** Friendly skeletons/UI for slow networks and detailed error messages.

## Customization & Theming
- Modify `lib/core/utils/app_colors.dart`, `app_text_styles.dart`, and related files for theme and branding changes.
- Add more features by following the modular structure in `features/`.

## Contributing
Please open issues or submit PRs for bug reports or feature requests.

## License
Not specified. Please add your license in a `LICENSE` file if open source.

---
_This documentation was generated programmatically. For further custom docs or internal technical overviews, supplement as needed!_
