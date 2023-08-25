import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

import '../../widgets/widgets.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  late RiveAnimationController _buttonAnimationController;

  @override
  void initState() {
    super.initState();
    _buttonAnimationController = OneShotAnimation('active',autoplay: false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const RiveAnimation.asset('assets/RiveAssets/shapes.riv',
          fit: BoxFit.cover,),
          Positioned.fill(child: BackdropFilter(filter: ImageFilter.blur(sigmaX: 20, sigmaY: 10),
            )),
          Positioned(
            width: MediaQuery.of(context).size.width*1.7,
              bottom: 200,
              left: 100,
              child: Image.asset('assets/Backgrounds/Spline.png')),

          Positioned.fill(child: BackdropFilter(filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
            child: const SizedBox(),)),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Spacer(),
                  SizedBox(
                    width: 260,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [Text('Learn design & code', style: TextStyle(
                        fontSize: 60,
                        fontFamily: 'Poppins',
                        height: 1.2,
                      ),),
                      SizedBox(height: 15,), 
                      Text('Don’t skip design. Learn design and code, by building real apps with Flutter and Swift. Complete courses about the best tools.'),
                      ],
                    ),
                  ),
                  Spacer(),
                  AnimatedButton(buttonAnimationController: _buttonAnimationController, press: (){_buttonAnimationController.isActive = true;},),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 24.0),
                    child: Text('Purchase includes access to 30+ courses, 240+ premium tutorials, 120+ hours of videos, source files and certificates.'),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}


