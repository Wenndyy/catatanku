import 'package:catatanku/shared/theme.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart' show Lottie;

import 'package:catatanku/widgets/home_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with TickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(seconds: (5)),
      vsync: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkColor,
      body: Lottie.asset(
        'assets/splash_lottie.json',
        controller: _animationController,
        height: MediaQuery.of(context).size.height * 1,
        animate: true,
        onLoaded: (composition) {
          _animationController
            ..duration = composition.duration
            ..forward().whenComplete(() {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const HomePage()),
              );
            });
        },
      ),
    );
  }
}
