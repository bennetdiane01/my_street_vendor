import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:my_street_vendor/ui/pages/general/login.dart';
class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
        duration: 3000,
        splash: Lottie.asset('assets/lottie/logo_amination.json'),
        nextScreen: LoginPage(),
        splashTransition: SplashTransition.fadeTransition,
        //pageTransitionType: PageTransitionType.scale,
        backgroundColor: Colors.blue
    );
  }
}
