import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salsa_app/features/category_details/view_model/cubit/category_details_cubit.dart';
import 'package:salsa_app/features/category_details/view_model/cubit/category_details_state.dart';
import 'package:salsa_app/features/category_details/widgets/meal_item.dart';

class CategoryDetails extends StatelessWidget {
  const CategoryDetails({super.key, required this.categoryName});
  final String categoryName;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          CategoryDetailsCubit()..getCategoryDetails(categoryName),
      child: Scaffold(
        body: BlocBuilder<CategoryDetailsCubit, CategoryDetailsState>(
          builder: (context, state) {
            if (state is CategoryDetailsLoading) {
              return CircularProgressIndicator();
            }
            if (state is CategoryDetailsError) {
              return Text(state.message);
            }
            if (state is CategoryDetailsSuccess) {
              return ListView.builder(
                itemCount: state.categoryDetails.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: MealItem(meal: state.categoryDetails[index]),
                  );
                },
              );
            }
            return Container();
          },
        ),
      ),
    );
  }
}
