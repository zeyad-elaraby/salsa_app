import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salsa_app/features/meal_details/model/meal_details_model.dart';
import 'package:salsa_app/features/meal_details/view_model/cubit/meal_details_cubit.dart';
import 'package:salsa_app/features/meal_details/view_model/cubit/meal_details_state.dart';

class MealDetailsScreen extends StatelessWidget {
  final String mealId;

  const MealDetailsScreen({super.key, required this.mealId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MealDetailsCubit()..getMealDetails(mealId),
      child: Scaffold(
        body: BlocBuilder<MealDetailsCubit, MealDetailsState>(
          builder: (context, state) {
            if (state is MealDetailsLoading) {
              return const Center(
                child: CircularProgressIndicator(color: Colors.orange),
              );
            }

            if (state is MealDetailsError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.error_outline,
                      color: Colors.red,
                      size: 60,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Error Loading Meal',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 8),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 32),
                      child: Text(
                        state.message,
                        textAlign: TextAlign.center,
                        style: const TextStyle(color: Colors.grey),
                      ),
                    ),
                  ],
                ),
              );
            }

            if (state is MealDetailsSuccess) {
              final meal = state.meals;
              return CustomScrollView(
                slivers: [
                  SliverAppBar(
                    expandedHeight: 300,
                    pinned: true,
                    backgroundColor: Colors.orange,
                    flexibleSpace: FlexibleSpaceBar(
                      title: Text(
                        meal.strMeal ?? 'Meal Details',
                        style: const TextStyle(
                          color: Colors.white70,
                          fontWeight: FontWeight.bold,
                          shadows: [
                            Shadow(
                              offset: Offset(0, 1),
                              blurRadius: 3.0,
                              color: Colors.black45,
                            ),
                          ],
                        ),
                      ),
                      background: Stack(
                        fit: StackFit.expand,
                        children: [
                          Image.network(
                            meal.strMealThumb ?? '',
                            fit: BoxFit.cover,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Colors.transparent,
                                  Colors.black.withOpacity(0.7),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          buildCategoryChips(meal),
                          const SizedBox(height: 24),
                          buildIngredientsSection(context, meal),
                          const SizedBox(height: 24),
                          buildInstructionsSection(context, meal),
                          const SizedBox(height: 24),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }

  Widget buildCategoryChips(MealDetails meal) {
    return Wrap(
      spacing: 8,
      children: [
        if (meal.strCategory != null)
          Chip(
            avatar: const Icon(Icons.category, size: 18),
            label: Text(meal.strCategory!),
            backgroundColor: Colors.orange.shade100,
          ),
        if (meal.strArea != null)
          Chip(
            avatar: const Icon(Icons.public, size: 18),
            label: Text(meal.strArea!),
            backgroundColor: Colors.blue.shade100,
          ),
        if (meal.strTags != null && meal.strTags!.isNotEmpty)
          Chip(
            avatar: const Icon(Icons.tag, size: 18),
            label: Text(meal.strTags!.trim()),
            backgroundColor: Colors.green.shade100,
          ),
      ],
    );
  }

  Widget buildIngredientsSection(BuildContext context, MealDetails meal) {
    final ingredients = getIngredientsList(meal);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.shopping_basket, color: Colors.orange.shade700),
            const SizedBox(width: 8),
            Text(
              'Ingredients',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.orange.shade700,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Container(
          decoration: BoxDecoration(
            color: Colors.grey.shade50,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.shade200),
          ),
          child: ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.all(16),
            itemCount: ingredients.length,
            separatorBuilder: (context, index) => const Divider(height: 16),
            itemBuilder: (context, index) {
              final ingredient = ingredients[index];
              return Row(
                children: [
                  Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: Colors.orange,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      ingredient['ingredient']!,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Text(
                    ingredient['measure']!,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey.shade600,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }

  Widget buildInstructionsSection(BuildContext context, MealDetails meal) {
    if (meal.strInstructions == null || meal.strInstructions!.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.restaurant_menu, color: Colors.orange.shade700),
            const SizedBox(width: 8),
            Text(
              'Instructions',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.orange.shade700,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.grey.shade50,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.shade200),
          ),
          child: Text(
            meal.strInstructions!,
            style: const TextStyle(
              fontSize: 15,
              height: 1.6,
              color: Colors.black87,
            ),
          ),
        ),
      ],
    );
  }

  List<Map<String, String>> getIngredientsList(MealDetails meal) {
    final List<Map<String, String>> ingredients = [];

    final ingredientsList = [
      meal.strIngredient1,
      meal.strIngredient2,
      meal.strIngredient3,
      meal.strIngredient4,
      meal.strIngredient5,
      meal.strIngredient6,
      meal.strIngredient7,
      meal.strIngredient8,
      meal.strIngredient9,
      meal.strIngredient10,
      meal.strIngredient11,
      meal.strIngredient12,
      meal.strIngredient13,
      meal.strIngredient14,
      meal.strIngredient15,
    ];

    final measuresList = [
      meal.strMeasure1,
      meal.strMeasure2,
      meal.strMeasure3,
      meal.strMeasure4,
      meal.strMeasure5,
      meal.strMeasure6,
      meal.strMeasure7,
      meal.strMeasure8,
      meal.strMeasure9,
      meal.strMeasure10,
      meal.strMeasure11,
      meal.strMeasure12,
      meal.strMeasure13,
      meal.strMeasure14,
      meal.strMeasure15,
    ];

    for (int i = 0; i < ingredientsList.length; i++) {
      if (ingredientsList[i] != null &&
          ingredientsList[i]!.isNotEmpty &&
          ingredientsList[i]!.trim().isNotEmpty) {
        ingredients.add({
          'ingredient': ingredientsList[i]!,
          'measure': measuresList[i] ?? '',
        });
      }
    }

    return ingredients;
  }
}
