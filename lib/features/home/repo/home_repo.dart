import 'package:dio/dio.dart';
import 'package:salsa_app/core/config/dio_helper.dart';
import 'package:salsa_app/core/utils/api_constant.dart';
import 'package:salsa_app/features/home/model/categories_model.dart';
import 'package:salsa_app/features/home/model/random_meals_model.dart';

class HomeRepo {
  getCategories() async {
    Response response = await DioHelper.getData(url: ApiConstant.categories);
    List<Category> categories = (CategoriesModel.fromJson(
      response.data,
    )).categories!;
    return categories;
  }

  getRandomMeals() async {
    Response response = await DioHelper.getData(url: ApiConstant.randomMeals);
    List<Meal> randomMeals = (RandomMealsModel.fromJson(response.data)).meals!;
    return randomMeals;
  }
}
