import 'package:dio/dio.dart';
import 'package:salsa_app/core/config/dio_helper.dart';
import 'package:salsa_app/core/utils/api_constant.dart';
import 'package:salsa_app/features/meal_details/model/meal_details_model.dart';

class MealDetailsRepo {
  getMealDetails(String id) async {
    Response response = await DioHelper.getData(
      url: ApiConstant.mealDetails,
      query: {"i": id},
    );
    MealDetails mealModel = (MealDetailsModel.fromJson(
      response.data,
    ).meals!.first);
    return mealModel;
  }
}
