import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salsa_app/features/home/model/categories_model.dart';
import 'package:salsa_app/features/home/model/random_meals_model.dart';
import 'package:salsa_app/features/home/repo/home_repo.dart';
import 'package:salsa_app/features/home/view_model/cubit/home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeState.initial());

  static HomeCubit get(context) => BlocProvider.of(context);
  HomeRepo homeRepo = HomeRepo();

  Future<void> getCategories() async {
    try {
      emit(state.copyWith(isCategoriesLoading: true, categoriesError: null));

      List<Category> categories = await homeRepo.getCategories();

      emit(
        state.copyWith(
          categories: categories,
          isCategoriesLoading: false,
          categoriesError: null,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          isCategoriesLoading: false,
          categoriesError: e.toString(),
        ),
      );
    }
  }

  Future<void> getRandomMeals() async {
    try {
      emit(state.copyWith(isRandomMealsLoading: true, randomMealsError: null));

      List<Meal> meals = await homeRepo.getRandomMeals();

      emit(
        state.copyWith(
          meals: meals,
          isRandomMealsLoading: false,
          randomMealsError: null,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          isRandomMealsLoading: false,
          randomMealsError: e.toString(),
        ),
      );
    }
  }
}
