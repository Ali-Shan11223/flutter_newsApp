import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_news_app/view/home_screen.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const HomeScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/splash_pic.jpg',
            height: size.height * 0.3,
            fit: BoxFit.contain,
          ),
          SizedBox(
            height: size.height * 0.04,
          ),
          Text(
            'TOP HEADLINES',
            style: GoogleFonts.antic(
                letterSpacing: 0.6,
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.grey.shade700),
          ),
          SizedBox(
            height: size.height * 0.04,
          ),
          const SpinKitChasingDots(
            color: Colors.blue,
          )
        ],
      ),
    );
  }
}
