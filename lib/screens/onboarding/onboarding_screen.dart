import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
import '../../widgets/widgets.dart';
import 'package:lorem_ipsum/lorem_ipsum.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  late RiveAnimationController _buttonAnimationController;
  bool isSignInDialogShown = false;
  String lorem = loremIpsum(words: 25);

  @override
  void initState() {
    super.initState();
    _buttonAnimationController = OneShotAnimation('active', autoplay: false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          const RiveAnimation.asset(
            'assets/RiveAssets/shapes.riv',
            fit: BoxFit.cover,
          ),
          Positioned.fill(
              child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 20, sigmaY: 10),
          )),
          Positioned(
              width: MediaQuery.of(context).size.width * 1.7,
              bottom: 200,
              left: 100,
              child: Image.asset('assets/Backgrounds/Spline.png')),
          Positioned.fill(
              child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
            child: const SizedBox(),
          )),
          AnimatedPositioned(
            duration: const Duration(milliseconds: 240),
            top: isSignInDialogShown ? -50 : 0,
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Spacer(
                      flex: 2,
                    ),
                    SizedBox(
                      width: 300,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Welcome',
                            style: TextStyle(
                              fontSize: 60,
                              fontFamily: 'Poppins',
                              height: 1.2,
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Text(lorem),
                        ],
                      ),
                    ),
                    const Spacer(flex: 2),
                    AnimatedButton(
                      buttonAnimationController: _buttonAnimationController,
                      press: () {
                        _buttonAnimationController.isActive = true;
                        Future.delayed(
                          const Duration(milliseconds: 800),
                              () {
                            setState(() {
                              isSignInDialogShown = true;
                            });
                            SignInDialog(
                              context,
                              onClosed: (_) {
                                setState(() {
                                  isSignInDialogShown = false;
                                });
                              },
                            );
                          },
                        );

                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 24.0),
                      child: Text(
                          lorem,
                      textAlign: TextAlign.center,),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

