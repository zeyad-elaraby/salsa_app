import 'package:salsa_app/features/meal_details/model/meal_details_model.dart';

sealed class MealDetailsState {}

final class MealDetailsInitial extends MealDetailsState {}

final class MealDetailsLoading extends MealDetailsState {}

final class MealDetailsSuccess extends MealDetailsState {
  final MealDetails meals;
  MealDetailsSuccess({required this.meals});
}

final class MealDetailsError extends MealDetailsState {
  final String message;
  MealDetailsError({required this.message});
}
