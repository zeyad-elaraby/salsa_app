import 'package:salsa_app/features/category_details/model/category_details_model.dart';

sealed class CategoryDetailsState {}

final class CategoryDetailsInitial extends CategoryDetailsState {}

final class CategoryDetailsLoading extends CategoryDetailsState {}

final class CategoryDetailsSuccess extends CategoryDetailsState {
  final List<CategoryMeal> categoryDetails;
  CategoryDetailsSuccess(this.categoryDetails);
}

final class CategoryDetailsError extends CategoryDetailsState {
  final String message;
  CategoryDetailsError(this.message);
}
