import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:salsa_app/features/home/model/categories_model.dart';
import 'package:salsa_app/features/home/model/random_meals_model.dart';
import 'package:salsa_app/features/home/view_model/cubit/home_cubit.dart';
import 'package:salsa_app/features/home/view_model/cubit/home_state.dart';
import 'package:salsa_app/features/home/widgets/category_item.dart';
import 'package:salsa_app/features/home/widgets/random_meal_item.dart';
import 'package:skeletonizer/skeletonizer.dart';

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SafeArea(
        child: BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            return CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.all(20.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Hello, Food Lover! 👋',
                          style: TextStyle(
                            fontSize: 28.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        SizedBox(height: 8.h),
                        Text(
                          'What would you like to cook today?',
                          style: TextStyle(
                            fontSize: 16.sp,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                SliverToBoxAdapter(child: _buildRandomMealSection(state)),

                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(20.w, 24.h, 20.w, 16.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Categories',
                          style: TextStyle(
                            fontSize: 24.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        TextButton(
                          onPressed: () {},
                          child: Text(
                            'See All',
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: Colors.orange[700],
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                _buildCategoriesSection(state),

                SliverToBoxAdapter(child: SizedBox(height: 20.h)),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildRandomMealSection(HomeState state) {
    if (state.isRandomMealsLoading) {
      return _buildRandomMealSkeleton();
    } else if (state.randomMealsError != null) {
      return _buildErrorWidget(state.randomMealsError!, isRandomMeal: true);
    } else if (state.meals != null && state.meals!.isNotEmpty) {
      return RandomMealItem(meal: state.meals!.first);
    }
    return const SizedBox.shrink();
  }

  Widget _buildCategoriesSection(HomeState state) {
    if (state.isCategoriesLoading) {
      return _buildCategoriesGridSkeleton();
    } else if (state.categoriesError != null) {
      return SliverToBoxAdapter(
        child: _buildErrorWidget(state.categoriesError!, isRandomMeal: false),
      );
    } else if (state.categories != null && state.categories!.isNotEmpty) {
      return _buildCategoriesGrid(state.categories!);
    }
    return const SliverToBoxAdapter(child: SizedBox.shrink());
  }

  Widget _buildRandomMealSkeleton() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Skeletonizer(
        enabled: true,
        child: Container(
          height: 240.h,
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
    );
  }

  Widget _buildCategoriesGrid(List<Category> categories) {
    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      sliver: SliverGrid(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.85,
          crossAxisSpacing: 16.w,
          mainAxisSpacing: 16.h,
        ),
        delegate: SliverChildBuilderDelegate((context, index) {
          return CategoryItem(category: categories[index], onTap: () {});
        }, childCount: categories.length),
      ),
    );
  }

  Widget _buildCategoriesGridSkeleton() {
    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      sliver: SliverGrid(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.85,
          crossAxisSpacing: 16.w,
          mainAxisSpacing: 16.h,
        ),
        delegate: SliverChildBuilderDelegate((context, index) {
          return Skeletonizer(
            enabled: true,
            child: CategoryItem(
              category: Category(
                strCategory: 'Loading...',
                strCategoryThumb: '',
                idCategory: '',
              ),
            ),
          );
        }, childCount: 6),
      ),
    );
  }

  Widget _buildErrorWidget(String message, {required bool isRandomMeal}) {
    return Padding(
      padding: EdgeInsets.all(20.w),
      child: Container(
        padding: EdgeInsets.all(20.w),
        decoration: BoxDecoration(
          color: Colors.red[50],
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.red[200]!),
        ),
        child: Column(
          children: [
            Icon(Icons.error_outline, size: 48, color: Colors.red[400]),
            SizedBox(height: 12.h),
            Text(
              isRandomMeal
                  ? 'Failed to load featured meal'
                  : 'Failed to load categories',
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
                color: Colors.red[900],
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              message,
              style: TextStyle(fontSize: 14.sp, color: Colors.red[700]),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
