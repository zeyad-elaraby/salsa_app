import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salsa_app/features/category_details/model/category_details_model.dart';
import 'package:salsa_app/features/category_details/repo/category_details_repo.dart';
import 'package:salsa_app/features/category_details/view_model/cubit/category_details_state.dart';

class CategoryDetailsCubit extends Cubit<CategoryDetailsState> {
  CategoryDetailsCubit() : super(CategoryDetailsInitial());
  CategoryDetailsRepo categoryDetailsRepo = CategoryDetailsRepo();
  getCategoryDetails(String categoryName) async {
    try {
      emit(CategoryDetailsLoading());
      List<CategoryMeal> categoryMeals = await categoryDetailsRepo
          .getCategoryDetails(categoryName: categoryName);

      emit(CategoryDetailsSuccess(categoryMeals));
    } catch (e) {
      emit(CategoryDetailsError(e.toString()));
    }
  }
}
