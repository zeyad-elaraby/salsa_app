import 'package:dio/dio.dart';
import 'package:salsa_app/core/config/dio_helper.dart';
import 'package:salsa_app/core/utils/api_constant.dart';
import 'package:salsa_app/features/category_details/model/category_details_model.dart';

class CategoryDetailsRepo {
  getCategoryDetails({required String categoryName}) async {
    Response response = await DioHelper.getData(
      url: ApiConstant.categoryDetails,
      query: {"c": categoryName},
    );

    List<CategoryMeal> categoryMeals = CategoryDetails.fromJson(
      response.data,
    ).meals!;
    return categoryMeals;
  }
}
