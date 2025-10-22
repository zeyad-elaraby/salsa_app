import 'package:salsa_app/features/home/model/categories_model.dart';
import 'package:salsa_app/features/home/model/random_meals_model.dart';

class HomeState {
  final List<Category>? categories;
  final List<Meal>? meals;
  final bool isCategoriesLoading;
  final bool isRandomMealsLoading;
  final String? categoriesError;
  final String? randomMealsError;

  HomeState({
    this.categories,
    this.meals,
    this.isCategoriesLoading = false,
    this.isRandomMealsLoading = false,
    this.categoriesError,
    this.randomMealsError,
  });

  factory HomeState.initial() => HomeState();

  HomeState copyWith({
    List<Category>? categories,
    List<Meal>? meals,
    bool? isCategoriesLoading,
    bool? isRandomMealsLoading,
    String? categoriesError,
    String? randomMealsError,
  }) {
    return HomeState(
      categories: categories ?? this.categories,
      meals: meals ?? this.meals,
      isCategoriesLoading: isCategoriesLoading ?? this.isCategoriesLoading,
      isRandomMealsLoading: isRandomMealsLoading ?? this.isRandomMealsLoading,
      categoriesError: categoriesError ?? this.categoriesError,
      randomMealsError: randomMealsError ?? this.randomMealsError,
    );
  }
}
