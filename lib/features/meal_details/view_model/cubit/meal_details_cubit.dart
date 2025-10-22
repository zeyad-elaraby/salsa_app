import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salsa_app/features/meal_details/model/meal_details_model.dart';
import 'package:salsa_app/features/meal_details/repo/meal_details_repo.dart';
import 'package:salsa_app/features/meal_details/view_model/cubit/meal_details_state.dart';

class MealDetailsCubit extends Cubit<MealDetailsState> {
  MealDetailsCubit() : super(MealDetailsInitial());
  MealDetailsRepo mealDetailsRepo = MealDetailsRepo();
  getMealDetails(String id) async {
    try {
      emit(MealDetailsLoading());
      MealDetails meals = await mealDetailsRepo.getMealDetails(id);
      emit(MealDetailsSuccess(meals: meals));
    } catch (e) {
      emit(MealDetailsError(message: e.toString()));
    }
  }
}
