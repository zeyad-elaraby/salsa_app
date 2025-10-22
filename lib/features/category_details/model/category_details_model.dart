class CategoryDetails {
  List<CategoryMeal>? meals;

  CategoryDetails({this.meals});

  CategoryDetails.fromJson(Map<String, dynamic> json) {
    if (json['meals'] != null) {
      meals = <CategoryMeal>[];
      json['meals'].forEach((v) {
        meals!.add(new CategoryMeal.fromJson(v));
      });
    }
  }

}

class CategoryMeal {
  String? strMeal;
  String? strMealThumb;
  String? idMeal;

  CategoryMeal({this.strMeal, this.strMealThumb, this.idMeal});

  CategoryMeal.fromJson(Map<String, dynamic> json) {
    strMeal = json['strMeal'];
    strMealThumb = json['strMealThumb'];
    idMeal = json['idMeal'];
  }

}