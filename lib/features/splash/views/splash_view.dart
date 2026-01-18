import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:salsa_app/features/home/view/home_view.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    executeNavigation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(child: Image.asset("assets/images/app_logo.png",height: 100,width: 100,)),
          Text("Salsa",style: TextStyle(color: Colors.red,fontSize: 30,fontWeight: FontWeight.bold),),
          ],
        ),
      ),
    );
  }

  void executeNavigation() {
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomeView()),
      );
    });
  }
}
