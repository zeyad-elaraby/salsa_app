import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:salsa_app/core/config/dio_helper.dart';
import 'package:salsa_app/core/services/custom_bloc_observer.dart';
import 'package:salsa_app/features/home/view/home_view.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  Bloc.observer = MyBlocObserver();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,

      child: MaterialApp(debugShowCheckedModeBanner: false, home: HomeView()),
    );
  }
}
