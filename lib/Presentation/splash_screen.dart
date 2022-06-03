import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void goToHome() async {
    await Future.delayed(Duration(seconds: 1));
    context.go("/home");
  }

  @override
  void initState() {
    super.initState();
    goToHome();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("medFind"),
      ),
    );
  }
}
