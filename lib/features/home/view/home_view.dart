import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salsa_app/features/home/view_model/cubit/home_cubit.dart';
import 'package:salsa_app/features/home/widgets/home_view_body.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (context) => HomeCubit()..getCategories()..getRandomMeals(), child: HomeViewBody());
  }
}
